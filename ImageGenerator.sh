#!/bin/bash

if test "$#" -ne 2; then
    echo "Usage: ./FileGenerator image_x image_y"
    exit 1
fi

for i in $(seq 0 $(($1 - 1)));
do
    for j in $(seq 0 $(($2 - 1)));
    do
        printf "($i,$j) ($(($RANDOM % 256)),$(($RANDOM % 256)),$(($RANDOM % 256)))\n"
    done
done
