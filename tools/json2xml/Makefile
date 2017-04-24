#
#
ARCH=$(shell uname -m)
OPTIMIZE=-O2

#uname -m
default:
	@echo "help - this output"
	@echo "all - everything"
	@echo "build - build dynamic"
	@echo "static - build static"

help: default

all: build static strip

build:
	@echo "Starting build  json2xml"
	@g++ $(OPTIMIZE) json2xml.c -o json2xml.$(ARCH)
	@ls -l json2xml.$(ARCH)
	@echo "Ending build"
static:
	@echo "Starting static json2xml"
	@g++ $(OPTIMIZE) -static json2xml.c -o json2xml.$(ARCH).static
	@ls -l json2xml.$(ARCH).static
	@echo "Ending static"

strip:
	@echo "Starting strip json2xml"
	@ls -l *.$(ARCH)*
	@strip *.$(ARCH)*
	@echo "   stripped"
	@ls -l *.$(ARCH) *.$(ARCH).static
	@echo "Ending strip"



