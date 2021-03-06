#!/bin/bash

declare -a c=("aeroplane" "bicycle" "bird" "boat" "bottle" "bus" "car" "cat" "chair" "cow" "diningtable" "dog" "horse" "motorbike" "person" "pottedplant" "sheep" "sofa" "train" "tvmonitor")

for concept in "${c[@]}"
do
    ./apply_ann train/svm/color.svm http://mrim.imag.fr/GINF53C4/PROJET/train/ann/${concept}.ann > train/svm/color_${concept}.svm
done