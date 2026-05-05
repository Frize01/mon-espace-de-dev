# Configuration SSL Local pour Traefik

## 1. Générer le certificat autosigné wildcard

Exécute cette commande à la racine du projet (mon-espace-de-dev). Elle lance la génération dans un conteneur Docker, donc aucun outil local n'est requis:

```bash
make cert
```

Cela crée:
- `certs/localhost.crt` (certificat)
- `certs/localhost.key` (clé privée)
- Valide pour 100 ans (36500 jours)
- Wildcard pour tous les domaines `.localhost`

## 2. Mettre à jour docker-compose.yml (Traefik)

Ajoute ceci à la section `traefik.command`:

```yaml
- "--entrypoints.websecure.address=:443"
- "--providers.file.filename=/traefik/tls.yml"
- "--providers.file.watch=true"
```

Ajoute les volumes:

```yaml
volumes:
  - /var/run/docker.sock:/var/run/docker.sock:ro
  - ./certs/localhost.crt:/traefik/localhost.crt:ro
  - ./certs/localhost.key:/traefik/localhost.key:ro
  - ./traefik-tls.yml:/traefik/tls.yml:ro
```

## 3. Créer la config TLS (traefik-tls.yml)

À la racine de mon-espace-de-dev:

```yaml
tls:
  certificates:
    - certFile: /traefik/localhost.crt
      keyFile: /traefik/localhost.key
      stores:
        - default
```

## 4. Mettre à jour WordPress (o-b-art-wordpress/docker-compose.yml)

Passe les URLs et le routeur en HTTPS:

```yaml
environment:
  WP_HOME: ${WP_HOME:-https://obart.localhost}
  WP_SITEURL: ${WP_SITEURL:-https://obart.localhost}

labels:
  - "traefik.enable=true"
  - "traefik.http.routers.obart.rule=Host(`obart.localhost`)"
  - "traefik.http.routers.obart.entrypoints=websecure"
  - "traefik.http.routers.obart.tls=true"
  - "traefik.http.services.obart.loadbalancer.server.port=80"
```

## 5. Redémarrer

```bash
cd /home/frize/Git/mon-espace-de-dev
docker compose down
docker compose up -d
```

Puis accède à `https://obart.localhost` (accepte l'avertissement de certificat autosigné)

