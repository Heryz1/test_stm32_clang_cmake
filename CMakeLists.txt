cmake_minimum_required(VERSION 3.15)

set(ARCH_FLAGS -mthumb -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16)

if (ARM EQUAL 1)
    set(CMAKE_TOOLCHAIN_FILE arm_toolchain.cmake)
endif()
if (CLANG EQUAL 1)
    set(CMAKE_TOOLCHAIN_FILE clang_toolchain.cmake)
    set(compiler_custom_compile_flag "--target=arm-none-eabi")
    set(compiler_custom_link_flag "--target=arm-none-eabi -nodefaultlibs -nostdlib")
endif()

project(test_project C CXX ASM)
set(CMAKE_EXPORT_COMPILE_COMMANDS on)
set(CMAKE_VERBOSE_MAKEFILE ON)

add_executable(test_project

    Core/Src/main.c
    Core/Src/stm32f4xx_it.c
    Core/Src/stm32f4xx_hal_msp.c
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
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_eth.c
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_tim.c
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_tim_ex.c
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_uart.c
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_pcd.c
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_pcd_ex.c
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_ll_usb.c
    Core/Src/system_stm32f4xx.c 
    startup_stm32f439xx.s
    )

target_include_directories(test_project
    PUBLIC
    Core/Inc 
    Drivers/STM32F4xx_HAL_Driver/Inc 
    Drivers/STM32F4xx_HAL_Driver/Inc/Legacy 
    Drivers/CMSIS/Device/ST/STM32F4xx/Include 
    Drivers/CMSIS/Include
)


target_compile_options(test_project
    PUBLIC
    ${ARCH_FLAGS}
    ${compiler_custom_compile_flag}

    -Wall -fdata-sections -ffunction-sections
    -g #-gdwarf-2
    # -MMD -MP -MF
    -fno-exceptions -fno-rtti 
)

target_compile_definitions(test_project
    PUBLIC
    -DUSE_HAL_DRIVER
    -DSTM32F439xx
)

target_link_options(test_project
    PUBLIC
    ${ARCH_FLAGS}
    -specs=nano.specs
    -T${CMAKE_CURRENT_LIST_DIR}/STM32F439ZITx_FLASH.ld
    -lc -lm -lnosys 
    -Wl,-Map=${CMAKE_CURRENT_BINARY_DIR}/test_project.map,--cref
    -Wl,--gc-sections

    ${compiler_custom_link_flag}
    ${ARM_LIBS}
    # -specs=nosys.specs
    -v

)

