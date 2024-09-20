#! /bin/bash

sed -i 's/const char\s*\* \| char\s*\*\s*const\s*[*]/ZString /g' $1
sed -i '/=/b;s/const //g' $1
sed -i 's/(void)/()/g' $1
sed -i 's/\*const\*/**/g' $1
sed -i 's/}[ ].*;/}/' $1
sed -i 's/VK_DEFINE_.*HANDLE(\(.*\))/distinct \1 = uptr;/' $1 
sed -i 's/\([1-9][0-9]*\)x\([0-9]*\)/\1X\2/g' $1
sed -i 's/uint32_t/uint/g' $1
sed -i 's/uint64_t/ulong/g' $1
sed -i 's/int32_t/int/g' $1
sed -i 's/int64_t/long/g' $1
sed -i 's/size_t/usz/g' $1
sed -i 's/uint8_t/char/g' $1
sed -i 's/int8_t/ichar/g' $1
sed -i 's/uint16_t/ushort/g' $1
sed -i 's/int16_t/short/g' $1
sed -i 's/typedef \(.*\) \(.*\);/def \2 = \1;/' $1
sed -i 's/\(\w*\)\s*\(\w*\)\s*\(\[.*\]\)/\1\3 \2/g' $1
sed -i 's/typedef union/union/g' $1
sed -i 's/typedef \(.*\)(VKAPI_PTR \*\(.*\))(/def \2 = fn \1(/' $1
#sed -i 's/ module/vkmodule/g' $1
sed -i 's/GLAD_API_CALL .*\r//' $1
sed -i 's/HANDLE/void*/g' $1
sed -i 's/LPCWSTR/ushort*/g' $1
sed -i 's/DWORD/uint/g' $1
sed -i 's/HMONITOR/Handle/g' $1
sed -i 's/#include .*//' $1
sed -i 's/}\s*.*;/}/' $1
