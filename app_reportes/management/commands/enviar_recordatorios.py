from django.core.management.base import BaseCommand
from django.core.mail import send_mail
from django.conf import settings
from datetime import date, timedelta
from app_reportes.models import ItemInspeccion, InspeccionCabecera

class Command(BaseCommand):
    help = 'Revisa los casos pendientes y envía un correo 3 días antes del vencimiento.'

    def handle(self, *args, **options):
        # Calculamos la fecha exacta dentro de 3 días a partir de hoy
        fecha_objetivo = date.today() + timedelta(days=3)
        
        # Buscamos los ítems que vencen exactamente ese día Y que sigan en estado 'PENDIENTE'
        items_por_vencer = ItemInspeccion.objects.filter(
            fecha_cumplimiento=fecha_objetivo,
            cumplimiento='PENDIENTE'
        )

        correos_enviados = 0

        for item in items_por_vencer:
            # Nos aseguramos de que el campo de correo no esté vacío
            email_destino = getattr(item.inspeccion, 'correo_usuario_creador', None)
            
            if email_destino:
                asunto = f"⚠️ ALERTA: Le quedan 3 días para presentar evidencia (Ítem {item.numero_item})"
                
                url_subir_evidencia = f"http://localhost:8000/inspecciones/evidencia_inspeccion/{item.inspeccion_id}"

                mensaje = f"""
Estimado/a,

Le recordamos que la inspección en {item.inspeccion.faena} está por vencer.

- Recomendación: {item.recomendaciones}
- Fecha Límite de Cumplimiento: {item.fecha_cumplimiento}

Por favor, ingrese al sistema para cargar la evidencia correspondiente y cerrar el caso:
{url_subir_evidencia}

Este es un correo automático, favor no responder directamente.
"""

                send_mail(
                    subject=asunto,
                    message=mensaje,
                    from_email=settings.DEFAULT_FROM_EMAIL,
                    recipient_list=[email_destino],
                    fail_silently=True
                )
                correos_enviados += 1

        self.stdout.write(self.style.SUCCESS(f'Proceso finalizado. Se enviaron {correos_enviados} recordatorios.'))