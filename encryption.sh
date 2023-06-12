#!/bin/bash

# First arg is the password
password=$1
shift
while [[ "$#" -gt 0 ]]
  do
    case $1 in
      -a|--algo) algo=1; shift;;
      -t|--text) text=1; shift;;
      -l|--length) length=1; shift;;
    esac
    shift
done

# if empty password provided, use a random number to hash
if [[ $password == "" ]]; then
    password=$RANDOM
fi

algo_names=(SHA1 SHA256 SHA512 MD5)
algo_func=(sha1sum sha256sum sha512sum md5sum)
algo_length=${#algo_func[@]}

for (( i=0; i<${algo_length}; i++ )); do
    hash=$(echo -n "$password" | ${algo_func[$i]} | awk '{print $1}')
    echo "Encrypted password: $hash"
    if [[ $algo == 1 ]]; then
        echo "Algo Name: ${algo_names[$i]}"
    fi
    if [[ $text == 1 ]]; then
        echo "Text: $password"
    fi
    if [[ $length == 1 ]]; then
        echo "Password length: ${#password}"
        echo "Hash length: ${#hash}"
    fi
    echo
done

# keyed hash
hash=$(echo -n "$password" | openssl sha1 -hmac "key" | awk '{print $2}')
echo "Encrypted password: $hash"
if [[ $algo == 1 ]]; then
    echo "Algo Name: HMAC-SHA1"
fi
if [[ $text == 1 ]]; then
    echo "Text: $password"
fi
if [[ $length == 1 ]]; then
    echo "Password length: ${#password}"
    echo "Hash length: ${#hash}"
fi
echo