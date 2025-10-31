PREFIX ?= /usr/local
BINDIR = $(PREFIX)/bin
MANDIR = $(PREFIX)/share/man/man1


SRC=exenv.py

build/exenv: build
	cp $(SRC) build/exenv
	chmod +x build/exenv

build:
	mkdir build

clean:
	rm -rf build

install: build/exenv exenv.1
	install -t $(MANDIR) exenv.1
	install -t $(BINDIR) build/exenv

