cmake_minimum_required(VERSION 3.15)

set(CMAKE_TOOLCHAIN_FILE arm_toolchain.cmake)

project(test_project C CXX ASM)

add_executable(test_project
    Core/Src/main.c 
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


target_compile_options(test_project
    PUBLIC
        -mcpu=cortex-m4
        -mfpu=fpv4-sp-d16
        -mfloat-abi=hard
        -mthumb

        -Wall 
        -fdata-sections 
        -ffunction-sections

        -g 
        -gdwarf-2
)

target_compile_definitions(test_project
    PUBLIC
    -DUSE_HAL_DRIVER
    -DSTM32F413xx
    #-MMD -MP -MF"$(@:%.o=%.d)"
)

set(LDSCRIPT "STM32F413ZHTx_FLASH.ld")

target_link_options(test_project
    PUBLIC
    -mcpu=cortex-m4 -mthumb -mfpu=fpv4-sp-d16 -mfloat-abi=hard
    -specs=nano.specs
    -T${CMAKE_CURRENT_LIST_DIR}/${LDSCRIPT}
    -lc -lm -lnosys
    #-Map=${CMAKE_BINARY_DIR)/test_project.map,--cref 
    -Wl,--gc-sections
)

