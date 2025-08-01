#! /bin/bash

#retreving enviroment variables
ProjectName=$( ./.bash/getEnvVar.sh PROJECT_NAME ./.var/env.txt )
echo $ProjectName

#clean up bin dir
echo "Cleaning Bin..."
cd build
make clean
cd ..

#create CMakeLists.txt
echo "Creating CMakeLists.txt..."
cat CMakeLists.template| sed "s/project_name/${ProjectName}/g" > CMakeLists.txt

#append directories
echo "Appending directories to CMake file..."
./.bash/appendDirsToCMakeLists.sh $ProjectName

#generate dir CMakeFiles
echo "Generating CMakeLists.txt files in directories..."
./.bash/generateDirCMakeFiles.sh $ProjectName

#start building program here
echo "Building Program..."
cd build
cmake ..

#finishing build
echo "finishing build..."
make

#cleanup 
echo "Cleaning Up..."
cd ..
rm CMakeLists.txt


