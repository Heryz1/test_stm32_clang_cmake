#!/bin/zsh

rm -r build

cmake -B build 
cmake --build build -j
