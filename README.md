# An SDL3 Project template

This is just a simple template top get started with SDL3 projects. 

## Installation

This has been tested with makefiles- other build systems may need extra modifications

The following is a bash script that you can use to create a new template project, it'll act as a project manager and allow you to easly configure new projects. 
Copy and paste the following code into a bash script thats in the root directory of where your SDL3 projects will live. 
It can be named whatever make sence to you, but it must have .sh at the end. 

```
#!/bin/bash

removename=""
projectname=$dirname
newname=""

dobuild=0
doclone=0
doremove=0
dorename=0

while getopts "bd:gc:p:ro:n:" opt; do
    case $opt in
        # build flags
        b) dobuild=1;;

        c) projectname=$OPTARG
           doclone=1;;

        d) removename=$OPTARG
           doremove=1;;

        #rename flags
        r) dorename=1 ;;

        o) projectname=$OPTARG ;;

        n) newname=$OPTARG ;;

        \?) # Handle invalid options
            echo "Invalid option: -$OPTARG" >&2
            usage
            ;;
    esac
done

if [[ dorename -eq 1 ]]; then
    echo $projectname
    echo $newname

    cd $projectname
    cat CMakeLists.txt | sed -i s/$projectname/$newname/g CMakeLists.txt
    cd .var
    echo $newname > name.data

    cd ../..
    exit 0
fi

if [[ doremove -eq 1 ]]; then
    read -p "Are you sure you want to remove $removename? (y/n): " ans
    if [[ $ans == "y" ]]; then
        rm -rf $removename
    fi
fi

if [[ doclone -eq 1 ]]; then
    git clone https://github.com/Ethan-Heimer/SDL3Template
    mv SDL3Template $projectname

    cd $projectname
    #change project name for main CMake file
    cat CMakeLists.txt | sed -i s/SDL3CMake/"$projectname"/g CMakeLists.txt
    cd .var
    echo $projectname > name.data
    cd ../..

fi

if [[ dobuild -eq 1  ]]; then
    cd $projectname

    mkdir build

    ./build.sh

    cd ..
    rm -rf .git
    cd ..
fi
exit 0
```
After the script is created run the following command to make it executable:\
`chmod +x YOU_SCRIPT_HERE`

The script should work now! You can run the script with `./YOUR_SCRIPT_NAME`

### Bash Script Flags

The bash script can 
- Create new projects
- Rename projects
- Remove projects

### Create New Project
- `-c`: NEW_PROJECT_NAME: will clone template from this repo and rename it too the new project name
- `-b`: will automatically build the new project after it has been cloned

### Delete Project 
- `-d PROJECT_NAME`: deletes `PROJECT_NAME`

### Renaming a Project
- `-r -o PROJECT_DIR_NAME -n NEW_NAME`: Renames the project in `PROJECT_DIR_NAME` to `NEW_NAME`

### Example

The following command will install and build a new project, as well as initialize git:
```
./YOUR_SCRIPT_NAME -c "New Project" -b
```

## Building a project
There are 2 ways a project can be built with this configuration.

- `./Build.sh`
- The manual way

### Build.sh

`./Build.sh` is a bash script that will automatically configure directories to be linked within the project. run it like a normal bash command. 
the output by default will be built in `./build/bin/`.

Because bash scripts are used to automatically used to generate alot of CMake, the CMakeLists.txt file is not complete, and will not build the project properly.
If you need a fully built `CMakeLists.txt` file, run the following bash scripts:

- `./.bash/appendDirsToCMakeLists.sh`
- `./.bash/generateDirCMakeFiles.sh`

You can find these bash scripts in `./.bash`.

The manual way is outlined below:

### Manual Config
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

