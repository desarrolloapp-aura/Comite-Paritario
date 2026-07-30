"""
URL configuration for config_reportes project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/6.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.contrib.auth import views as auth_views
from django.urls import path
from django.conf.urls.static import static
from django.conf import settings
from app_reportes import views

urlpatterns = [
#RUTAS DE PÁGINAS PRINCIPALES
    path('admin/', admin.site.urls),
    path('', views.ver_index, name='inicio'),
    path('login/',auth_views.LoginView.as_view(template_name='login.html')),
    path('logout/', auth_views.LogoutView.as_view(), name='logout'),
    path('inspecciones', views.ver_inspecciones),
    path('obsconducta', views.ver_obsconducta),
    path('reportehsgi', views.ver_reportehsgi),
    path('inspecciones/evidencia_inspeccion/<uuid:token>', views.evid_inspecciones, name='evidencia_inspecciones'),
    path('obsconducta/evidencia_obsconducta/<uuid:token>', views.evid_obsconducta, name='evidencia_obsconducta'),   
    path('reportehsgi/evidencia_hsgi/<uuid:token>', views.evid_reportehsgi, name='evidencia_reportehsgi'),   
    path('menu_listas', views.menu_listas, name='menu_listas'),
    path('lista_inspecciones', views.lista_inspecciones, name='lista_inspecciones'),
    path('lista_obsconducta', views.lista_obsconducta, name='lista_obsconducta'),
    path('lista_reportehsgi', views.lista_reportehsgi, name='lista_reportehsgi'),
    path('lista_inspecciones/revision/<int:id>', views.revisar_inspeccion, name='revisar_inspeccion'),
    path('lista_obsconducta/revision/<int:id>', views.revisar_obsconducta, name='revisar_obsconducta'),
    path('lista_reportehsgi/revision/<int:id>', views.revisar_reportehsgi, name='revisar_reportehsgi'),
    path('firmar_inspecciones', views.ver_firmar_inspecciones, name='firmar_inspecciones'),
    path('firmar_obsconducta_creador', views.ver_firmar_obsconducta_creador, name='firmar_obsconducta_creador'),
    path('firmar_obsconducta_observado', views.ver_firmar_obsconducta_observado, name='firmar_obsconducta_observado'),
#RUTAS FUNCIONALES
    path('enviar_inspeccion', views.enviar_inspeccion),
    path('inspecciones/evidencia_inspeccion/enviar_evidencia_inspeccion/<uuid:token>/<int:item_id>/', views.enviar_inspeccion_evidencia, name='enviar_inspeccion_evidencia'),
    path('obsconducta/evidencia_obsconducta/enviar_evidencia_obsconducta/<uuid:token>/<int:item_id>/', views.enviar_obsconducta_evidencia, name='enviar_evidencia_obsconducta'),
    path('reportehsgi/evidencia_hsgi/enviar_evidencia_reportehsgi/<uuid:token>/', views.enviar_reportehsgi_evidencia, name='enviar_inspeccion_evidencia'),
    path('guardar_firma_inspeccion/<uuid:token>/', views.guardar_firma_inspeccion, name='guardar_firma_inspeccion'),
    path('lista_inspecciones/revision/exportar_inspeccion_pdf/<int:inspeccion_id>', views.exportar_inspeccion_pdf, name='exportar_inspeccion_pdf'),
    path('enviar_obsconducta', views.enviar_obsconducta),
    path('guardar_firma_obsconducta_creador/<uuid:token>/', views.guardar_firma_obsconducta_creador, name='guardar_firma_obsconducta_creador'),
    path('guardar_firma_obsconducta_observado/<uuid:token>/', views.guardar_firma_obsconducta_observado, name='guardar_firma_obsconducta_observado'),
    path('lista_obsconducta/revision/exportar_obsconducta_pdf/<int:obsconducta_id>', views.exportar_obsconducta_pdf, name='exportar_obsconducta_pdf'),
    path('enviar_reportehsgi', views.enviar_reportehsgi),
    path('lista_reportehsgi/revision/exportar_reportehsgi_pdf/<int:hsgi_id>', views.exportar_reportehsgi_pdf, name='exportar_reportehsgi_pdf'),

    path('exportar_inspeccion_pdf/<int:inspeccion_id>', views.exportar_inspeccion_pdf, name='exportar_inspeccion_pdf'),
    path('exportar_obsconducta_pdf/<int:obsconducta_id>', views.exportar_obsconducta_pdf, name='exportar_obsconducta_pdf'),
    path('exportar_reportehsgi_pdf/<int:hsgi_id>', views.exportar_reportehsgi_pdf, name='exportar_inspeccion_pdf'),


    
]

urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
