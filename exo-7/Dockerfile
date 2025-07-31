# Image MySQL
FROM mysql:latest

# Variables d'environnement pour MySQL
ENV MYSQL_ROOT_PASSWORD=rootpassword
ENV MYSQL_DATABASE=kennelDB
ENV MYSQL_USER=kennel_user
ENV MYSQL_PASSWORD=kennelpassword

# Copier le script d'initialisation dans le répertoire d'initialisation de MySQL
COPY init-kenneldb.sql /docker-entrypoint-initdb.d/

# Exposer le port MySQL
EXPOSE 3306