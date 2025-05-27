ESBUILD ?= npx esbuild
ESFLAGS += --bundle --minify

# debug handling
DEBUG ?= 0
ifneq ($(DEBUG),0)
ESFLAGS += --define:NDEBUG=0
else
ESFLAGS += --define:NDEBUG=1
endif

.PHONY: all clean
all: out/script.js out/index.html
clean:; rm -rf out/

# generating of HTML
out/index.html: web/index.html
	@mkdir -p $(@D)
	cp -f $< $@

# compiles / links source code
out/script.js: web/src/*.ts
	@mkdir -p $(@D)
	npx esbuild web/src/main.ts $(ESFLAGS) --outfile=$@
