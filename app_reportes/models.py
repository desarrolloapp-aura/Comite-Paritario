from django.db import models
import uuid
# Create your models here.
#from django.contrib.auth.models import User # Por si deseas asociarlo al login de Google más adelante

class Usuario(models.Model):
    correo = models.TextField()
    counter = models.TextField()

class InspeccionCabecera(models.Model):
    # Información del sistema de gestión integrado (Metadatos fijos en el Word)
    codigo = models.CharField(max_length=50, default="SGI-P-16/R-03", editable=False)
    revision = models.IntegerField(default=16, editable=False)
    
    tipo_inspeccion = models.CharField(
        max_length=20, 
        choices=[('Formal', 'Formal'), ('Informal', 'Informal')],
        default='Formal'
    )
    faena = models.CharField(max_length=150, verbose_name="Faena")
    lugar = models.CharField(max_length=250, verbose_name="Lugar")
    fecha_inspeccion = models.DateField(null=True, blank=True, verbose_name="Fecha de Inspección")
    hora_inspeccion = models.TimeField(null=True, blank=True, verbose_name="Hora")
    
    # Personas involucradas
    realizada_por = models.CharField(max_length=150, verbose_name="Realizada por")
    notificado_a = models.CharField(max_length=150, verbose_name="Notificado a")
    
    # Auditoría interna del sistema
    fecha_creacion = models.DateTimeField(auto_now_add=True)
    hora_creacion = models.TimeField(auto_now_add=True)
    
    #nombre_usuario_creador = models.CharField(max_length=150, verbose_name="Usuario Creador")
    correo_usuario_creador = models.EmailField(max_length=50, verbose_name="Correo Usuario Creador")
    firma_responsable = models.FileField(upload_to='firma_inspecciones/', null=True, blank=True, verbose_name='Firma Responsable')

    token = models.UUIDField(default=uuid.uuid4, editable=False, unique=True)
    class Meta:
        verbose_name = "Inspección (Cabecera)"
        verbose_name_plural = "Inspecciones (Cabeceras)"
        ordering = ['-fecha_inspeccion']

    def __str__(self):
        return f"Inspección {self.id} - {self.faena} ({self.fecha_inspeccion})"


class ItemInspeccion(models.Model):

    OPCIONES_RIESGO = [
        ('A', 'A: ALTO'),
        ('B', 'B: MEDIO'),
        ('C', 'C: LEVE'),
    ]
    
    # Opciones de Cumplimiento
    OPCIONES_CUMPLIMIENTO = [
        ('SI', 'SI'),
        ('NO', 'NO'),
        ('PENDIENTE', 'PENDIENTE'),
    ]

    # Relación "Uno a Muchos": Cada ítem pertenece obligatoriamente a una cabecera de inspección
    inspeccion = models.ForeignKey(InspeccionCabecera, on_delete=models.CASCADE, related_name='items')
    
    # Campos de la tabla del documento
    numero_item = models.PositiveIntegerField(verbose_name="N° Ítem")
    observaciones = models.TextField(verbose_name="Observaciones")
    grado_riesgo = models.CharField(max_length=1, choices=OPCIONES_RIESGO, verbose_name="Grado de Riesgo")
    recomendaciones = models.TextField(verbose_name="Recomendaciones")
    responsable_accion = models.CharField(max_length=150, verbose_name="Nombre Responsable")
    fecha_cumplimiento = models.DateField(verbose_name="Fecha Límite de Cumplimiento")
    
    # Estado del hallazgo (para el control del Administrador y Cierre de casos)
    cumplimiento = models.CharField(
        max_length=10, 
        choices=OPCIONES_CUMPLIMIENTO, 
        default='PENDIENTE',
        verbose_name="Estado de Cumplimiento"
    )
    
    # Evidencia para auditoría (Se guarda la ruta del archivo subido para cerrar el caso)
    evidencia_cierre = models.FileField(upload_to='evidencias_inspecciones/', null=True, blank=True, verbose_name="Archivo de Evidencia")
    fecha_cierre = models.DateTimeField(null=True, blank=True, verbose_name="Fecha en que se cerró")

    class Meta:
        verbose_name = "Ítem de Inspección"
        verbose_name_plural = "Ítems de Inspección"
        ordering = ['numero_item']

    def __str__(self):
        return f"Item {self.numero_item} - Inspección #{self.inspeccion.id} ({self.responsable_accion})"


class ItemInspeccionEvidencia(models.Model):
    item = models.ForeignKey(
        ItemInspeccion,
        on_delete=models.CASCADE,
        related_name='evidencias',
        verbose_name='Ítem de Inspección',
    )
    archivo = models.FileField(
        upload_to='evidencias_inspecciones/',
        verbose_name='Archivo de Evidencia'
    )
    fecha_subida = models.DateTimeField(auto_now_add=True, verbose_name='Fecha de Subida')

    class Meta:
        verbose_name = 'Evidencia de Ítem (Inspección)'
        verbose_name_plural = 'Evidencias de Ítems (Inspecciones)'
        ordering = ['-fecha_subida']

    def __str__(self):
        return f"Evidencia para ítem {self.item.numero_item} - Inspección #{self.item.inspeccion.id}"

class ObservacionConducta(models.Model):
    # =========================================================================
    # DATOS GENERALES / CABECERA
    # =========================================================================
    area_trabajo = models.CharField(
        max_length=250, 
        verbose_name="Área de Trabajo"
    )
    persona_observada = models.CharField(
        max_length=200, 
        verbose_name="Persona Observada"
    )
    fecha_observacion = models.DateField(
        verbose_name="Fecha de Observación"
    )
    descripcion_tarea = models.TextField(
        verbose_name="Descripción de la Tarea"
    )
    observacion = models.TextField(
            verbose_name="Descripción de la Observación"
        )
    antiguedad_puesto = models.CharField(
        max_length=100, 
        blank=True, 
        null=True, 
        verbose_name="Antigüedad en el Puesto"
    )
    tarea = models.CharField(
            max_length=250, 
            verbose_name="Tarea"
        )
    
    # Checkbox para 'OBSERVACIÓN PLANIFICADA (SÍ / NO)'
    observacion_planificada = models.CharField(
        max_length=20, 
        choices=[('SI', 'SI'),
                ('NO', 'NO'),],
        default='SI'
    )

    # =========================================================================
    # RECONOCIMIENTO Y FIRMAS
    # =========================================================================
    # Checkbox para '¿SE OBSERVÓ ALGUNA PRÁCTICA QUE MERECE SER RECONOCIDA...?'
    mejora = models.CharField(
        max_length=20, 
        choices=[('SI', 'SI'),
                ('NO', 'NO'),],
        default='SI'
    )
    

    # Auditoría interna
    fecha_creacion = models.DateTimeField(auto_now_add=True)
    hora_creacion = models.TimeField(auto_now_add=True)
    
    nombre_usuario_creador = models.CharField(max_length=150, verbose_name="Usuario Creador")
    correo_usuario_creador = models.EmailField(max_length=50, verbose_name="Correo Usuario Creador")

    firma_creador = models.FileField(upload_to='firma_obsconducta/', null=True, blank=True, verbose_name='Firma Responsable')
    firma_observado = models.FileField(upload_to='firma_obsconducta/', null=True, blank=True, verbose_name='Firma Responsable')

    token = models.UUIDField(default=uuid.uuid4, editable=False, unique=True)
    class Meta:
        verbose_name = "Observación de Conducta"
        verbose_name_plural = "Observaciones de Conductas"
        ordering = ['-id']

    def __str__(self):
        return f"Obs. Conducta #{self.id} - {self.persona_observada} ({self.area_trabajo})"

    fecha_exportado = models.DateTimeField(null=True, blank=True, verbose_name="Fecha de Exportación a PDF.")
    hora_exportado = models.TimeField(null=True, blank=True, verbose_name="Hora de Exportación a PDF.")


class ItemObservacionConducta(models.Model):
    observacion_conducta = models.ForeignKey(
        ObservacionConducta, 
        on_delete=models.CASCADE, 
        related_name='items'
    )
    numero_item = models.PositiveIntegerField(verbose_name="N°")
    analisis_causa = models.TextField(verbose_name="Análisis de Causa")
    acciones_correctivas = models.TextField(verbose_name="Acciones Correctivas")
    responsable = models.CharField(max_length=200, verbose_name="Responsable")
    fecha_cumplimiento = models.DateField(
        verbose_name="Fecha"
    )
    OPCIONES_CUMPLIMIENTO = [
            ('SI', 'SI'),
            ('NO', 'NO'),
            ('PENDIENTE', 'PENDIENTE'),
        ]
    cumplimiento = models.CharField(
        max_length=10, 
        choices=OPCIONES_CUMPLIMIENTO, 
        default='PENDIENTE',
        verbose_name="Estado de Cumplimiento"
    )

    class Meta:
        verbose_name = "Ítem de Observación de Conducta"
        verbose_name_plural = "Ítems de Observaciones de Conducta"
        ordering = ['numero_item']

    def __str__(self):
        return f"Item #{self.numero_item} - Obs #{self.observacion_conducta.id}"

class ItemObsConductaEvidencia(models.Model):
    item = models.ForeignKey(
        ItemObservacionConducta,
        on_delete=models.CASCADE,
        related_name='evidencias',
        verbose_name='Ítem de Observación de Conducta',
    )
    archivo = models.FileField(
        upload_to='evidencias_obsconductas/',
        verbose_name='Archivo de Evidencia'
    )
    fecha_subida = models.DateTimeField(auto_now_add=True, verbose_name='Fecha de Subida')

    class Meta:
        verbose_name = 'Evidencia de Ítem (Observación de Conducta)'
        verbose_name_plural = 'Evidencias de Ítems (Observaciones de Conducta)'
        ordering = ['-fecha_subida']

    def __str__(self):
        return f"Evidencia para ítem {self.item.numero_item} - Observación de Conducta #{self.item.id}"

class ReporteHSGI(models.Model):
    cargo = models.CharField(max_length=150, verbose_name="Cargo")
    centro_trabajo = models.CharField(max_length=150, verbose_name="Centro de Trabajo/Obra")
    fecha_hallazgo = models.DateField(verbose_name="Fecha del Hallazgo")
    hora_hallazgo = models.TimeField(verbose_name="Hora del Hallazgo")
    turno = models.CharField(max_length=50, verbose_name="Turno")
    proceso_hallazgo = models.CharField(max_length=250, verbose_name="Proceso del Hallazgo")
    actividad_involucrada = models.CharField(max_length=250, verbose_name="Actividad Involucrada")
    lugar_especifico = models.CharField(max_length=250, verbose_name="Lugar Específico")
    ambito_hallazgo = models.CharField(max_length=250, verbose_name="Ámbito del Hallazgo")
    causa = models.TextField(verbose_name="Causa del Hallazgo")
    nivel_hallazgo = models.CharField(max_length=50, verbose_name="Nivel del Hallazgo")
    supervisor_hallazgo = models.CharField(max_length=150, verbose_name="Supervisor del Hallazgo")
    fecha_cierre = models.DateField(null=True, blank=True, verbose_name="Fecha de Cierre")

    descripcion_hallazgo = models.TextField(verbose_name="Descripción del Hallazgo")
    accion_inmediata = models.TextField(verbose_name="Acción Inmediata/Correctivas")

    responsable_cierre = models.CharField(max_length=150, verbose_name="Responsable Cierre")
    OPCIONES_CUMPLIMIENTO = [
            ('CERRADA', 'CERRADA'),
            ('PENDIENTE', 'PENDIENTE'),
        ]
    estado_cierre = models.CharField(
        max_length=10, 
        choices=OPCIONES_CUMPLIMIENTO, 
        default='PENDIENTE',
        verbose_name="Estado de Cierre"
    )
    evidencia_cierre = models.FileField(upload_to='evidencias_reportes/', null=True, blank=True, verbose_name="Archivo de Evidencia de Cierre")

    fecha_creacion = models.DateTimeField(auto_now_add=True)
    hora_creacion = models.TimeField(auto_now_add=True)

    fecha_exportado = models.DateTimeField(null=True, blank=True, verbose_name="Fecha de Exportación a PDF.")
    hora_exportado = models.TimeField(null=True, blank=True, verbose_name="Hora de Exportación a PDF.")
    
    
    nombre_usuario_creador = models.CharField(max_length=150, verbose_name="Usuario Creador")
    correo_usuario_creador = models.EmailField(max_length=50, verbose_name="Correo Usuario Creador")

    token = models.UUIDField(default=uuid.uuid4, editable=False, unique=True)
    class Meta:
        verbose_name = "Reporte HSGI"
        verbose_name_plural = "Reportes HSGI"
        ordering = ['-fecha_creacion']

class ReporteHSGIEvidencia(models.Model):
    reporte_hsgi = models.ForeignKey(
        ReporteHSGI,
        on_delete=models.CASCADE,
        related_name='evidencias',
        verbose_name='Evidencias de Reporte HSGI',
    )
    archivo = models.FileField(
        upload_to='evidencias_reporteshsgi/',
        verbose_name='Archivo de Evidencia'
    )
    fecha_subida = models.DateTimeField(auto_now_add=True, verbose_name='Fecha de Subida')

    class Meta:
        verbose_name = 'Evidencia de Reporte HSGI'
        verbose_name_plural = 'Evidencias de Reportes HSGI'
        ordering = ['-fecha_subida']

    def __str__(self):
        return f"Evidencia para reporte  #{self.ReporteHSGI.id}"