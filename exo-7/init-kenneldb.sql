-- Script d'initialisation pour la base de données kennelDB
-- Ce script sera exécuté automatiquement au démarrage du conteneur

USE kennelDB;

-- Table des clients
CREATE TABLE clients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    date_naissance DATE NOT NULL,
    pseudonyme VARCHAR(50) UNIQUE
);

-- Table des adresses
CREATE TABLE adresses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    numero VARCHAR(10) NOT NULL,
    rue VARCHAR(200) NOT NULL,
    code_postal VARCHAR(10) NOT NULL,
    commune VARCHAR(100) NOT NULL
);

-- Table d'association clients-adresses
CREATE TABLE clients_adresses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    adresse_id INT NOT NULL,
    type_adresse ENUM('principale', 'secondaire', 'facturation') DEFAULT 'principale',
    FOREIGN KEY (client_id) REFERENCES clients(id) ON DELETE CASCADE,
    FOREIGN KEY (adresse_id) REFERENCES adresses(id) ON DELETE CASCADE,
    UNIQUE KEY unique_client_adresse_type (client_id, adresse_id, type_adresse)
);

-- Table des chiens
CREATE TABLE chiens (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    date_naissance DATE NOT NULL,
    race VARCHAR(100) NOT NULL,
    sterilise BOOLEAN DEFAULT FALSE,
    client_id INT,
    FOREIGN KEY (client_id) REFERENCES clients(id) ON DELETE SET NULL
);

-- Table des chats
CREATE TABLE chats (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    date_naissance DATE NOT NULL,
    race VARCHAR(100) NOT NULL,
    sterilise BOOLEAN DEFAULT FALSE,
    client_id INT,
    FOREIGN KEY (client_id) REFERENCES clients(id) ON DELETE SET NULL
);

-- Insertion de données d'exemple

-- Clients
INSERT INTO clients (nom, prenom, date_naissance, pseudonyme) VALUES
('Dupont', 'Marie', '1985-03-15', 'marie_d'),
('Martin', 'Pierre', '1978-11-22', 'pierre_m'),
('Durand', 'Sophie', '1992-07-08', 'sophie_durand'),
('Leclerc', 'Jean', '1980-01-30', 'jean_leclerc'),
('Moreau', 'Claire', '1988-09-12', 'claire_m');

-- Adresses
INSERT INTO adresses (numero, rue, code_postal, commune) VALUES
('15', 'Rue de la Paix', '75001', 'Paris'),
('23', 'Avenue des Champs', '69000', 'Lyon'),
('8', 'Place du Marché', '13000', 'Marseille'),
('45', 'Boulevard Victor Hugo', '31000', 'Toulouse'),
('12', 'Rue Saint-Antoine', '44000', 'Nantes'),
('67', 'Avenue de la République', '75011', 'Paris'),
('3', 'Impasse des Roses', '69002', 'Lyon');

-- Associations clients-adresses
INSERT INTO clients_adresses (client_id, adresse_id, type_adresse) VALUES
(1, 1, 'principale'),
(1, 6, 'secondaire'),
(2, 2, 'principale'),
(3, 3, 'principale'),
(4, 4, 'principale'),
(4, 5, 'facturation'),
(5, 7, 'principale');

-- Chiens
INSERT INTO chiens (nom, date_naissance, race, sterilise, client_id) VALUES
('Rex', '2020-05-10', 'Berger Allemand', TRUE, 1),
('Bella', '2019-08-22', 'Labrador', FALSE, 2),
('Max', '2021-03-15', 'Golden Retriever', TRUE, 3),
('Luna', '2018-12-03', 'Border Collie', TRUE, 4),
('Rocky', '2022-01-18', 'Bulldog Français', FALSE, 5),
('Daisy', '2020-09-25', 'Cocker Spaniel', TRUE, 1),
('Charlie', '2019-06-14', 'Beagle', FALSE, 2);

-- Chats
INSERT INTO chats (nom, date_naissance, race, sterilise, client_id) VALUES
('Minou', '2019-04-12', 'Persan', TRUE, 1),
('Felix', '2020-11-08', 'Maine Coon', TRUE, 3),
('Whiskers', '2021-02-20', 'Siamois', FALSE, 4),
('Shadow', '2018-07-15', 'Chat Européen', TRUE, 5),
('Garfield', '2022-03-05', 'Exotic Shorthair', FALSE, 2),
('Nala', '2020-12-30', 'Ragdoll', TRUE, 1),
('Simba', '2019-09-18', 'British Shorthair', TRUE, 4);

-- Affichage des statistiques d'initialisation
SELECT 'Base de données kennelDB initialisée avec succès!' as message;
SELECT 
    (SELECT COUNT(*) FROM clients) as nb_clients,
    (SELECT COUNT(*) FROM adresses) as nb_adresses,
    (SELECT COUNT(*) FROM clients_adresses) as nb_associations,
    (SELECT COUNT(*) FROM chiens) as nb_chiens,
    (SELECT COUNT(*) FROM chats) as nb_chats;