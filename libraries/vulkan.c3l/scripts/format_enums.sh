#! /bin/bash
echo "$(awk -f ./scripts/enums.awk $1)" > $1
echo "$(awk -f ./scripts/objc.awk $1)" > $1

