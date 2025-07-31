#! /bin/bash
AppName=$(cat ./.var/name.data)
MatchFiles="\\.(h|cpp|c)$"

shopt -s globstar
for d in ./src/project/*/; do
    if [[ -d "$d" ]] && [[ $d != ./src/project/assets/ ]]; then
        echo "Processing directory: $d" 
        
        cd $d
        if [[ -f ./CMakeLists.txt ]]; then
            echo "File exists, removing old file..."
            rm CMakeLists.txt
        else
            echo "File Does Not Exist"
        fi
 
        echo "Generating File"
        touch CMakeLists.txt

        #this is where the new file is built
        echo "target_sources($AppName PRIVATE" >> CMakeLists.txt 
        
        for file in *; do
            # Check if the item is a regular file (not a directory)
            if [[ -f "$file" ]] && [[ $file =~ $MatchFiles ]]; then
                echo "Found file: $file"

                #append file to Generated CMakeLists
                echo "  $file" >> CMakeLists.txt
            fi
        done       

        echo ")" >> CMakeLists.txt 
    fi
done
shopt -u globstar # Optional: disable globstar after use
