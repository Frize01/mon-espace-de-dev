# Service Python 3

## Description
Service Python 3 intégré à votre environnement de développement Docker.

## Utilisation

### 1. Ajouter des dépendances pip
Modifiez le fichier `requirements.txt` et ajoutez les packages pip que vous souhaitez installer :

```
numpy
pandas
flask
requests
django
jupyter
```

### 2. Reconstruire le conteneur
Après modification du fichier `requirements.txt`, reconstruisez l'image :

```bash
docker-compose build python
docker-compose up python
```

### 3. Accéder au conteneur
Vous pouvez accéder au conteneur Python de deux façons :

#### Via docker-compose
```bash
docker-compose exec python python
# ou accéder au shell
docker-compose exec python bash
```

#### Via docker exec
```bash
docker exec -it python-dev python
# ou
docker exec -it python-dev bash
```

### 4. Votre espace de travail
- Répertoire local : `./python/workspace`
- Répertoire dans le conteneur : `/workspace`

Les fichiers que vous créez dans `./python/workspace` seront visibles dans le conteneur.

## Accès Web (Traefik)
Le service est accessible via : `http://python.localhost`

## Structure
```
python/
├── Dockerfile           # Configuration du service
├── requirements.txt     # Liste des dépendances pip
└── workspace/          # Espace de travail partagé
```

## Exemples de packages courants
- **Data Science** : numpy, pandas, matplotlib, scipy, scikit-learn
- **Web** : flask, django, fastapi, requests, beautifulsoup4
- **Utils** : python-dotenv, pydantic, click
- **Dev** : jupyter, pytest, black, pylint
