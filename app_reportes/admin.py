from django.contrib import admin

from .models import InspeccionCabecera,ItemInspeccion,ItemInspeccionEvidencia,ObservacionConducta,ItemObservacionConducta,ItemObsConductaEvidencia,ReporteHSGI,ReporteHSGIEvidencia
# Register your models here.
admin.site.register(ItemObsConductaEvidencia)
admin.site.register(ItemObservacionConducta)
admin.site.register(ItemInspeccionEvidencia)
admin.site.register(ItemInspeccion)
admin.site.register(InspeccionCabecera)
admin.site.register(ObservacionConducta)
admin.site.register(ReporteHSGIEvidencia)
admin.site.register(ReporteHSGI)