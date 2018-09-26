
le sous dossier Output-files contient les 5 fichiers texte d'informations des graphes des délits :
    - Les fichiers sont organisé de la façon suivante (DANS NOTRE CAS DES DELITS LES FICHIERS DOUTPUT SONT DE CEUX DE (1) A (5)):
        
(1) _A.txt (m lignes) matrice d'adjacence fragmentée (= seules les valeurs positives sont conservées) pour tous les graphes, chaque ligne correspond à (ligne, colonne) resp. (node_id, node_id).
(2) _graph_indicator.txt (n lignes) vecteur de colonne d'identifiants de graphe pour tous les noeuds de tous les graphes, la valeur dans la i-ème ligne est le graph_id du noeud avec node_id i.
(3) _graph_labels.txt (N lignes) étiquettes de classe pour tous les graphes du jeu de données, la valeur dans la i-ème ligne est l'étiquette de classe du graphique avec graph_id i.
(4) _node_labels.txt (n lignes) vecteur de colonne des étiquettes de noeud, la valeur dans la i-ème ligne correspond au noeud avec node_id i.

Puis les fichiers texte optionnels :
    
(5) _edge_labels.txt (m lignes) étiquettes pour les bords dans _A.txt.
(6) _edge_attributes.txt (m lignes) attributs pour les bords dans _A.txt.
(7) _node_attributes.txt (n lignes) matrice d'attributs de noeud, les valeurs séparées par des virgules dans la i-ème ligne sont le vecteur d'attribut du noeud avec node_id i.
(8) _graph_attributes.txt (N lignes) les valeurs de régression pour tous les graphiques du jeu de données, la valeur dans la i-ème ligne est l'attribut du graphique avec graph_id i.


Pour voir les exemples compositions de ces fichiers, consulter le sous dossier Output-files du dossier Python contenant les exemples (1) a (5) format texte



Le fichier Scripts-transform-neo4j-output permet de :  
- nettoyer les outputs de Neo4j du sous dossier Outputs du dossier Neo4j
- Decouper les outputs Neo4j en 5 fichier texte des format (1) a (5) decrits ci-dessus 

