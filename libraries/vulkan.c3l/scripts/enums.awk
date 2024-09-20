#!/usr/bin/awk -f

/typedef enum/ {
    in_enum = 1
    enum_name = $3
    print "distinct " enum_name " = int;" 
    next
}


/{/ && in_enum {
    next
}

/}.*;/ && in_enum {
    in_enum = 0
    next
}

/([a-zA-Z0-9_]+)( *= *[^,]+),?/ && in_enum {
    match($0, /([a-zA-Z0-9_]+)( *= *[^,]+),?/, arr)
    print "const " enum_name " " arr[1] arr[2] ";"
    next
}

{
    print $0
}

