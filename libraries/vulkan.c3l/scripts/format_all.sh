#! /bin/bash

for i in "$@"; do
    echo -ne "\r=> Formatting [$i]."
    ./$(dirname "$0")/format_functions.sh $i
    echo -ne "\r=> Formatting [$i].."
    ./$(dirname "$0")/format_constants.sh $i
    echo -ne "\r=> Formatting [$i]..."
    ./$(dirname "$0")/format_enums.sh $i
    echo -ne "\r=> Formatting [$i]...."
    ./$(dirname "$0")/format_structs.sh $i
    echo -ne "\r=> Formatting [$i]....."
    ./$(dirname "$0")/format_types.sh $i
    echo "Done!"
done
