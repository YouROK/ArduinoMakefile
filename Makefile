
PROGRAM_NAME 	:= $(notdir $(shell pwd))
ARDUINOMK 		:= nano3


ARDUINODIR	:= arduino
include env/$(ARDUINOMK).mk

CC      	:= avr-gcc
CXX     	:= avr-g++
OC 			:= avr-objcopy

DEFINE  	:= -DF_CPU=$(F_CPU) -DARDUINO=161
CFLAGS  	:= -Os -mmcu=$(MCU) -ffunction-sections -fdata-sections
LDFLAGS 	:= -Wl,--gc-sections
OCFLAGS 	:= -j .text -j .data -O ihex

DISTDIR   	:= dist
BUILDDIR  	:= build
SOURCEDIR 	:= src

SOURCES 	:= $(shell find $(SOURCEDIR) -name '*.c*')
SOURCES 	+= $(shell find $(ARDUINODIR)/arduino_src -name '*.c*')
OBJECTS 	:= $(addprefix $(BUILDDIR)/,$(SOURCES:%.cpp=%.o))
OBJECTS 	:= $(OBJECTS:%.c=%.o)

BINARY 		:= $(PROGRAM_NAME)
HEADERSDIR 	:= $(addprefix -I,$(HEADERSDIR)) $(addprefix -I, $(dir $(SOURCES))) 

COM 		:= /dev/ttyUSB0
BAUD		:= 57600


all: info $(BINARY)

info:
	@echo ""
	@echo "-------------- Info --------------"
	@echo "  Compile: $(PROGRAM_NAME)"
	@echo "  MMCU: $(MCU)"
	@echo "  F_CPU: $(F_CPU)"
	@echo "  Hex file: $(DISTDIR)/$(BINARY).hex"
	@echo "  Output dir: `pwd`/$(DISTDIR)"
	@echo ""
#	@echo "  Source files:\n"$(SOURCES)\n
	@echo "-------------- Building --------------"

mk_dir:
	@mkdir -p $(dir $(OBJECTS))
	@mkdir -p $(DISTDIR)

$(BINARY): mk_dir $(OBJECTS)
	@echo [CC] Compile $@
	@$(CC) $(CFLAGS) $(LDFLAGS) $(OBJECTS) -o $(BUILDDIR)/$(BINARY).elf
	@echo [OC] Make hex $(DISTDIR)/$(BINARY).hex
	@$(OC) $(OCFLAGS) $(BUILDDIR)/$(BINARY).elf $(DISTDIR)/$(BINARY).hex
	@stat -c'%n %s' $(DISTDIR)/$(BINARY).hex

$(BUILDDIR)/%.o: %.c
	@echo [CC] Compile $<
	@$(CC) $(DEFINE) $(CFLAGS) $(LDFLAGS) $(HEADERSDIR) -I$(dir $<) -c $< -o $@

$(BUILDDIR)/%.o: %.cpp
	@echo [CX] Compile $<
	@$(CXX) $(DEFINE) $(CFLAGS) $(LDFLAGS) $(HEADERSDIR) -I$(dir $<) -c $< -o $@

clean:
	@rm -rf $(BUILDDIR)

clean_all: clean
	@rm -rf $(DISTDIR)

upload: info $(BINARY)
	@$(ARDUINODIR)/avrdude/avrdude_bin -q -V -p$(MCU) -C$(ARDUINODIR)/avrdude/avrdude.conf -D -carduino -b$(BAUD) -P$(COM) -Uflash:w:$(DISTDIR)/$(BINARY).hex:i

