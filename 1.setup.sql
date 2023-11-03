-- Créer la base de données "transport_logistique"
CREATE DATABASE transport_logistique;

-- Utiliser la base de données "transport_logistique"
USE transport_logistique;

-- Créer la table "entrepots"
CREATE TABLE entrepots (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom_entrepot VARCHAR(255),
    adresse VARCHAR(255),
    ville VARCHAR(255),
    pays VARCHAR(255)
);

-- Créer la table "expeditions"
CREATE TABLE expeditions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    date_expedition DATE,
    id_entrepot_source INT,
    id_entrepot_destination INT,
    poids DECIMAL(10, 2),
    statut VARCHAR(255),
    FOREIGN KEY (id_entrepot_source) REFERENCES entrepots(id),
    FOREIGN KEY (id_entrepot_destination) REFERENCES entrepots(id)
);
