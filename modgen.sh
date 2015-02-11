#!/bin/bash

declare -a c=("aeroplane" "bicycle" "bird" "boat" "bottle" "bus" "car" "cat" "chair" "cow" "diningtable" "dog" "horse" "motorbike" "person" "pottedplant" "sheep" "sofa" "train" "tvmonitor")

for concept in "${c[@]}"
do
    svm-train -w+1 19 -b 1 train/svm/color_${concept}.svm model/color_${concept}.model

    svm-predict -b 1 val/svm/color.svm model/color_${concept}.model out/color_${concept}.out
done