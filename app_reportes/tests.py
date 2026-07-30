import base64
import os
import tempfile
from datetime import date
from pathlib import Path

from django.core import mail
from django.core.files.uploadedfile import SimpleUploadedFile
from django.test import RequestFactory, SimpleTestCase, TestCase, override_settings
from django.http import HttpRequest

from app_reportes.models import InspeccionCabecera, ItemInspeccion
from app_reportes.views import (
    construir_ruta_pdf_inspeccion,
    enviar_inspeccion_evidencia,
    guardar_firma_inspeccion,
    lista_inspecciones,
)


@override_settings(MEDIA_ROOT=tempfile.mkdtemp(), EMAIL_BACKEND='django.core.mail.backends.locmem.EmailBackend')
class ExportacionPdfTests(SimpleTestCase):
    def test_construir_ruta_pdf_inspeccion_crea_directorio(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            ruta = construir_ruta_pdf_inspeccion(42, base_dir=temp_dir)

            self.assertTrue(os.path.isdir(os.path.join(temp_dir, 'Desktop', 'Reportes-SGI', 'Inspecciones')))
            self.assertTrue(ruta.endswith('.pdf'))
            self.assertIn('Inspeccion_42_', os.path.basename(ruta))


class ListaInspeccionesTests(TestCase):
    def setUp(self):
        self.factory = RequestFactory()

    def test_lista_inspecciones_filtra_auditados_y_no_auditados(self):
        auditada = InspeccionCabecera.objects.create(
            tipo_inspeccion='Formal',
            faena='Faena auditada',
            lugar='Lugar auditado',
            fecha_inspeccion='2026-01-01',
            hora_inspeccion='08:00:00',
            realizada_por='Persona',
            notificado_a='Jefe',
            correo_usuario_creador='test@example.com',
        )
        no_auditada = InspeccionCabecera.objects.create(
            tipo_inspeccion='Formal',
            faena='Faena pendiente',
            lugar='Lugar pendiente',
            fecha_inspeccion=None,
            hora_inspeccion=None,
            realizada_por='Persona',
            notificado_a='Jefe',
            correo_usuario_creador='test@example.com',
        )

        request = HttpRequest()
        request.GET = {'filtro': 'auditados'}
        response = lista_inspecciones(request)
        self.assertEqual(response.status_code, 200)
        inspecciones_auditadas = list(InspeccionCabecera.objects.filter(fecha_inspeccion__isnull=False, hora_inspeccion__isnull=False))
        self.assertIn(auditada, inspecciones_auditadas)
        self.assertNotIn(no_auditada, inspecciones_auditadas)

        request = HttpRequest()
        request.GET = {'filtro': 'no_auditados'}
        response = lista_inspecciones(request)
        self.assertEqual(response.status_code, 200)
        inspecciones_no_auditadas = list(InspeccionCabecera.objects.filter(fecha_inspeccion__isnull=True) | InspeccionCabecera.objects.filter(hora_inspeccion__isnull=True))
        self.assertIn(no_auditada, inspecciones_no_auditadas)
        self.assertNotIn(auditada, inspecciones_no_auditadas)


class EvidenciaInspeccionTests(TestCase):
    def setUp(self):
        self.factory = RequestFactory()
        self.inspeccion = InspeccionCabecera.objects.create(
            tipo_inspeccion='Formal',
            faena='Faena prueba',
            lugar='Lugar prueba',
            fecha_inspeccion='2026-01-01',
            hora_inspeccion='08:00:00',
            realizada_por='Persona prueba',
            notificado_a='Jefe prueba',
            correo_usuario_creador='test@example.com',
        )
        self.item = ItemInspeccion.objects.create(
            inspeccion=self.inspeccion,
            numero_item=1,
            observaciones='Observación de prueba',
            grado_riesgo='A',
            recomendaciones='Recomendación de prueba',
            responsable_accion='Responsable prueba',
            fecha_cumplimiento='2026-01-10',
            cumplimiento='PENDIENTE',
        )

    def test_subir_evidencia_guarda_archivo_y_actualiza_cumplimiento(self):
        archivo = SimpleUploadedFile('evidencia.pdf', b'contenido', content_type='application/pdf')
        request = self.factory.post(
            f'/enviar_inspeccion_evidencia/{self.item.id}/',
            {'id_inspeccion': str(self.inspeccion.id), 'evidencia': archivo},
            format='multipart',
        )

        response = enviar_inspeccion_evidencia(request, self.item.id)

        self.assertEqual(response.status_code, 200)
        self.item.refresh_from_db()
        self.assertEqual(self.item.cumplimiento, 'SI')
        self.assertTrue(self.item.evidencia_cierre)

    def test_enviar_recordatorio_evidencias_envia_correo_con_plazo(self):
        self.inspeccion.fecha_inspeccion = date(2026, 1, 1)
        self.inspeccion.save(update_fields=['fecha_inspeccion'])

        enviado = enviar_recordatorio_evidencias(self.inspeccion)

        self.assertTrue(enviado)
        self.assertEqual(len(mail.outbox), 1)
        self.assertIn('7 días', mail.outbox[0].body)
        self.assertIn('Observación de prueba', mail.outbox[0].body)
        self.assertIn(self.inspeccion.correo_usuario_creador, mail.outbox[0].to)

    def test_guardar_firma_inspeccion_guarda_archivo_en_media(self):
        data = base64.b64encode(b'firma de prueba').decode('utf-8')
        request = self.factory.post(
            f'/inspecciones/{self.inspeccion.id}/guardar_firma/',
            {'firma_data': f'data:image/png;base64,{data}'}
        )

        response = guardar_firma_inspeccion(request, self.inspeccion.id)

        self.assertEqual(response.status_code, 200)
        self.inspeccion.refresh_from_db()
        self.assertTrue(self.inspeccion.firma_responsable)
