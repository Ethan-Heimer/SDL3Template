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

- run\
`make`

this will create a `bin` directory inside of `build` where the compiled template project
and a copy of the assets folder from `src/project/assets` will be placed. 

## Configuration
