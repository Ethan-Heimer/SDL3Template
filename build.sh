#! /bin/bash

#create temp files for CMakeLists

echo "Creating Temp Files"
cp CMakeLists.txt .CMakeLists.temp

#append directories

echo "Appending directories to CMake file..."
./.bash/appendDirsToCMakeLists.sh

#generate dir CMakeFiles

echo "Generating CMakeLists.txt files in directories..."
./.bash/generateDirCMakeFiles.sh App

#start building program here
echo "Building Program..."
cd build
cmake ..

#cleanup 
echo "Cleaning Up..."
cd ..
rm CMakeLists.txt
mv .CMakeLists.temp CMakeLists.txt

#finishing build
echo "finishing build..."
cd build
make


