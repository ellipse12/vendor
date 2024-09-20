#!/usr/bin/awk -f

/#ifdef/ {
    skip = 1
    next
}

/#endif/ {
    skip = 0
    next

}

/#else/ {
    skip = 0
}
!skip { print }
