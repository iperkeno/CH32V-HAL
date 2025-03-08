# 
WCH_BUILD_DIR := wch-sdk

WCH_SDK_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

SDK_C_SOURCES += \
$(WCH_SDK_DIR)Peripheral/${FAMILY}/src/ch32v30x_flash.c \
$(WCH_SDK_DIR)Peripheral/${FAMILY}/src/ch32v30x_gpio.c \
$(WCH_SDK_DIR)Peripheral/${FAMILY}/src/ch32v30x_pwr.c \
$(WCH_SDK_DIR)Peripheral/${FAMILY}/src/ch32v30x_wwdg.c \
$(WCH_SDK_DIR)Peripheral/${FAMILY}/src/ch32v30x_crc.c \
$(WCH_SDK_DIR)Peripheral/${FAMILY}/src/ch32v30x_spi.c \
$(WCH_SDK_DIR)Peripheral/${FAMILY}/src/ch32v30x_dma.c \
$(WCH_SDK_DIR)Peripheral/${FAMILY}/src/ch32v30x_exti.c \
$(WCH_SDK_DIR)Peripheral/${FAMILY}/src/ch32v30x_dvp.c \
$(WCH_SDK_DIR)Peripheral/${FAMILY}/src/ch32v30x_eth.c \
$(WCH_SDK_DIR)Peripheral/${FAMILY}/src/ch32v30x_adc.c \
$(WCH_SDK_DIR)Peripheral/${FAMILY}/src/ch32v30x_i2c.c \
$(WCH_SDK_DIR)Peripheral/${FAMILY}/src/ch32v30x_rng.c \
$(WCH_SDK_DIR)Peripheral/${FAMILY}/src/ch32v30x_tim.c \
$(WCH_SDK_DIR)Peripheral/${FAMILY}/src/ch32v30x_usart.c \
$(WCH_SDK_DIR)Peripheral/${FAMILY}/src/ch32v30x_sdio.c \
$(WCH_SDK_DIR)Peripheral/${FAMILY}/src/ch32v30x_rtc.c \
$(WCH_SDK_DIR)Peripheral/${FAMILY}/src/ch32v30x_iwdg.c \
$(WCH_SDK_DIR)Peripheral/${FAMILY}/src/ch32v30x_dac.c \
$(WCH_SDK_DIR)Peripheral/${FAMILY}/src/ch32v30x_bkp.c \
$(WCH_SDK_DIR)Peripheral/${FAMILY}/src/ch32v30x_fsmc.c \
$(WCH_SDK_DIR)Peripheral/${FAMILY}/src/ch32v30x_opa.c \
$(WCH_SDK_DIR)Peripheral/${FAMILY}/src/ch32v30x_dbgmcu.c \
$(WCH_SDK_DIR)Peripheral/${FAMILY}/src/ch32v30x_can.c \
$(WCH_SDK_DIR)Peripheral/${FAMILY}/src/ch32v30x_rcc.c \
$(WCH_SDK_DIR)Peripheral/${FAMILY}/src/ch32v30x_misc.c \
$(WCH_SDK_DIR)Debug/${FAMILY}/debug.c \
$(WCH_SDK_DIR)Core/${FAMILY}/core_riscv.c  \
${WCH_SDK_DIR}System/${FAMILY}/system_ch32v30x.c 

# ASM sources
# Startup
ASM_SOURCES := ${WCH_SDK_DIR}Startup/startup_ch32v30x_D8C.S

# Linker script
LDSCRIPT = /opt/wch-sdk/ldscripts/Link_CH32V30x.ld

C_INCLUDES +=  \
-I${WCH_SDK_DIR}Core/${FAMILY} \
-I${WCH_SDK_DIR}Peripheral/${FAMILY}/inc \
-I${WCH_SDK_DIR}Debug/${FAMILY} \
-I${WCH_SDK_DIR}Core/${FAMILY} \
-I${WCH_SDK_DIR}System/${FAMILY} 


OBJECTS += $(addprefix $(BUILD_DIR)/wch-sdk/,$(notdir $(SDK_C_SOURCES:.c=.o)))
vpath %.c $(sort $(dir $(SDK_C_SOURCES)))

# # list of ASM program objects
# OBJECTS += $(addprefix $(BUILD_DIR)/wch-sdk/,$(notdir $(SDK_ASM_SOURCES:.S=.o)))
# vpath %.S $(sort $(dir $(SDK_ASM_SOURCES)))

$(BUILD_DIR)/wch-sdk/%.o: %.c | $(BUILD_DIR)
	@echo -e 'Building target: $@ \t\t\t from:\t $< '
	@$(CC) -c $(CFLAGS) -Wa,-a,-ad,-alms=$(BUILD_DIR)/wch-sdk/$(notdir $(<:.c=.lst)) $< -o $@

# $(BUILD_DIR)/wch-sdk/%.o: %.S | $(BUILD_DIR)
# 	@echo -e 'Building target: $@ 	\t\t\t from:\t $< '
# 	$(AS) -c $(CFLAGS) $< -o $@


