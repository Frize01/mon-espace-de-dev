FROM python:latest

WORKDIR /workspace

# Copier les requirements
COPY python/requirements.txt /tmp/requirements.txt

# Installer les dépendances pip
RUN pip install --no-cache-dir -r /tmp/requirements.txt || true

# Garder le conteneur en vie
CMD ["tail", "-f", "/dev/null"]
