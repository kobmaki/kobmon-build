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
	@echo "strip - strip binaries"

help: default

all: build static strip

build:
	@echo "Starting build  json2xml"
	@g++ $(OPTIMIZE) json2xml.c -o json2xml.$(ARCH).dynamic
	@ls -l json2xml.$(ARCH).dynamic
	@echo "Ending build"
static:
	@echo "Starting static json2xml"
	@g++ $(OPTIMIZE) -static json2xml.c -o json2xml.$(ARCH).static
	@ls -l json2xml.$(ARCH).static
	@echo "Ending static"

strip:
	@echo "Starting strip json2xml"
	@ls -l *.$(ARCH).*
	@strip *.$(ARCH).*
	@echo "   stripped"
	@ls -l *.$(ARCH).dynamic *.$(ARCH).static
	@echo "Ending strip"



