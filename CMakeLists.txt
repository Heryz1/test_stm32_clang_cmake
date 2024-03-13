cmake_minimum_required(VERSION 3.15)

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR ARM)
set(CMAKE_GENERATOR ninja)
set(CMAKE_EXPORT_COMPILE_COMMANDS on)

set(CLANG_TOOLCHAIN_DIR /usr/bin)
set(TOOLCHAIN_PREFIX clang)
# set(triple arm-none-eabi)
set(triple arm-none-eabi)
# SET(TOOLCHAIN "/home/fabien/.local/bin/gcc-arm-none-eabi-10.3-2021.10")
set(ARCH_FLAGS "-mthumb -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16")
set(ARM_TOOLCHAIN_PATH "/home/fabien/.local/bin/gcc-arm-none-eabi-10.3-2021.10/bin")
set(GCC_TOOLCHAIN "${ARM_TOOLCHAIN_PATH}/arm-none-eabi-gcc")
set(GXX_TOOLCHAIN "${ARM_TOOLCHAIN_PATH}/arm-none-eabi-g++")

execute_process(COMMAND bash -c "${GCC_TOOLCHAIN} ${ARCH_FLAGS} -print-sysroot 2>&1"
    OUTPUT_VARIABLE CORTEX_SYSROOT)
execute_process(COMMAND bash -c "${GCC_TOOLCHAIN} ${ARCH_FLAGS} -print-multi-directory 2>&1"
    OUTPUT_VARIABLE CORTEX_MULTI_DIR)
execute_process(COMMAND bash -c "${GCC_TOOLCHAIN} ${ARCH_FLAGS} -print-libgcc-file-name 2>&1"
    OUTPUT_VARIABLE CORTEX_BUILTINS)
message(STATUS "cortex sysroot ${CORTEX_SYSROOT}")
message(STATUS "cortex MULTI DIR ${CORTEX_MULTI_DIR}")
message(STATUS "cortex BUILTINS ${CORTEX_BUILTINS}")
message(STATUS "path " ${CORTEX_SYSROOT}/lib/${CORTEX_MULTI_DIR} )

set(CMAKE_C_COMPILER ${CLANG_TOOLCHAIN_DIR}/${TOOLCHAIN_PREFIX})
# set(CMAKE_C_COMPILER_TARGET ${triple})
set(CMAKE_CXX_COMPILER ${CLANG_TOOLCHAIN_DIR}/${TOOLCHAIN_PREFIX}++)
# set(CMAKE_CXX_COMPILER_TARGET ${triple})
set(CMAKE_ASM_COMPILER ${CLANG_TOOLCHAIN_DIR}/${TOOLCHAIN_PREFIX})
# set(CMAKE_ASM_COMPILER_TARGET ${triple})
# set(CMAKE_LINKER ${ARM_GCC_TOOLCHAIN}/arm-none-eabi/bin/ld)

set(CMAKE_C_LINK_EXECUTABLE "${GCC_TOOLCHAIN} <CMAKE_C_LINK_FLAGS> <LINK_FLAGS> <OBJECTS>  -o <TARGET> <LINK_LIBRARIES> -lc") # Ajouter via polymcu
set(CMAKE_CXX_LINK_EXECUTABLE "${GXX_TOOLCHAIN} <CMAKE_CXX_LINK_FLAGS> <LINK_FLAGS> <OBJECTS>  -o <TARGET> <LINK_LIBRARIES> -lc") # Ajouter via polymcu


set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
# set(CMAKE_EXE_LINKER_FLAGS_INIT "-nostdlib")

# SET(CMAKE_C_COMPILER_EXTERNAL_TOOLCHAIN "${GCC_TOOLCHAIN}")
# SET(CMAKE_CXX_COMPILER_EXTERNAL_TOOLCHAIN  "${GXX_TOOLCHAIN}")
# set(LLVM_ENABLE_PIC False)

# set(CMAKE_FIND_ROOT_PATH ${TOOLCHAIN})
set(CMAKE_SYSROOT /home/fabien/.local/bin/gcc-arm-none-eabi-10.3-2021.10/bin/../lib/)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

#########################################################################################################################################################################################################################################################################################

# Setting LLVM Clang flags
set(LLVM_HOST_TRIPLE arm-none-eabi)
set(LLVM_TARGETS_TO_BUILD ARM)


project(test_project C CXX ASM)

add_executable(test_project
    Core/Src/main.c 
    Core/Src/syscalls.c
    Core/Src/stm32f4xx_it.c Core/Src/stm32f4xx_hal_msp.c 
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_tim.c 
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_tim_ex.c 
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_uart.c 
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_rcc.c 
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_rcc_ex.c 
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_flash.c 
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_flash_ex.c 
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_flash_ramfunc.c 
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_gpio.c 
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_dma_ex.c 
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_dma.c 
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_pwr.c 
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_pwr_ex.c 
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_cortex.c 
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal.c 
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_exti.c 
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_pcd.c 
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_pcd_ex.c 
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_ll_usb.c 
    Core/Src/system_stm32f4xx.c  
    startup_stm32f413xx.s
    )

target_include_directories(test_project
    PUBLIC
    Core/Inc 
    Drivers/STM32F4xx_HAL_Driver/Inc 
    Drivers/STM32F4xx_HAL_Driver/Inc/Legacy 
    Drivers/CMSIS/Device/ST/STM32F4xx/Include 
    Drivers/CMSIS/Include
)

set(CMAKE_VERBOSE_MAKEFILE ON)

target_compile_options(test_project
    PUBLIC
--target=arm-none-eabi
-mthumb
-march=armv7em
-mfpu=fpv4-sp-d16
-mfloat-abi=hard
# -mthumb -mcpu=cortex-m4  
        -Wall 
        # -fdata-sections 
        # -ffunction-sections
        # -B=/home/fabien/.local/bin/gcc-arm-none-eabi-10.3-2021.10/arm-none-eabi/bin/ld
        # -fuse-ld=ld
)

target_compile_definitions(test_project
    PUBLIC
    -DUSE_HAL_DRIVER=1
    -DSTM32F413xx=1
)

set(LDSCRIPT "STM32F413ZHTx_FLASH.ld")

target_link_options(test_project
    PUBLIC
    -mcpu=cortex-m4 -mthumb -mfpu=fpv4-sp-d16 -mfloat-abi=hard
        -nostdlib
        -v
    -T${CMAKE_CURRENT_LIST_DIR}/${LDSCRIPT}
    # -Wl,--gc-sections
--specs=nano.specs
    # -L${CORTEX_SYSROOT}/lib/${CORTEX_MULTI_DIR}/
    # -L${CORTEX_BUILTINS}
        -lc -lm -lnosys
)
# /home/fabien/STM32Cube/Repository/STM32Cube_FW_F4_V1.28.0

# set(CMAKE_C_LINK_EXECUTABLE "/home/fabien/.local/bin/gcc-arm-none-eabi-10.3-2021.10/bin/arm-none-eabi-ld")
# set(CMAKE_CXX_LINK_EXECUTABLE "/home/fabien/.local/bin/gcc-arm-none-eabi-10.3-2021.10/bin/arm-none-eabi-ld")
# set(CMAKE_C_LINK_EXECUTABLE "/home/fabien/.local/bin/gcc-arm-none-eabi-10.3-2021.10/bin/arm-none-eabi-gcc <CMAKE_C_LINK_FLAGS> <LINK_FLAGS> <OBJECTS>  -o <TARGET> <LINK_LIBRARIES>")
# set(CMAKE_CXX_LINK_EXECUTABLE "/home/fabien/.local/bin/gcc-arm-none-eabi-10.3-2021.10/bin/arm-none-eabi-g++ <CMAKE_CXX_LINK_FLAGS> <LINK_FLAGS> <OBJECTS>  -o <TARGET> <LINK_LIBRARIES>")
