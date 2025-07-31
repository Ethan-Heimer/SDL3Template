# An SDL3 Project template

This is just a simple template top get started with SDL3 projects. 

## Installation

This has been tested with makefiles- other build systems may need extra modifications
and steps:

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

