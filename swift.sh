#!/bin/sh

# question 4.4

TMPIFS=$IFS
IFS='
'

for line in $(wget -qO- $1 | dos2unix)
do
    echo $line
    i=0
    for subline in $(wget -qO- $line | dos2unix)
    do
        if [ "$i" -gt "2" ]
        then
            if [ `echo "$i % 75" | bc` -eq 0 ]
            then
                echo $subline | cut -d';' -f2 | cut -c2- >> sample.txt
            fi
        fi
        i=`expr $i + 1`
    done
done

R --slave --no-save --no-restore --no-environ --args ./samples.txt 256 ./centers256.txt 10 < kmeans_clustering.R