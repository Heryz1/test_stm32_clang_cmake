set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR ARM)
# Set target as static library to avoid test toolchain fails from cmake
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# Set clang toolchain path and variables
set(CLANG_TOOLCHAIN_DIR /usr/bin)
set(TOOLCHAIN_PREFIX clang)

# set arm-none-eabi path and variables
set(triple arm-none-eabi)
set(ARM_TOOLCHAIN_PATH "/home/fabien/.local/bin/gcc-arm-none-eabi-10.3-2021.10/bin")
set(GCC_TOOLCHAIN "${ARM_TOOLCHAIN_PATH}/arm-none-eabi-gcc")
set(GXX_TOOLCHAIN "${ARM_TOOLCHAIN_PATH}/arm-none-eabi-g++")

execute_process(COMMAND bash -c "${GCC_TOOLCHAIN} $ARCH_FLAGS -print-sysroot 2>&1" OUTPUT_VARIABLE CORTEX_SYSROOT OUTPUT_STRIP_TRAILING_WHITESPACE)
execute_process(COMMAND bash -c "${GCC_TOOLCHAIN} $ARCH_FLAGS -print-multi-directory 2>&1" OUTPUT_VARIABLE CORTEX_MULTI_DIR OUTPUT_STRIP_TRAILING_WHITESPACE)
execute_process(COMMAND bash -c "${GCC_TOOLCHAIN} $ARCH_FLAGS -print-libgcc-file-name 2>&1" OUTPUT_VARIABLE CORTEX_BUILTINS OUTPUT_STRIP_TRAILING_WHITESPACE)
set(ARM_TOOLCHAIN_MULTI_DIR ${CORTEX_SYSROOT}/lib/${CORTEX_MULTI_DIR})

message(STATUS CORTEX_SYSROOT:${CORTEX_SYSROOT})
message(STATUS ARM_TOOLCHAIN_MULTI_DIR:${ARM_TOOLCHAIN_MULTI_DIR})
message(STATUS CORTEX_BUILTINS:${CORTEX_BUILTINS})


# Set compiler as Clang compiler
set(CMAKE_C_COMPILER ${CLANG_TOOLCHAIN_DIR}/${TOOLCHAIN_PREFIX})
set(CMAKE_CXX_COMPILER ${CLANG_TOOLCHAIN_DIR}/${TOOLCHAIN_PREFIX}++)
set(CMAKE_ASM_COMPILER ${CLANG_TOOLCHAIN_DIR}/${TOOLCHAIN_PREFIX})

set(
    ARM_LIBS
    -L${ARM_TOOLCHAIN_MULTI_DIR}
    -L${CORTEX_BUILTINS}
    )

set(CMAKE_SYSROOT ${CORTEX_SYSROOT})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ${CORTEX_SYSROOT})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

