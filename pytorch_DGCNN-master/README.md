
Première étape : 

- Exporter outputs du dossier python vers un nouveau sous dossier du dossier data

- Lancer le script Matlab dortmund2txt présent dans le dossier data en veillant a mettre le nom correct du dataset utilisé sur la premiere ligne de ce script

- Lexécution du script va permettre la création du nouveau fichier texte decrivant tous nos graphes et dun dossier contenant 10 echantillons test et 10 echantillons dentrainement sous format texte

            - le nouveau fichier texte decrivant les graphes est organisé de la facon suivante :

                                N
                                n l
                                t m d

Où N est le nombre de graphe, n le nombre de noeud par graphe, l est le label du graphe, t est l’étiquette du noeud courant, m est le nombre de noeud voisin du noeud courant – suivis par les étiquettes de chacun de ces noeuds voisins – et enfin d sont les features du noeud courant.

Pour le lancement de lalgorithne DGCNN seulement le nouveau fichier texte et le dossiers des echantillons sera utiles. 



Dexième étape : MODIFICATION DU FICHIER PRINCIPAL DE LANCEMENT DE LA MÉTHODE DGCNN

- Insertion du nom de sa base de donnée (nom du sous dossier du dossier data)
- Modification des hyperpamétres 

