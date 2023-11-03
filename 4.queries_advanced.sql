-- Affichez les entrepôts qui ont envoyé au moins une expédition en transit.
SELECT DISTINCT e.id, e.nom_entrepot
FROM entrepots e
INNER JOIN expeditions ex ON e.id = ex.id_entrepot_source
WHERE ex.statut = 'En transit';

-- Affichez les entrepôts qui ont reçu au moins une expédition en transit.
SELECT DISTINCT e.id, e.nom_entrepot
FROM entrepots e
INNER JOIN expeditions ex ON e.id = ex.id_entrepot_destination
WHERE ex.statut = 'En transit';

-- Affichez les expéditions qui ont un poids supérieur à 100 kg et qui sont en transit.
SELECT *
FROM expeditions
WHERE statut = 'En transit' AND poids > 100;

-- Affichez le nombre d'expéditions envoyées par chaque entrepôt.
SELECT e.id, e.nom_entrepot, COUNT(ex.id) AS nombre_expeditions_envoyees
FROM entrepots e
LEFT JOIN expeditions ex ON e.id = ex.id_entrepot_source
GROUP BY e.id, e.nom_entrepot;

-- Affichez le nombre total d'expéditions en transit.
SELECT COUNT(*) AS nombre_total_expeditions_en_transit
FROM expeditions
WHERE statut = 'En transit';

-- Affichez le nombre total d'expéditions livrées.
SELECT COUNT(*) AS nombre_total_expeditions_livrees
FROM expeditions
WHERE statut = 'Livrée';

-- Affichez le nombre total d'expéditions pour chaque mois de l'année en cours.
SELECT MONTH(date_expedition) AS mois, COUNT(*) AS nombre_total_expeditions
FROM expeditions
WHERE YEAR(date_expedition) = YEAR(CURRENT_DATE)
GROUP BY mois;

-- Affichez les entrepôts qui ont envoyé des expéditions au cours des 30 derniers jours.
SELECT DISTINCT e.id, e.nom_entrepot
FROM entrepots e
INNER JOIN expeditions ex ON e.id = ex.id_entrepot_source
WHERE DATEDIFF(NOW(), ex.date_expedition) <= 30;

-- Affichez les entrepôts qui ont reçu des expéditions au cours des 30 derniers jours.
SELECT DISTINCT e.id, e.nom_entrepot
FROM entrepots e
INNER JOIN expeditions ex ON e.id = ex.id_entrepot_destination
WHERE DATEDIFF(NOW(), ex.date_expedition) <= 30;

-- Affichez les expéditions qui ont été livrées dans un délai de moins de 5 jours ouvrables.
SELECT *
FROM expeditions
WHERE statut = 'Livrée' AND DATEDIFF(date_expedition, NOW()) <= 5;
