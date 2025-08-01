#! /bin/bash

VarName=$1
ENVPath=$2

GREP=$(grep "$VarName" $ENVPath)

if [[ $GREP == "" ]]; then
    echo "Var Not Found"
    exit 1
fi

Var=$( echo $GREP | grep -o -P '"([a-zA-Z]*)"' )
echo $Var

exit 0
