#!/bin/bash

filename="${1:-assets/agenda.txt}"

# check if file exists
if [[ ! -f "$filename" ]]
then
    echo File $filename does not exist!
    exit 1
fi

declare -A calendar

while read -r line;
do
    date=$( date +%m-%d-%Y -d "$line" 2> /dev/null )
    if [[ $date == "" ]]
    then
        #check for dd-mm-yy format
        IFS="-/" read d m y <<< $line
        date=$( date +%m-%d-%Y -d "$m/$d/$y" 2> /dev/null )
    fi
    # echo $date: $line
    if [[ $date != "" ]]
    then
        key="$date"
    else
        calendar["$key"]=${calendar["$key"]}" | "$line
    fi
done < "$filename"

for key in "${!calendar[@]}"; 
do
    if [[ $key == $( date +%m-%d-%Y -d "today" ) || $key == $( date +%m-%d-%Y -d "tomorrow" ) ]]; then
        echo ${key}: ${calendar[$key]} | tr -s '|' '\n'
    fi
done