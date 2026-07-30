#!/usr/bin/env bash
set -o errexit

# Instalar LibreOffice para conversión Word/Excel → PDF
apt-get update && apt-get install -y --no-install-recommends libreoffice-core libreoffice-writer libreoffice-calc

pip install -r requirements.txt
python manage.py collectstatic --no-input
python manage.py migrate
