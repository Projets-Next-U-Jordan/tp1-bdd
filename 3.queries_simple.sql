-- Affichez tous les entrepôts
SELECT * FROM entrepots;

-- Affichez toutes les expéditions
SELECT * FROM expeditions;

-- Affichez toutes les expéditions en transit
SELECT * FROM expeditions WHERE statut = 'En transit';

-- Affichez toutes les expéditions livrées
SELECT * FROM expeditions WHERE statut = 'Livrée';
