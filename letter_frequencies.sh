#!/bin/bash
filename="${1:-assets/letter.txt}"

# check if file exists
if [[ ! -f "$filename" ]]
then
    echo File $filename does not exist!
    exit 1
fi

cat "$filename" |
#replace space with newline
    tr -s '[:space:]' '\n' |
#replace single quotes with space
    tr "'" ' ' |
#replace punctuations with newline
    tr -s '[:punct:]' '\n' |
#replace space with single quotes
    tr ' ' "'" |
#change upper case to lower case
    tr '[:upper:]' '[:lower:]' | 
#match all non-empty
    grep -v '^$' | 
#sort to apply uniq    
    sort |
#remove duplicate line and keep the count
    uniq -c |
#reverse sort numeric field by value
    sort -nr | 
#exchange the word and the count
    awk '{print $2 " " $1}'