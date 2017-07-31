# json2xml ([back](00-A-documentation.md))
The tool is a helper to convert json to xml. It is very simple.

## Compilation
Go into the [json2xml directory](../tools/json2xml). There is Makefile that helps you to compile.

```
make
help - this output
all - everything
build - build dynamic
static - build static
strip - strip the compiled files
```

With `make build` you get a file inside this directory. The compiled filename has the suffix of the architekture (`uname -m`) you are running the build process. E.g. you compile the program on an raspberrypi 3 on a fedora system with 64BIT you binary is named json2xml.aarch64.dynamic and the static version json2xml.aarch64.static.

When you want to compile a static version then type `make static`. Your static file name is `json2xml.*.static`

If you want to have a dynamic and a static version which are striped, then simple `make all`

## Usage
The smallest json file is `{}`



