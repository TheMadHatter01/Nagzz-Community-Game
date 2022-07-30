#!/bin/sh
lines=$(git diff HEAD --name-only | grep --regex '.gd$')
without_non_existent=""
declare -i number_of_files
number_of_files=0
for line in $lines
do
    if [ -f $line ]; then
        number_of_files=$((number_of_files+1))
        without_non_existent="$without_non_existent $line"
    fi
done

echo "\e[32mNumber of files: \e[1m$number_of_files\e[0m"
echo "\e[33m$without_non_existent\e[0m"
gdlint $without_non_existent
