#!/bin/bash

# question 4.5
# version threadée pour essayer d'ameliorer les perfs

# ATTENTION, CE SCRIPT LANCE DES THREADS QUI SONT IMPOSSIBLES A ARRETER TANT
# QU'ILS N'ON PAS FINI LEUR TRAVAIL !
# A UTILISER AVEC PRECAUTION
# si c'est la merde, essayer :
#    kill -9 $(pgrep process_1nn_sif)

# arg 1 : url vers fichier liste de sift
# arg 2 : repertoire de destination des fichiers resultat

IFS='
'

# recuperation de la liste d'url
wget -qO- $1 | dos2unix > tmp_$$.list

# nombre de fichiers à traiter
lines=$(wc -l tmp_$$.list | cut -d" " -f1)
# nombre de fichiers par thread
lpt=500 #lines per thread
# nombre de threads
threads=$(((lines / lpt) + 1))

echo $lines

for i in $(seq 1 $threads)
do
    (
        # calcul des lignes assignées au thread $i
        st=$(( (i - 1) * lpt ))
        fn=$((st + lpt))
        st=$(( st + 1 ))

        # si c'est le dernier thread, on prends toute les lignes restantes
        if [ "$i" -eq "$threads" ]
        then
            st=$(( (i - 1) * lpt ))
            fn="$"
        fi

        echo "thread $i line $st to $fn"

        # pour chaque ligne
        for line in $(sed -n "$st , $fn p" tmp_$$.list)
        do
            # si la ligne ne commence pas par http
            # (pour la liste sift val par ex)
            if [ "$(echo $line | cut -c 1-4)" != "http" ]
            then
                # on ajoute l'url correcte au nom du fichier
                line=$(echo $1 | cut -d"/" -f-7)/$line
            fi
            echo $line
            # on lit le fichier sift
            for subline in $(wget -qO- $line | dos2unix | tail -n +4)
            do
                    #on vire l'inutile (<CIRCLE ....>, etc)
                    echo $subline | cut -d';' -f2 | cut -c2- >> "tmp_$$-$i.sift"
            done
            # on fait le traitement donné (on utilise des fichiers threadsafe (concatenation pid + numero thread))
            R --slave --no-save --no-restore --no-environ --args centers256.txt 256 "./tmp_$$-$i.sift" "./res_$$-$i.sift" < 1nn.R
            mv "./res_$$-$i.sift" $2/$(echo $line | cut -d'/' -f8)
            rm -f "./tmp_$$-$i.sift" "./res_$$-$i.sift"
        done

    )& # ici on lance les threads grace au &
done

# TODO : cleanup tmp_x.list