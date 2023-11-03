# Menu
- [1. Base de données](#1)
- [2. Insertion de données](#2)
- [3. Requêtes simples](#3)
- [4. Requêtes avancées](#4)
- [5. Requêtes complexes](#5)
- [6. TSQL](#6)
- [7. Bonus](#7)
---


## <a name="1"></a>1. Base de données

La base de données utilisée est `transport_logistique`.

```sql
CREATE DATABASE transport_logistique;
USE transport_logistique;
```
![Creation de la base de donnée](create_database.png)

### Table "entrepots"

Cette table contient des informations sur les entrepôts.

- `id`: Un identifiant unique pour chaque entrepôt.
- `nom_entrepot`: Le nom de l'entrepôt.
- `adresse`: L'adresse de l'entrepôt.
- `ville`: La ville où se trouve l'entrepôt.
- `pays`: Le pays où se trouve l'entrepôt.

```sql
CREATE TABLE entrepots (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom_entrepot VARCHAR(255),
    adresse VARCHAR(255),
    ville VARCHAR(255),
    pays VARCHAR(255)
);
```

![Creation de la table entrepot](create_table_entrepot.png)

### Table "expeditions"

Cette table contient des informations sur les expéditions.

- `id`: Un identifiant unique pour chaque expédition.
- `date_expedition`: La date de l'expédition.
- `id_entrepot_source`: L'identifiant de l'entrepôt d'où provient l'expédition.
- `id_entrepot_destination`: L'identifiant de l'entrepôt où l'expédition est envoyée.
- `poids`: Le poids de l'expédition.
- `statut`: Le statut de l'expédition.

Les colonnes `id_entrepot_source` et `id_entrepot_destination` sont des clés étrangères qui font référence à la colonne `id` de la table `entrepots`.

```sql
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
```
![Creation table expedition](create_table_expeditions.png)

## <a name="2"></a>2. Insertion de données

### Table "entrepots"

Les données suivantes sont insérées dans la table "entrepots". Chaque ligne représente un entrepôt avec son nom, son adresse, sa ville et son pays.

```sql
INSERT INTO entrepots (nom_entrepot, adresse, ville, pays) VALUES
    ('Entrepot A', '123 Rue de la Logistique', 'Paris', 'France'),
    ('Entrepot B', '456 Warehouse Street', 'New York', 'USA'),
    ('Entrepot C', '789 Lagerstrasse', 'Berlin', 'Allemagne'),
    ('Entrepot D', '10 Downing Street', 'London', 'UK'),
    ('Entrepot E', '1600 Pennsylvania Avenue NW', 'Washington D.C.', 'USA');
```
![Insertion des données dans entrepot](insert_entrepot.png)
### Table "expeditions"

Les données suivantes sont insérées dans la table "expeditions". Chaque ligne représente une expédition avec sa date, l'identifiant de l'entrepôt source, l'identifiant de l'entrepôt de destination, le poids de l'expédition et son statut.

```sql
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
    ('2023-10-10', 5, 2, 300.00, 'En transit');
```
![Insertion des données dans expeditions](insert_expedition.png)

## <a name="3"></a>3. Requêtes simples

### 3.1 Afficher tous les entrepôts

Cette requête affiche toutes les informations sur tous les entrepôts.

```sql
SELECT * FROM entrepots;
```
![Selection des données des entrepots](select_entrepots.png)
### 3.2 Afficher toutes les expéditions

Cette requête affiche toutes les informations sur toutes les expéditions.

```sql
SELECT * FROM expeditions;
```
![Selection des données des expeditions](image.png)
### 3.3 Afficher toutes les expéditions en transit

Cette requête affiche toutes les informations sur les expéditions qui sont actuellement en transit.

```sql
SELECT * FROM expeditions WHERE statut = 'En transit';
```
![Selection des expeditions En Transit](selection_expeditions_transit.png)
### 3.4 Afficher toutes les expéditions livrées

Cette requête affiche toutes les informations sur les expéditions qui ont été livrées.

```sql
SELECT * FROM expeditions WHERE statut = 'Livrée';
```
![Selection des expeditions Livrées](selection_expeditions_livree.png)
## <a name="4"></a>4. Requêtes avancées

### 4.1 Afficher les entrepôts qui ont envoyé au moins une expédition en transit

La première requête identifie les entrepôts qui ont envoyé au moins une expédition en transit. Elle combine les tables entrepots et expeditions en utilisant une jointure interne (INNER JOIN) pour filtrer les données. Seuls les entrepôts qui ont des expéditions en transit sont listés.

```sql
SELECT DISTINCT e.id, e.nom_entrepot
FROM entrepots e
INNER JOIN expeditions ex ON e.id = ex.id_entrepot_source
WHERE ex.statut = 'En transit';
```
![Selection Entrepot Envoie Min 1 Transit](selection_entrepot_envoie_min1_transit.png)

### 4.2 Afficher les entrepôts qui ont reçu au moins une expédition en transit

La requête suivante met en lumière les entrepôts qui ont reçu au moins une expédition en transit. Elle repose sur une jointure interne entre les tables entrepots et expeditions, mais cette fois, nous considérons les entrepôts de destination des expéditions.

```sql
SELECT DISTINCT e.id, e.nom_entrepot
FROM entrepots e
INNER JOIN expeditions ex ON e.id = ex.id_entrepot_destination
WHERE ex.statut = 'En transit';
```
![Selection Entrepot Recu Min1 Transit](selection_entrepot_recois_min1_transit.png)
### 4.3 Afficher les expéditions qui ont un poids supérieur à 100 kg et qui sont en transit

La troisième requête identifie les expéditions en transit dont le poids est supérieur à 100 kg. Elle examine uniquement la table expeditions et applique des critères de filtrage pour trouver ces expéditions spécifiques.

```sql
SELECT *
FROM expeditions
WHERE statut = 'En transit' AND poids > 100;
```
![Selectionne expeditions transit poid > 100](selection_expeditions_transit_poid_plus100.png)
### 4.4 Afficher le nombre d'expéditions envoyées par chaque entrepôt

La requête suivante calcule le nombre d'expéditions envoyées par chaque entrepôt. Elle utilise une jointure gauche (LEFT JOIN) entre les tables entrepots et expeditions, puis agrège les données en comptant le nombre d'expéditions pour chaque entrepôt.

```sql
SELECT e.id, e.nom_entrepot, COUNT(ex.id) AS nombre_expeditions_envoyees
FROM entrepots e
LEFT JOIN expeditions ex ON e.id = ex.id_entrepot_source
GROUP BY e.id, e.nom_entrepot;
```
![Selectionner entrepots et nombre expedition.](selection_entrepots_nombre_expedition.png)
### 4.5 Afficher le nombre total d'expéditions en transit

La cinquième requête détermine le nombre total d'expéditions en transit dans la base de données. Elle se concentre uniquement sur la table expeditions et compte le nombre d'expéditions avec le statut "En transit".

```sql
SELECT COUNT(*) AS nombre_total_expeditions_en_transit
FROM expeditions
WHERE statut = 'En transit';
```
![Nombre expé transit](nombre_expe_transit.png)
### 4.6 Afficher le nombre total d'expéditions livrées

La sixième requête détermine le nombre total d'expéditions qui ont été marquées comme "Livrée". Elle examine la table expeditions et compte le nombre d'expéditions avec le statut "Livrée".

```sql
SELECT COUNT(*) AS nombre_total_expeditions_livrees
FROM expeditions
WHERE statut = 'Livrée';
```
![Nombre livrée](nombre_expe_livree.png)

--- 
# Les données ont étés changés pour avoir de meilleurs résultats 

```
    ('2023-09-01', 1, 2, 150.00, 'En transit'),
    ('2023-08-02', 2, 3, 200.00, 'Livrée'),
    ('2023-08-03', 3, 4, 100.00, 'En transit'),
    ('2023-10-04', 4, 5, 75.00, 'En transit'),
    ('2023-11-05', 5, 1, 50.00, 'Livrée'),
    ('2023-09-06', 1, 3, 125.00, 'En transit'),
    ('2023-07-07', 2, 4, 175.00, 'Livrée'),
    ('2023-11-08', 3, 5, 225.00, 'En transit'),
    ('2023-10-09', 4, 1, 250.00, 'Livrée'),
    ('2023-11-10', 5, 2, 300.00, 'En transit');
```
---

### 4.7 Afficher le nombre total d'expéditions pour chaque mois de l'année en cours

La septième requête analyse les expéditions pour chaque mois de l'année en cours. Elle utilise la fonction YEAR() pour filtrer les expéditions de l'année en cours, puis agrège les données par mois.

```sql
SELECT MONTH(date_expedition) AS mois, COUNT(*) AS nombre_total_expeditions
FROM expeditions
WHERE YEAR(date_expedition) = YEAR(CURRENT_DATE)
GROUP BY mois;
```
![Nombre expe par mois](selection_nombre_expe_mois.png)


### 4.8 Afficher les entrepôts qui ont envoyé des expéditions au cours des 30 derniers jours

La huitième requête liste les entrepôts qui ont expédié des colis au cours des 30 derniers jours. Elle réalise une jointure interne avec la table expeditions et filtre les expéditions en fonction de la date.

```sql
SELECT DISTINCT e.id, e.nom_entrepot
FROM entrepots e
INNER JOIN expeditions ex ON e.id = ex.id_entrepot_source
WHERE DATEDIFF(NOW(), ex.date_expedition) <= 30;
```

![[entrepots_envoie_10_last_days.png]]

### 4.9 Afficher les entrepôts qui ont reçu des expéditions au cours des 30 derniers jours

La neuvième requête énumère les entrepôts qui ont reçu des expéditions au cours des 30 derniers jours. Elle fonctionne de manière similaire à la requête précédente, mais cette fois, elle considère les entrepôts de destination des expéditions.

```sql
SELECT DISTINCT e.id, e.nom_entrepot
FROM entrepots e
INNER JOIN expeditions ex ON e.id = ex.id_entrepot_destination
WHERE DATEDIFF(NOW(), ex.date_expedition) <= 30;
```
![[entrepots_recu_exp_30_last_day.png]]
### 4.10 Afficher les expéditions qui ont été livrées dans un délai de moins de 5 jours ouvrables

La dernière requête identifie les expéditions qui ont été livrées dans un délai de moins de 5 jours ouvrables. Elle examine la table expeditions, filtre les expéditions avec le statut "Livrée" et utilise la fonction DATEDIFF() pour calculer le délai.

```sql
SELECT *
FROM expeditions
WHERE statut = 'Livrée' AND DATEDIFF(date_expedition, NOW()) <= 5;
```
![[expeditions_livree_5_last_days.png]]

## <a name="5"></a>5. Requêtes complexes

### 5.1 Afficher les expéditions en transit initiées par un entrepôt en Europe et à destination d'un entrepôt en Asie

Cette requête affiche les expéditions en transit initiées par un entrepôt en Europe (France, Allemagne, Italie, Espagne) et à destination d'un entrepôt en Asie (Chine, Japon, Inde, Corée du Sud).

```sql
SELECT ex.*
FROM expeditions ex
INNER JOIN entrepots source ON ex.id_entrepot_source = source.id
INNER JOIN entrepots destination ON ex.id_entrepot_destination = destination.id
WHERE source.pays IN ('France', 'Allemagne', 'Italie', 'Espagne') 
  AND destination.pays IN ('Chine', 'Japon', 'Inde', 'Corée du Sud')
  AND ex.statut = 'En transit';
```

### 5.2 Afficher les entrepôts qui ont envoyé des expéditions à destination d'un entrepôt situé dans le même pays

Cette requête affiche les entrepôts qui ont envoyé des expéditions à destination d'un entrepôt situé dans le même pays. Elle identifie les entrepôts source et destination et les compare en termes de pays.

```sql
SELECT source.id, source.nom_entrepot, destination.id AS id_entrepot_dest, destination.nom_entrepot AS nom_entrepot_dest
FROM expeditions ex
INNER JOIN entrepots source ON ex.id_entrepot_source = source.id
INNER JOIN entrepots destination ON ex.id_entrepot_destination = destination.id
WHERE source.pays = destination.pays;
```
![[entrepot_envoie_meme_pays.png]]
### 5.3 Afficher les entrepôts qui ont envoyé des expéditions à destination d'un entrepôt situé dans un pays différent

Cette requête affiche les entrepôts qui ont envoyé des expéditions à destination d'un entrepôt situé dans un pays différent. Elle compare le pays de l'entrepôt source avec le pays de l'entrepôt de destination.

```sql
SELECT source.id, source.nom_entrepot, destination.id AS id_entrepot_dest, destination.nom_entrepot AS nom_entrepot_dest
FROM expeditions ex
INNER JOIN entrepots source ON ex.id_entrepot_source = source.id
INNER JOIN entrepots destination ON ex.id_entrepot_destination = destination.id
WHERE source.pays != destination.pays;
```
![[entrepot_envoie_pas_meme_pays.png]]
### 5.4 Afficher les expéditions en transit initiées par un entrepôt situé dans un pays dont le nom commence par la lettre "F" et pesant plus de 500 kg

Cette requête affiche les expéditions en transit initiées par un entrepôt situé dans un pays dont le nom commence par la lettre "F" et pesant plus de 500 kg.

```sql
SELECT ex.*
FROM expeditions ex
INNER JOIN entrepots source ON ex.id_entrepot_source = source.id
WHERE source.pays LIKE 'F%' AND ex.poids > 500 AND ex.statut = 'En transit';
```

### 5.5 Afficher le nombre total d'expéditions pour chaque combinaison de pays d'origine et de destination

Cette requête affiche le nombre total d'expéditions pour chaque combinaison de pays d'origine et de destination. Elle regroupe les expéditions en fonction des pays de l'entrepôt source et de l'entrepôt de destination.

```sql
SELECT source.pays AS pays_origine, destination.pays AS pays_destination, COUNT(*) AS nombre_total_expeditions
FROM expeditions ex
INNER JOIN entrepots source ON ex.id_entrepot_source = source.id
INNER JOIN entrepots destination ON ex.id_entrepot_destination = destination.id
GROUP BY source.pays, destination.pays;
```
![[expeditions_combi.png]]
### 5.6 Afficher les entrepôts qui ont envoyé des expéditions au cours des 30 derniers jours et dont le poids total des expéditions est supérieur à 1000 kg

Cette requête affiche les entrepôts qui ont envoyé des expéditions au cours des 30 derniers jours et dont le poids total des expéditions est supérieur à 1000 kg. Elle combine les entrepôts et les expéditions, filtre les données par date et poids, puis effectue une agrégation pour calculer le poids total.

```sql
SELECT e.id, e.nom_entrepot, SUM(ex.poids) AS poids_total_expeditions
FROM entrepots e
INNER JOIN expeditions ex ON e.id = ex.id_entrepot_source
WHERE DATEDIFF(NOW(), ex.date_expedition) <= 30
GROUP BY e.id, e.nom_entrepot
HAVING SUM(ex.poids) > 1000;
```

### 5.7 Afficher les expéditions qui ont été livrées avec un retard de plus de 2 jours ouvrables

Cette requête affiche les expéditions qui ont été livrées avec un retard de plus de 2 jours ouvrables. Elle filtre les expéditions en fonction de leur statut et de la différence de date.

```sql
SELECT *
FROM expeditions
WHERE statut = 'Livrée' AND DATEDIFF(date_expedition, NOW()) > 2;
```

### 5.8 Afficher le nombre total d'expéditions pour chaque jour du mois en cours, trié par ordre décroissant

Cette requête affiche le nombre total d'expéditions pour chaque jour du mois en cours, trié par ordre décroissant. Elle groupe les expéditions par jour, puis les trie en fonction de la date.

```sql
SELECT DATE(date_expedition) AS date, COUNT(*) AS nombre_total_expeditions
FROM expeditions
WHERE MONTH(date_expedition) = MONTH(CURRENT_DATE)
GROUP BY date
ORDER BY date DESC;
```

![[expeditions_ce_mois.png]]
## <a name="6"></a>6. TSQL

### 6.1 Créer une vue qui affiche les informations pour chaque entrepôt : nom de l'entrepôt, adresse complète, nombre d'expéditions envoyées au cours des 30 derniers jours.

Cette vue crée un aperçu des informations des entrepôts en affichant le nom de l'entrepôt, l'adresse complète, et le nombre d'expéditions envoyées au cours des 30 derniers jours. Elle regroupe les données de la table entrepots avec les données de la table expeditions en utilisant une jointure gauche (LEFT JOIN) pour compter les expéditions associées à chaque entrepôt.

```sql
CREATE VIEW Vue_Entrepot_Informations AS
SELECT e.id, e.nom_entrepot, e.adresse, e.ville, e.pays, COUNT(ex.id) AS nombre_expeditions_30_jours
FROM entrepots e
LEFT JOIN expeditions ex ON e.id = ex.id_entrepot_source
WHERE DATEDIFF(CURDATE(), ex.date_expedition) <= 30
GROUP BY e.id, e.nom_entrepot, e.adresse, e.ville, e.pays;
```
![[vue_entrepot.png]]
### 6.2 Créer une procédure stockée qui prend en entrée l'ID d'un entrepôt et renvoie le nombre total d'expéditions envoyées par cet entrepôt au cours du dernier mois.

Cette procédure stockée accepte l'ID d'un entrepôt en entrée et renvoie le nombre total d'expéditions envoyées par cet entrepôt au cours du dernier mois. Elle effectue une requête sur la table expeditions, filtrant les expéditions par ID d'entrepôt source et par date d'expédition au cours du dernier mois.

```sql
DELIMITER //

CREATE PROCEDURE GetTotalExpeditionsLastMonth(entrepot_id INT)
BEGIN
    SELECT COUNT(*) AS TotalExpeditions
    FROM expeditions
    WHERE id_entrepot_source = @entrepot_id
    AND date_expedition >= DATEADD(MONTH, -1, GETDATE());
END //

DELIMITER ;
```
![[stored_procedure.png]]
### 6.3 Créer une fonction qui prend en entrée une date et renvoie le nombre total d'expéditions livrées ce jour-là.

Cette fonction prend une date en entrée et renvoie le nombre total d'expéditions livrées ce jour-là. Elle utilise une variable pour stocker le nombre total, puis effectue une requête sur la table expeditions, filtrant les expéditions par date et par statut "Livrée".

```sql
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
```

## <a name="7"></a>7. Bonus

### 7.1 Créer une table "clients"

Cette requête crée une nouvelle table nommée "clients" avec les colonnes id, nom, adresse, ville, et pays. L'ID est défini comme une clé primaire auto-incrémentée, garantissant des identifiants uniques pour chaque client.

```sql
CREATE TABLE clients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255),
    adresse VARCHAR(255),
    ville VARCHAR(255),
    pays VARCHAR(255)
);
```

### 7.2 Créer une table de jointure "expeditions_clients"

Cette requête crée une table de jointure nommée "expeditions_clients" pour gérer les relations entre les expéditions et les clients. Elle contient deux colonnes, id_expedition et id_client, qui sont des clés étrangères faisant référence aux tables "expeditions" et "clients", respectivement. Cette table permet d'associer chaque expédition à un client.

```sql
CREATE TABLE expeditions_clients (
    id_expedition INT,
    id_client INT,
    FOREIGN KEY (id_expedition) REFERENCES expeditions(id),
    FOREIGN KEY (id_client) REFERENCES clients(id)
);
```

### 7.3 Modifier la table "expeditions" pour ajouter la colonne "id_client"

Cette requête modifie la table "expeditions" en ajoutant une nouvelle colonne nommée "id_client". Cette colonne est définie comme une clé étrangère qui fait référence à la table "clients". Ainsi, chaque expédition peut être associée à un client spécifique.

```sql
ALTER TABLE expeditions
ADD id_client INT,
ADD FOREIGN KEY (id_client) REFERENCES clients(id);
```