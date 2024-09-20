#!/bin/bash

sed -i '/typedef\|bitstruct/!s/struct\s*\(.*\)/\1/g' $1
echo "$(awk -f ./scripts/structs.awk $1)" > $1
