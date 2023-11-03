-- Affichez les expéditions en transit initiées par un entrepôt en Europe et à destination d'un entrepôt en Asie.
SELECT ex.*
FROM expeditions ex
INNER JOIN entrepots source ON ex.id_entrepot_source = source.id
INNER JOIN entrepots destination ON ex.id_entrepot_destination = destination.id
WHERE source.pays IN ('France', 'Allemagne', 'Italie', 'Espagne') 
  AND destination.pays IN ('Chine', 'Japon', 'Inde', 'Corée du Sud')
  AND ex.statut = 'En transit';

-- Affichez les entrepôts qui ont envoyé des expéditions à destination d'un entrepôt situé dans le même pays.
SELECT source.id, source.nom_entrepot, destination.id AS id_entrepot_dest, destination.nom_entrepot AS nom_entrepot_dest
FROM expeditions ex
INNER JOIN entrepots source ON ex.id_entrepot_source = source.id
INNER JOIN entrepots destination ON ex.id_entrepot_destination = destination.id
WHERE source.pays = destination.pays;

-- Affichez les entrepôts qui ont envoyé des expéditions à destination d'un entrepôt situé dans un pays différent.
SELECT source.id, source.nom_entrepot, destination.id AS id_entrepot_dest, destination.nom_entrepot AS nom_entrepot_dest
FROM expeditions ex
INNER JOIN entrepots source ON ex.id_entrepot_source = source.id
INNER JOIN entrepots destination ON ex.id_entrepot_destination = destination.id
WHERE source.pays != destination.pays;

-- Affichez les expéditions en transit initiées par un entrepôt situé dans un pays dont le nom commence par la lettre "F" et pesant plus de 500 kg.
SELECT ex.*
FROM expeditions ex
INNER JOIN entrepots source ON ex.id_entrepot_source = source.id
WHERE source.pays LIKE 'F%' AND ex.poids > 500 AND ex.statut = 'En transit';

-- Affichez le nombre total d'expéditions pour chaque combinaison de pays d'origine et de destination.
SELECT source.pays AS pays_origine, destination.pays AS pays_destination, COUNT(*) AS nombre_total_expeditions
FROM expeditions ex
INNER JOIN entrepots source ON ex.id_entrepot_source = source.id
INNER JOIN entrepots destination ON ex.id_entrepot_destination = destination.id
GROUP BY source.pays, destination.pays;

-- Affichez les entrepôts qui ont envoyé des expéditions au cours des 30 derniers jours et dont le poids total des expéditions est supérieur à 1000 kg.
SELECT e.id, e.nom_entrepot, SUM(ex.poids) AS poids_total_expeditions
FROM entrepots e
INNER JOIN expeditions ex ON e.id = ex.id_entrepot_source
WHERE DATEDIFF(NOW(), ex.date_expedition) <= 30
GROUP BY e.id, e.nom_entrepot
HAVING SUM(ex.poids) > 1000;

-- Affichez les expéditions qui ont été livrées avec un retard de plus de 2 jours ouvrables.
SELECT *
FROM expeditions
WHERE statut = 'Livrée' AND DATEDIFF(date_expedition, NOW()) > 2;

-- Affichez le nombre total d'expéditions pour chaque jour du mois en cours, trié par ordre décroissant.
SELECT DATE(date_expedition) AS date, COUNT(*) AS nombre_total_expeditions
FROM expeditions
WHERE MONTH(date_expedition) = MONTH(CURRENT_DATE)
GROUP BY date
ORDER BY date DESC;
