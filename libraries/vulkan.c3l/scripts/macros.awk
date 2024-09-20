#!/usr/bin/awk -f

/module vulkan::vk @if\(internal::vk_version\(\) == (.*)\);/ {
    match($0, /module vulkan::vk @if\(internal::vk_version\(\) == (.*)\);/, arr)
    version = arr[1]
    print $0
    next
}

/#if defined/{
    in_def = 1
    match($0, /#if defined\((.*)\)/, arr)
    def = arr[1]
    print "module vulkan::vk @if($defined(" arr[1] ")); //#if defined(" arr[1]")"
    next
}

/#endif|#else/ && in_def{
    in_def = 0
    print "module vulkan::vk @if(internal::vk_version() == " version "); //#endif/#else"
    next
}

{
    print $0
}
