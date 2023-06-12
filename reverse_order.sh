#! /usr/bin/bash

if [[ $# == 0 ]]
then
    echo 'ERROR: No argument!'
    exit 1
else
    text=$1
    length=${#text}
    output=""
    for ((i=$length-1;i>=0;i--))
    do
        output="${output}${text:i:1}"
    done
    echo Reverse value is \"$output\"
fi