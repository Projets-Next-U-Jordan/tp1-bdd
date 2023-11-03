-- Créez une vue qui affiche les informations pour chaque entrepôt :
-- nom de l'entrepôt, adresse complète, nombre d'expéditions envoyées au cours des 30 derniers jours.
CREATE VIEW Vue_Entrepot_Informations AS
SELECT e.id, e.nom_entrepot, e.adresse, e.ville, e.pays, COUNT(ex.id) AS nombre_expeditions_30_jours
FROM entrepots e
LEFT JOIN expeditions ex ON e.id = ex.id_entrepot_source
WHERE DATEDIFF(DAY, ex.date_expedition, GETDATE()) <= 30
GROUP BY e.id, e.nom_entrepot, e.adresse, e.ville, e.pays;

-- Créez une procédure stockée qui prend en entrée l'ID d'un entrepôt et
-- renvoie le nombre total d'expéditions envoyées par cet entrepôt au cours du dernier mois.
CREATE PROCEDURE GetTotalExpeditionsLastMonth(@entrepot_id INT)
AS
BEGIN
    SELECT COUNT(*) AS TotalExpeditions
    FROM expeditions
    WHERE id_entrepot_source = @entrepot_id
    AND date_expedition >= DATEADD(MONTH, -1, GETDATE());
END;

-- Créez une fonction qui prend en entrée une date et renvoie le nombre total
-- d'expéditions livrées ce jour-là.
CREATE FUNCTION GetTotalDeliveredExpeditionsOnDate(@in_date DATE)
RETURNS INT
AS
BEGIN
    DECLARE @total_delivered INT;
    SELECT @total_delivered = COUNT(*)
    FROM expeditions
    WHERE date_expedition = @in_date AND statut = 'Livrée';
    RETURN @total_delivered;
END;
