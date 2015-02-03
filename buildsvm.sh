#!/bin/sh

for line in $(wget -qO- $1 | dos2unix); do
    ./histo $line
    #echo $line
done