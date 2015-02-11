#!/bin/bash

declare -a c=("aeroplane" "bicycle" "bird" "boat" "bottle" "bus" "car" "cat" "chair" "cow" "diningtable" "dog" "horse" "motorbike" "person" "pottedplant" "sheep" "sofa" "train" "tvmonitor")

for concept in "${c[@]}"
do
    ./top_convertor ${concept} out/color_${concept}.out http://mrim.imag.fr/GINF53C4/PROJET/train/ann/${concept}.ann > top/color_${concept}.top
done