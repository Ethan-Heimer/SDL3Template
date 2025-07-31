# An SDL3 Project template

This is just a simple template top get started with SDL3 projects. 

## Installation

This has been tested with makefiles- other build systems may need extra modifications

### Bash Script
the following is a bash script that you can download. 
Copy and paste the following code into a bash script thats in the root directory of where your SDL3 projects will live. 
It can be named whatever make sence to you, but it must have .sh at the end. 

```
#!/bin/bash

dirname="New Project"
removename=""
projectname=$dirname

dobuild=0
dogitinit=0
doclone=0
doremove=0

while getopts "br:gn:p:" opt; do
    case $opt in
        b) dobuild=1;;

        g) dogitinit=1 ;;

        n) newname=$OPTARG
           doclone=1;;

        r) removename=$OPTARG
           doremove=1;;

        p) projectname=$OPTARG;;

        \?) # Handle invalid options
            echo "Invalid option: -$OPTARG" >&2
            usage
            ;;
    esac
done

if [[ doremove -eq 1 ]]; then
    read -p "Are you sure you want to remove $removename? (y/n): " ans
    if [[ $ans == "y" ]]; then
        rm -rf $removename
    fi
fi

if [[ doclone -eq 1 ]]; then
    git clone https://github.com/Ethan-Heimer/SDL3Template
    mv SDL3Template $newname

    cd $newname
    #change project name for main CMake file
    cat CMakeLists.txt | sed -i s/SDL3CMake/"$projectname"/g CMakeLists.txt
    cd ..
fi

if [[ dobuild -eq 1  ]]; then
    cd $newname

    mkdir build
    cd build

    cmake ..
    make

    cd ..
    rm -rf .git
    cd ..
fi

if [[ dogitinit -eq 1 ]]; then
    cd $newname
    git init
    cd ..
fi

exit 0
```
After the script is created run the following command to make it executable:
`chmod +x YOU_SCRIPT_HERE`\

The script should work now!

### Manual Way

If Bash isn't your style, you can do it this way:

- clone and cd into repo\
`git clone https://github.com/Ethan-Heimer/SDL3Template && cd SDL3Template`

- make a build directory\
`mkdir build && cd build`

- run\
`cmake ..`

this will automatically install SDL3 and SDL3_Image into `SDL3Template/src/external/`
if they are not found. After `cmake ..` is finished executing:

- run `make`

this will create a `bin` directory inside of `build` where the compiled template project
and a copy of the assets folder from `src/project/assets` will be placed. 

## Configuration
### Changing the project name 

The Default name for the template project is `SDL3CMake`. This name can be changed by 
changing the every occurance of `SDL3CMake` to the desired name. Every CMakeLists.txt file will need this named changed to work properly

(I have not found a better way to do this yet)

### Adding Extra External Libs From Github

To add any libs from git hub (other SDL3 libs especially), copy this block into the 
root `CMakeLists.txt` file:

```
FetchContent_Declare(
    {LIB NAME HERE}
    GIT_REPOSITORY "{LIB GITHUB URL HERE}"
    GIT_TAG "origin/main"
    SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/src/external/{LIB DIR NAME HERE}"
)
```

and append the lib name to `FetchContent_MakeAvailable`.\
finaly the lib should have a cmake target name associated with it. use the target name too 
add the lib to the compiled application with\
`target_link_libraries({PROJECT NAME} PRIVATE {LIB TARGET NAME})`

### Adding a new directory in scr/project/

Unfortunatly, adding a new directory that the project will have to link is not done without some extra configuration.
Every directory that the project must link to must have its own 'CMakeLists.txt' file as well. These files will contain somthing like the followign:
```
target_sources({PROJECT NAME} PRIVATE 
    {SOURCE FILE}.h
    {SOURCE FILE}.cpp
    ...
)
```

Every source file in the directory must be added into the `target_sources` block.

In the root `CMakeLists.txt` file add this line:

```
add_subdirectory("${CMAKE_SOURCE_DIR}/${PROJECT_DIR}/{DIRECTORY PATH}")
```

where `{DIRECTIRY PATH}` should be chnaged to the path of the directory your looking to link

### The .gitignore

By default the git ingore will ingore the `build` directory and the `src/external` directory.

