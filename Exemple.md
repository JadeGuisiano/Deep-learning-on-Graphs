
PIPELINE INTEGRAL - CAS DONNEE CRIME DE MONTREAL - 



(1) ___Neo4j___ :

Desctiption fichier CSV / sous-dossier Donnees-input : 
    -  3 dossier représentant 3 periodes
    -  chaque periode contient 32 fichiers CSV repésentant les PDQ de la ville (1 PDQ = un fichier CSV)
    
les 32 * 3 fichier CSV, pour pouvoir être lu par Neo4j doivent être placés dans le dossier import de Neo4j 
Exemple de localisation de se dossier : C:\Users\guisiaja\.Neo4jDesktop\neo4jDatabases\database-5bb2fc8a-d23f-4545-b2f3-1819541b57d0\installation-3.4.0\import
        

Import de ces données via création de noeuds et de relations unique entre deux noeuds / fichier Import-CRIME-NSEO-NODES-LINK
Possibilité de créer une double relation (Double ou uniaue relation ne change rien pour le traitement par DGCNN) / fichier RELATIONS-NSEO-COMPLETE-DOUBLON 


Pour établir des corrections dimport (supprimer noeud/s et/ou relation/s) ou manipuler le graphe / fichier AIDE_CODE_CYPHER_NEO4J

Pour exporter les graphes, faire des requêtes pour sortir ce que lon veux précisement / fichier CODE-EXPORT-CSV-NEO4J

Les outputs obtenus aprés export / sous-dossier Ouputs 




(2) ___Python___ :
    
Nettoyage des exports Neo4j (Supréssion caractère inutiles, passage qualitatif vers quantitatif ....)
Et reorganisation de ces exports en 5 fichiers texte (1) a (5) (Pour le cas Neo4j) : / fichier Scripts-transform-neo4j-output
    
(1) _A.txt (m lignes) matrice d'adjacence fragmentée (= seules les valeurs positives sont conservées) pour tous les graphes, chaque ligne correspond à (ligne, colonne) resp. (node_id, node_id).
(2) _graph_indicator.txt (n lignes) vecteur de colonne d'identifiants de graphe pour tous les noeuds de tous les graphes, la valeur dans la i-ème ligne est le graph_id du noeud avec node_id i.
(3) _graph_labels.txt (N lignes) étiquettes de classe pour tous les graphes du jeu de données, la valeur dans la i-ème ligne est l'étiquette de classe du graphique avec graph_id i.
(4) _node_labels.txt (n lignes) vecteur de colonne des étiquettes de noeud, la valeur dans la i-ème ligne correspond au noeud avec node_id i.

Puis les fichiers texte optionnels :
    
(5) _edge_labels.txt (m lignes) étiquettes pour les bords dans _A.txt.
(6) _edge_attributes.txt (m lignes) attributs pour les bords dans _A.txt.
(7) _node_attributes.txt (n lignes) matrice d'attributs de noeud, les valeurs séparées par des virgules dans la i-ème ligne sont le vecteur d'attribut du noeud avec node_id i.
(8) _graph_attributes.txt (N lignes) les valeurs de régression pour tous les graphiques du jeu de données, la valeur dans la i-ème ligne est l'attribut du graphique avec graph_id i.
    

Visualisation de la sortie de se script (donc des 5 fichiers crées) / sous-dossier Ouput-files




(3) ___Matlab___ :
    
Deplacer les fichiers texte du sous dossier Ouput-file du dossier Pyton dans un nouveau sous sous dossier nommé CRIME
en reference a notre base de donnée dans le sous dossier data du dossier pytorch_DGCNN-master.

Ouvrir le script Matlab dortmund2tx du sous sous dossier data et chnager dans ce script uniquement la premiere ligne du script
datasets = strvcat('CRIME'); en saisisant le nom du dossier ou se situe nos 5 fichiers textes. 

Executer le script 

ce script va permettre de transformer nos 5 fichier en un seul prenant la forme suivante : 


                                N
                                n l
                                t m d

Où N est le nombre de graphe, n le nombre de noeud par graphe, l est le label du graphe, 
t est l’étiquette du noeud courant, m est le nombre de noeud voisin du noeud courant – 
suivis par les étiquettes de chacun de ces noeuds voisins – et enfin d sont les features du noeud courant.

puis de creer 10 echantillons entrainement et 10 echantillons test dans notre sous sous dossier CRIME nommé 10fold_idx


Pour voir un exemple de ce format et le nouveau dossier 10fold_idx / dossier pytorch_DGCNN-master sous dossier data et ouvrir un des jeux de donnée (COLLAB,DD...)
et regarder le document texte et le fichier 10fold_idx



(4) ___DGCNN___ :
    
Insertion du nom de notre dossier CRIME  et modification hyperpametres (learning rate, epoch, etc.) / fichier (shell script) run_DGCNN du dossier pytorch_DGCNN-master

Sous pytorch exectuer la commande suivante pour lancer lalgo DGCNN : ./run_DGCNN.sh DATANAME 
Possibilité de spécifier un des echantillon de test a utilisé via la commande : ./run_DGCNN.sh DATANAME FOLD
    


    
///        Github auteurs pour detail méthode originel : https://github.com/muhanzhang/pytorch_DGCNN      ///


///   Données utilisée par auteur sur le site suivant : https://ls11-www.cs.tu-dortmund.de/staff/morris/graphkerneldatasets    ///



