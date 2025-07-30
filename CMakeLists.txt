cmake_minimum_required(VERSION 3.2)
project(SDL3CMake)

cmake_policy(SET CMP0076 NEW)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")
set(PROJECT_DIR "src/project") 

message("Ensuring SDL is installed")

include(FetchContent)
FetchContent_Declare(
    SDL
    GIT_REPOSITORY "https://github.com/libsdl-org/SDL"
    GIT_TAG "origin/main"
    SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/src/external/SDL3"
)

message("Ensuring SDL Image is installed")

FetchContent_Declare(
    SDLImage
    GIT_REPOSITORY "https://github.com/libsdl-org/SDL_image"
    GIT_TAG "origin/main"
    SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/src/external/SDL3image"
)

FetchContent_MakeAvailable(SDL SDLImage)

add_executable(SDL3CMake) 

target_sources(SDL3CMake PRIVATE 
    ${PROJECT_DIR}/main.cpp
)

add_subdirectory("${CMAKE_SOURCE_DIR}/${PROJECT_DIR}/example")

message("Linking SDL Libs")

target_link_libraries(SDL3CMake PRIVATE SDL3::SDL3)
target_link_libraries(SDL3CMake PRIVATE SDL3_image)

message("Copying Assets")

file(COPY "${CMAKE_SOURCE_DIR}/${PROJECT_DIR}/assets/"
    DESTINATION "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/assets/"
)
