#!/bin/bash

# Read filename from args or default to agenda.txt
filename="${1:-assets/agenda.txt}"

# check if file exists
if [[ ! -f "$filename" ]]
then
    echo File $filename does not exist!
    exit 1
fi

# variable to store collection of events on each date
declare -A calendar

while read -r line;
do
    # if the line is a valid date, convert it to the date
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
        #if the line is an event, add the event to last read date. Seperate events by '|'
        calendar["$key"]=${calendar["$key"]}" | "$line
    fi
done < "$filename"

# Loop through calendar and display the results for today and tomorrow
for key in "${!calendar[@]}"; 
do
    if [[ $key == $( date +%m-%d-%Y -d "today" ) || $key == $( date +%m-%d-%Y -d "tomorrow" ) ]]; then
        echo ${key}: ${calendar[$key]} | sed -e "s/: | /: /" | tr -s '|' ','
    fi
done