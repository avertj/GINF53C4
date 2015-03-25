#!/bin/sh

TMPIFS=$IFS
IFS='
'

for line in $(wget -qO- $1 | dos2unix)
do
    echo $line
    #echo $(echo $line | cut -d'/' -f8)
    i=0
    for subline in $(wget -qO- $line | dos2unix)
    do
        if [ "$i" -gt "2" ]
        then
            #if [ `echo "$i % 75" | bc` -eq 0 ]
            #then
                echo $subline | cut -d';' -f2 | cut -c2- >> tmp.sift
            #fi
        fi
        i=`expr $i + 1`
    done
    R --slave --no-save --no-restore --no-environ --args centers256.txt 256 ./tmp.sift ./res.sift < 1nn.R
    mv ./res.sift sift/train/1nn/$(echo $line | cut -d'/' -f8)
    rm -f ./tmp.sift ./res.sift
done

#for f in /u/m/mulhemp/sift/train/*.sift
#do
#  echo "Traitrement de $f"
#  sed -n '4,$p' $f | tr -d ";" | sed 's/<CIRCLE [1-9].*> //' > ./trav.sift
#  R --slave --no-save --no-restore --no-environ --args centers256.txt 256 ./trav.sift ./res.sift < 1nn.R
#  mv ./res.sift sift/train/1nn/`basename $f`
#done

#\rm -f ./trav.sift ./res.sift

