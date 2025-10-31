PREFIX ?= /usr/local
BINDIR = $(PREFIX)/bin
MANDIR = $(PREFIX)/share/man/man1


SRC=exenv.py

build/exenv: build
	cp $(SRC) build/exenv
	chmod +x build/exenv

build:
	mkdir -p build

clean:
	rm -rf build

install: build/exenv exenv.1
	install -D -t $(BINDIR) build/exenv
	install -D -t $(MANDIR) exenv.1

