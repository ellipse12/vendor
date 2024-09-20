#! /bin/bash

sed -i 's/#define \(.*\)\s* \(.*\)/const \1 = \2;/' $1
sed -i 's/static const/const/' $1
#sed -i 's/MAT\([0-9]\)x\([0-9]\)/MAT\1X\2/' $1
