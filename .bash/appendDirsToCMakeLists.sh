#! /bin/bash

CMakeSRC=$1

cd $CMakeSRC
shopt -s globstar
for d in ./src/project/*/; do
    if [[ -d "$d" ]] && [[ $d != ./src/project/assets/ ]]; then
        echo "Appending directory: $d" 
        echo "add_subdirectory("$d")" >> CMakeLists.txt
    else 
        echo "Not a valid directory: ${d}"
    fi
done

shopt -u globstar # Optional: disable globstar after use
echo "Appending complete"
exit 0
