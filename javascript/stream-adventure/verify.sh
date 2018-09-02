#!/bin/bash

files=( *js )
#relies that the files come in the correct order
last_file="${files[${#files[@]}-1]}"

while ! stream-adventure verify "$last_file"; do
    sleep 10
done
