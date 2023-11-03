-- Créez une table "clients"
CREATE TABLE clients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255),
    adresse VARCHAR(255),
    ville VARCHAR(255),
    pays VARCHAR(255)
);

-- Créez une table de jointure "expeditions_clients"
CREATE TABLE expeditions_clients (
    id_expedition INT,
    id_client INT,
    FOREIGN KEY (id_expedition) REFERENCES expeditions(id),
    FOREIGN KEY (id_client) REFERENCES clients(id)
);

-- Modifiez la table "expeditions" pour ajouter la colonne "id_client"
ALTER TABLE expeditions
ADD id_client INT,
ADD FOREIGN KEY (id_client) REFERENCES clients(id);
