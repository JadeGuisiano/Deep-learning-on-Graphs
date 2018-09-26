
Dossier NEO4J : 
    
le sous dossier Donnees-input contient les données des délits de la ville de montreal organisées de deux facons différentes :
        - le sous dossier Donnees-originelles contient le fichier csv complet des crime de 2017 a 2018  
		
Extrait des 4 premières lignes 

CATEGORIE	DATE	QUART	PDQ	LAT	LONG
Introduction	2018-04-01	nuit	5	45.4666801963538	-73.8211663899862
Introduction	2018-04-01	jour	5	45.4700646346079	-73.8244748633374
Méfait	2018-04-01	jour	5	45.4625627564722	-73.8292167425863


        - le sous dossier Donnees-par-periode-pdq contient 3 sous dossiers représantant 3 périodes 
                    - periodes du 21 au 25 mars 2018 / 22 au 26 mars 2018 / 27 au 31 mars
                    - dans chaque dossier de chaque période sont contenues les données originelles découpée par PDQ

le sous dossier Outputs contients les deux fichiers CSV obtenu aprés export des graphes des délits.
        - le fichier CSV Crime_ contient indicateur de graphe, label des noeuds,  et les attributs des noeuds
        - le fichier Crime_A contient la matrice d'adjacence 
		
Extrait 3 lignes du fichier Crime_

"n.G","""n.ID""","""n.CATEGORIE""","""n.DATE""","""n.QUART""","""n.PDQ""","""n.LAT""","""n.LONG"""
1,90,"""Mï¿½fait""","""2018-03-31""","""soir""",23,45.5474975160032,-73.5474517276607
1,91,"""Introduction""","""2018-03-30""","""soir""",23,45.5571799133696,-73.5319747490465

Extrait 3 lignes fichier Crime_A

"n.ID","""m.ID"""
607,599
608,599


le document AIDE_CODE_CYPHER_NEO4J présente un extrait des différentes commandes possible pour la manipulation de NEO4J
le document CODE-EXPORT-CSV-NEO4J contient les requêtes Neo4j pour extraire les graphes
le document Import-CRIME-NSEO-NODES-LINK contient le code Neo4j pour la création de noeuds et relations des 3 périodes (LES RELATIONS ETANT UNIQUES)
le document RELATIONS-NSEO-COMPLETE-DOUBLON contient les code Neo4j pour la création de relations doubles entre les noeuds  

Pratique :

- Placer les fichiers csv de toutes les périodes du dossier Donnees-par-periode-pdq dans le repertoire IMPORT de l'installation neo4j (Si Neo4j est installé en local)
   Par exemple :  Neo4jDesktop\neo4jDatabases\database-5bb2fc8a-d23f-4545-b2f3-1819541b57d0\installation-3.4.0\import

- Commencer a importer les données en noeud et relation sous Neo4j via le code du fichier Import-CRIME-NSEO-NODES-LINK etablissant une seule relation entre deux noeuds, 
pour etablir une double relation dans les deux sens entre chaque noeud se servir du code présent dans le fichier RELATIONS-NSEO-COMPLETE-DOUBLON

Exemple creation d'un noeud : 

LOAD CSV WITH HEADERS FROM "file:///PDQ1.csv" AS line FIELDTERMINATOR ';'
CREATE (P1:PDQ1 { CATEGORIE: line.CATEGORIE, DATE: line.DATE, QUART: line.QUART, PDQ: toInteger(line.PDQ), LAT: toFloat(line.LAT), LONG: toFloat(line.LONG),
ID: toInteger(line.ID), G:7, QUARTIER:'Baie-DUrfé, Beaconsfield, Kirkland, Sainte-Anne-de-Bellevue, Senneville',SIT:'Ouest' })

Exemple creation d'une relation : 

MATCH (P12M:PDQ12M),(P15M:PDQ15M) CREATE (P12M)-[r:RELATED_TO]->(P15M)


- Pour analyser via requête le graphe et effectuer des corrections des noeuds ou relations se referer au fichier d'aide pour le langage Cypher AIDE_CODE_CYPHER_NEO4J

- Concernant l'export des graphes realisés sous Neo4j, d'abord effectuer des requêtes permettant d'organiser, trier, choisir ce que l'on veut exporter via le code du fichier CODE-EXPORT-CSV-NEO4J
puis clic-bouton sur l'interface neo4j : export format CSV.

Exemple d'une requête : 

MATCH (n) RETURN n.G, n.ID, n.CATEGORIE,n.DATE, n.QUART,n.PDQ, n.LAT, n.LONG ORDER BY n.G

- Les sorties brutes format CSV obtenues pour les délits de montreal en 12 graphes (4 graphes (Nord,sud,est,ouest) par période (3 periodes) sont dans le dossier Outputs





