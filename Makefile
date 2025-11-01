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

README.md: exenv.1
	pandoc -f man -t markdown -o README.md exenv.1

install: build/exenv exenv.1
	install -D -m 755 -t $(BINDIR) build/exenv
	install -D -m 644 -t $(MANDIR) exenv.1

