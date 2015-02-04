# GINF53C4
TP Indexation Multimédia

http://mrim.imag.fr/GINF53C4/PROJET/

Pour générer train.svm et val.svm, executer

	$ sh buildsvm.sh http://mrim.imag.fr/GINF53C4/PROJET/train/urls.txt > train.svm
	$ sh buildsvm.sh http://mrim.imag.fr/GINF53C4/PROJET/val/urls.txt > val.svm

ATTENTION ! C'est long !!

Pour générer les fichiers annotés

	$ ./apply_ann [svm] [ann] > [result]

