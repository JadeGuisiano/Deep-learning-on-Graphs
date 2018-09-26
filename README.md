# Deep Learning on graph :
# Extraction et traitement de l'information des graphes par réseaux de neurones convolutifs





## **Présentation du sujet** 


La modélisation des données sous forme de graphe permet de visualiser les connexions complexes entre les données.
Cette modélisation a l'avanatge de générer features supplémentaires telles que la similarité de voisinage, la distance entre les nœuds, 
les labels de communautés, etc. Le machine learning permet de passer d'une analyse purement visuelle a une analyse plus approfondie voire
même a des prédictions  : détection de communauté, la prédiction de lien, prédiction d'appartenancea une classe, etc. 

Le choix de la méthode porte sur une des méthode du domaine de deep learning : **les réseaux de neurones convolutifs**.
Ces derniers sont réputés comme étant une des meilleures méthodes de traitement d'image du fait leur capacité a traiter des
élements de facon locale.

**Probléme**: Les réseaux de neurones convolutifs traite uniquement des données définies dans un espace Euclidien tels que les images,
vidéos, texte, etc.



Une récente méthode porpose de pallier ce probléme : 

 - **DGCNN.pdf** - Deep Graph Convolutional Neural Network  
 



La méthode DGCNN propose une **nouvelle architecture** de réseaux de neurones convolutifs :

- Ajout de couches de convolution dont le fonctionememt est inspiré des méthode de propagation de noyau et de noyau de sous arbre 
  (Weisfeiler-Lehman)
- Définition d'une procédure d'établissement d'ordre coherent des sommets. 



_**Pour plus de détails** : Rapport_de_stage_J.GUISIANO.pdf_




**DGCNN** :
 
 1) Import des fichiers CSV sous neo4j (création de noeuds et relations)  :  _CRIME-MONTREAL 2017-2018.csv, Import-CRIME-NSEO-NODES-    LINKS.txt ou  RELATIONS-NSEO-COMPLETE-DOUBLONS.txt, AIDE_CODE_CYPHER_NEO4J.txt_
 
 2) Export des des graphes Neo4j vers fichiers CSV (requêtes et clic-bouton) : _CODE-EXPORT-CSV-NEO4J.txt_ 
 et donne les fichiers suivants : _Crime_.csv / Crime_A.csv_
 
 3) Transformation des output CSV de neo4j via script python et sortie fichier txt : _Code-transform-neo4j-output.txt_
   et donne les fichiers suivants : _CRIME_A.txt / CRIME_graph_indicator.txt / CRIME_graph_labels.txt / CRIME_node_attributes.txt / CRIME_node_labels.txt_
   
 
 4) Import fichiers txt vers scripts Matlab
 
 5) Lancement de la méthode DGCNN sur les données 
 
 
 
 
#### Jeux de données  

Fichier CSV - Rescencement des actes criminels enregistrés par le Service de police de la Ville de Montréal (SPVM)
http://donnees.ville.montreal.qc.ca/dataset/actes-criminels

Compléments au fichier CSV :

Association des numéros de PDQ avec les noms des zones 
https://spvm.qc.ca/fr/PDQ

Regroupement des PDQ en situations géographique (Nord, Sud, Est, Ouest)
http://www1.ville.montreal.qc.ca/banque311/webfm_send/394


Restriction du fichier CSV aux **années 2017-2018** : CRIME-MONTREAL 2017-2018.csv


Lien Github auteurs DGCNN : https://github.com/muhanzhang/pytorch_DGCNN
Lien données utilisée par auteurs pour tests : https://ls11-www.cs.tu-dortmund.de/staff/morris/graphkerneldatasets

```
---
title
---
```