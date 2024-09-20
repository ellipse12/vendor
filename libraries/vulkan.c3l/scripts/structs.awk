#!/bin/awk -f

/typedef struct/ { 
    in_struct=1; bitfield=0; 
    struct_name=$3;               # Capture the struct name
    struct_def = ""
    bitfield_bits = 0
    
    next 
}
/}/ && in_struct { 
    if (bitfield){
        type = "char" 
        if(bitfield_bits > 8 && bitfield_bits <= 16){
            type = "ushort"    
        }else if(bitfield_bits > 16 && bitfield_bits <= 32){
            type = "uint"
        }else if(bitfield_bits > 32 && bitfield_bits <= 64){
            type = "ulong"
        }else if(bitfield_bits > 64){
            type = "uint128"
        }
        print "bitstruct " struct_name " : " type "\n{\n" struct_def "}"
    }else {
        print "struct " struct_name "\n{\n" struct_def "}"
    }
    next 
}
in_struct && /:/ { 
    bitfield = 1 
    match($0, /(.+):(.+);/, arr)
    bitfield_bits_old = bitfield_bits
    bitfield_bits = bitfield_bits + arr[2]
    struct_def = struct_def arr[1] " : " bitfield_bits_old ".." bitfield_bits ";\n"
    next
}           
in_struct && !bitfield {
    struct_def = struct_def $0 "\n"             # Continue building the struct body
}

!in_struct { print $0 }                            # Print non-struct lines immediately

