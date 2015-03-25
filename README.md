# GINF53C4
TP Indexation Multimédia

http://mrim.imag.fr/GINF53C4/PROJET/

Pour générer train.svm et val.svm, executer

	$ sh buildsvm.sh http://mrim.imag.fr/GINF53C4/PROJET/train/urls.txt > train.svm
	$ sh buildsvm.sh http://mrim.imag.fr/GINF53C4/PROJET/val/urls.txt > val.svm

ATTENTION ! C'est long !!

Pour générer les fichiers annotés

	$ ./apply_ann [svm] [ann] > [result]



examples d'exec pour 4.4 et 4.5

	$ ./swift.sh http://mrim.imag.fr/GINF53C4/PROJET/train/sift/liste_train_sift.txt

    $ ./process_1nn_sift_threaded.sh http://mrim.imag.fr/GINF53C4/PROJET/train/sift/liste_train_sift.txt sift/train/1nn

à faire : 4.6 (parser les fichiers sift générés et créer des histo) puis refaire les procedures precedentes