SHELL := /bin/bash
ARCH = $(shell uname -m)

all: geth-$(ARCH) string2hex-$(ARCH) hex2string-$(ARCH)

install: all
	mkdir -p $(DESTDIR)/bin
	cp geth-$(ARCH) $(DESTDIR)/bin/geth
	cp string2hex-$(ARCH) $(DESTDIR)/bin/string2hex
	cp hex2string-$(ARCH) $(DESTDIR)/bin/hex2string

geth-$(ARCH):
# TODO: ensure objectstore doesn't cache copies such that we might miss a newly-uploaded one
	curl -o geth-$(ARCH) http://1DD40.http.tor01.cdn.softlayer.net/geth-bins/geth-1.5.7-$(ARCH)
	chmod +x geth-$(ARCH)

string2hex-$(ARCH):
	gcc -o string2hex-$(ARCH) string2hex.c

hex2string-$(ARCH):
	gcc -o hex2string-$(ARCH) hex2string.c

clean:
	rm -f geth-$(ARCH) string2hex-$(ARCH) hex2string-$(ARCH)

.PHONY: clean
