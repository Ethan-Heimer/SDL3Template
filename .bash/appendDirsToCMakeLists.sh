#! /bin/bash

CMakeFile="./application/CMakeLists.txt"

shopt -s globstar
for d in ./src/project/*/; do
    if [[ -d "$d" ]] && [[ $d != ./src/project/assets/ ]]; then
        echo "Processing directory: $d" 
        echo "add_subdirectory("'${CMAKE_SOURCE_DIR}'/$d")" >> $CMakeFile
    fi
done

shopt -u globstar # Optional: disable globstar after use
