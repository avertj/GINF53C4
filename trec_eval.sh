#!/bin/bash

declare -a c=("aeroplane" "bicycle" "bird" "boat" "bottle" "bus" "car" "cat" "chair" "cow" "diningtable" "dog" "horse" "motorbike" "person" "pottedplant" "sheep" "sofa" "train" "tvmonitor")

mkdir -p trec

for concept in "${c[@]}"
do
    ./trec_eval.9.0/trec_eval rel/${concept}.rel top/color_${concept}.top > trec/${concept}.trec
done
