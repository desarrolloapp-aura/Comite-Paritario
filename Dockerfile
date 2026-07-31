# Usa la imagen oficial de Python 3.12 (versión slim para que sea más ligera)
FROM python:3.12-slim

# Establece variables de entorno
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Instala LibreOffice y dependencias
RUN apt-get update && apt-get install -y --no-install-recommends \
    libreoffice \
    libreoffice-writer \
    ure \
    libreoffice-java-common \
    libreoffice-core \
    libreoffice-common \
    fonts-liberation \
    libpq-dev \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Crea el directorio de trabajo
WORKDIR /app

# Copia e instala las dependencias de Python
COPY requirements.txt /app/
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

# Copia el código
COPY . /app/

# Expone el puerto
EXPOSE 10000

# Recopila archivos estáticos y arranca gunicorn
CMD python manage.py collectstatic --noinput && gunicorn config_reportes.wsgi:application --bind 0.0.0.0:${PORT:-10000}
