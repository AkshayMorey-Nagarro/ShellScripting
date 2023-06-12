#!/bin/bash

words=("ab" "cd" "ef")

function permute() {
    arr=("$@")
    len=${#arr[@]}

    # base case
    if [[ $len -eq 1 ]]; then
        echo "${arr[0]}"
        return
    fi

    #recursive
    for (( i = 0; i < len; i++ ))
    do
        first=${arr[i]}
        rest=("${arr[@]:0:i}" "${arr[@]:i+1}")
        permute "${rest[@]}" | while read -r p; do
            echo "$first$p"
        done
    done
}

echo "$(permute "${words[@]}")" #| sort | uniq