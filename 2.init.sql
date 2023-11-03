-- Ajouter des entrepôts
INSERT INTO entrepots (nom_entrepot, adresse, ville, pays) VALUES
    ('Entrepot A', '123 Rue de la Logistique', 'Paris', 'France'),
    ('Entrepot B', '456 Warehouse Street', 'New York', 'USA'),
    ('Entrepot C', '789 Lagerstrasse', 'Berlin', 'Allemagne'),
    ('Entrepot D', '10 Downing Street', 'London', 'UK'),
    ('Entrepot E', '1600 Pennsylvania Avenue NW', 'Washington D.C.', 'USA')
    

-- Ajouter des expéditions
INSERT INTO expeditions (date_expedition, id_entrepot_source, id_entrepot_destination, poids, statut) VALUES
    ('2023-10-01', 1, 2, 150.00, 'En transit'),
    ('2023-10-02', 2, 3, 200.00, 'Livrée'),
    ('2023-10-03', 3, 4, 100.00, 'En transit'),
    ('2023-10-04', 4, 5, 75.00, 'En transit'),
    ('2023-10-05', 5, 1, 50.00, 'En transit'),
    ('2023-10-06', 1, 3, 125.00, 'En transit'),
    ('2023-10-07', 2, 4, 175.00, 'En transit'),
    ('2023-10-08', 3, 5, 225.00, 'En transit'),
    ('2023-10-09', 4, 1, 250.00, 'En transit'),
    ('2023-10-10', 5, 2, 300.00, 'En transit')
