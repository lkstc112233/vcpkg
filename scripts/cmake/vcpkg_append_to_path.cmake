## # vcpkg_add_to_path
##
## Add a directory to the PATH environment variable
##
## ## Usage
## ```cmake
## vcpkg_add_to_path([PREPEND] <${PYTHON3_DIR}>)
## ```
##
## ## Parameters
## ### <positional>
## The directory to add
##
## ### PREPEND
## Prepends the directory.
##
## The default is to append.
##
## ## Notes
## A call to `vcpkg_add_to_path()` will usually be preceeded by a call to `vcpkg_find_acquire_program()`:
##
## ```cmake
## vcpkg_find_acquire_python(PYTHON3)
## get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
## vcpkg_add_to_path("${PYTHON3_DIR}")
## ```

function(vcpkg_add_to_path)
    if(NOT "${ARGC}" STREQUAL "1" AND NOT "${ARGC}" STREQUAL "2")
        message(FATAL_ERROR "vcpkg_add_to_path() only accepts 1 or 2 arguments.")
    endif()
    if("${ARGV0}" STREQUAL "PREPEND")
        if(NOT "${ARGC}" STREQUAL "2")
            message(FATAL_ERROR "Expected second argument.")
        endif()
        if(CMAKE_HOST_WIN32)
            set(ENV{PATH} "${ARGV1};$ENV{PATH}")
        else()
            set(ENV{PATH} "${ARGV1}:$ENV{PATH}")
        endif()
    else()
        if(NOT "${ARGC}" STREQUAL "1")
            message(FATAL_ERROR "Unexpected second argument: ${ARGV1}")
        endif()
        if(CMAKE_HOST_WIN32)
            set(ENV{PATH} "$ENV{PATH};${ARGV0}")
        else()
            set(ENV{PATH} "$ENV{PATH}:${ARGV0}")
        endif()
    endif()
endfunction()