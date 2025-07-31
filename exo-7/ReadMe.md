# Exercice Docker #7

## Consignes
Via Docker, créer un conteneur de base de données (de type MySQL) possédant déjà plusieurs tables et données à son lancement.
* Ce conteneur devra être initialisé via un script de type sql contenant l'initialisation de la base de données
* Ce conteneur devra être instancié via une image construite par vos soins

Concernant le contenu de la base de données, celle-ci devra se nommer kennelDB et comporter:
* Des clients (nom, prénom, date de naissance, pseudonymme)
* Des adresses (numéro, rue, code postal, commune)
* Des associations clients-adresses
* Des chiens (nom, date de naissance, race, statut de stérilisation)
* Des chats (nom, date de naissance, race, statut de stérilisation)

## Etapes

- Creation Dockerfile
- Creation init-kenneldb

### Dans le terminal du dossier

- Creation de l'image à partir du DockerFile et du fichier init ``docker build -t exo-7 .``
    - "exo-7" : nom de l'image créée.
    - " . " : emplacement du Dockerfile.

- Creation du container à partir de l'image sur le port 3306 : ``docker run -d --name kennel-container -p 3306:3306 exo-7``

    - "kennel-container" : nom du container créé.
    - "exo-7" : nom de l'image utilisée.

- Affichage des container actif : ```docker ps```

- Rentre dans le container en se connectant à la bdd : ```docker exec -it kennel-container mysql -u kennel_user -pkennelpassword kennelDB```


  git config --global user.email "alexy.catelle@oclock.school"
  git config --global user.name "AlexyCatelle"



## Terminal

```
Alexy@DESKTOP-SGV06RH MINGW64 /d/Codes/CDA/Exo_TP/Docker/exo-7
$ docker build -t exo-7 .
[+] Building 1.3s (7/7) FINISHED                                                    
 => [internal] load build definition from Dockerfile                                
 => => transferring dockerfile: 421B                                                
 => [internal] load metadata for docker.io/library/mysql:latest                     
 => [internal] load .dockerignore                                                   
 => => transferring context: 2B                                                     
 => [internal] load build context                                                   
 => => transferring context: 4.16kB                                                 
 => [1/2] FROM docker.io/library/mysql:latest@sha256:082063dca94535c76b91c6ef9b9f674
 => => resolve docker.io/library/mysql:latest@sha256:082063dca94535c76b91c6ef9b9f674
 => [2/2] COPY init-kenneldb.sql /docker-entrypoint-initdb.d/                       
 => exporting to image                                                              
 => => exporting layers                                                             
bug to expand:
 - SecretsUsedInArgOrEnv: Do not use ARG or ENV instructions for sensitive data ENV
 - SecretsUsedInArgOrEnv: Do not use ARG or ENV instructions for sensitive data ENV


Alexy@DESKTOP-SGV06RH MINGW64 /d/Codes/CDA/Exo_TP/Docker/exo-7
$ docker run -d --name kennel-container -p 3306:3306 exo-7
fd8c997fdeb7a9243957db08b3b360ec1b1e530701dff2cf49e58fdacb3eea95

Alexy@DESKTOP-SGV06RH MINGW64 /d/Codes/CDA/Exo_TP/Docker/exo-7
$ docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED              STATUS              PORTS                                         NAMES
fd8c997fdeb7   exo-7     "docker-entrypoint.s…"   About a minute ago   Up About a minute   0.0.0.0:3306->3306/tcp, [::]:3306->3306/tcp   kennel-container

Alexy@DESKTOP-SGV06RH MINGW64 /d/Codes/CDA/Exo_TP/Docker/exo-7
$ docker exec -it kennel-container mysql -u kennel_user -pkennelpassword kennelDB

mysql> SELECT * FROM chats
    -> ;
+----+----------+----------------+-------------------+-----------+-----------+
| id | nom      | date_naissance | race              | sterilise | client_id |
+----+----------+----------------+-------------------+-----------+-----------+
|  1 | Minou    | 2019-04-12     | Persan            |         1 |         1 |
|  2 | Felix    | 2020-11-08     | Maine Coon        |         1 |         3 |
|  3 | Whiskers | 2021-02-20     | Siamois           |         0 |         4 |
|  4 | Shadow   | 2018-07-15     | Chat Européen    |         1 |         5 |
|  5 | Garfield | 2022-03-05     | Exotic Shorthair  |         0 |         2 |
|  6 | Nala     | 2020-12-30     | Ragdoll           |         1 |         1 |
|  7 | Simba    | 2019-09-18     | British Shorthair |         1 |         4 |
+----+----------+----------------+-------------------+-----------+-----------+
7 rows in set (0.001 sec)
```