#! /bin/bash
OLD_IFS=$IFS
IFS=$'\n'
proto=($(sed -n "s/typedef \(.*\) (GLAD_API_PTR \*\(\w*\))(\(.*\));/\2;\1;\3/p" $1))
IFS=$OLD_IFS
for i in "${proto[@]}"; do
    IFS=';'
    read -ra proto2 <<< "$i"
    glad_function=$(sed -n "s/GLAD_API_CALL ${proto2[0]} \(\w*\);/\1/p" $1)
    function=$(sed -n "s/#define \(\w*\) \<${glad_function}\>/\1/p" $1)
    out_name=$(echo $function | sed -n "s/vk\(.\)/\L\1/p")
    ftype="${proto2[1]}"
    params="${proto2[2]}"
    sed -i "/.*GLAD_API_PTR.*/d" $1
    sed -i "/#define \w* \<${glad_function}\>/d" $1
    sed -i "s/GLAD_API_CALL ${proto2[0]} .*/fn $ftype $out_name ($params) @extern(\"$function\");/" $1
done
