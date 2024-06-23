#!/bin/zsh


# Compile using arm-none-eabi
rm -r build_arm
cmake -B build_arm -DARM=1
cmake --build build_arm -j

# Compile using clang
rm -r build_clang
cmake -B build_clang -DCLANG=1
cmake --build build_clang -j
