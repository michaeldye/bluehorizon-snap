SHELL := /bin/bash
ARCH = $(shell uname -m)

all: geth-$(ARCH) string2hex-$(ARCH) hex2string-$(ARCH)

clean:
	rm -f geth-$(ARCH) string2hex-$(ARCH) hex2string-$(ARCH)

geth-$(ARCH):
# TODO: ensure objectstore doesn't cache copies such that we might miss a newly-uploaded one
	curl -o geth-$(ARCH) http://1DD40.http.tor01.cdn.softlayer.net/geth-bins/geth-$(ARCH)
	chmod +x geth-$(ARCH)

hex2string-$(ARCH):
	gcc -o hex2string-$(ARCH) hex2string.c

install: all
	mkdir -p $(DESTDIR)/bin
	cp geth-$(ARCH) $(DESTDIR)/bin/geth
	cp string2hex-$(ARCH) $(DESTDIR)/bin/string2hex
	cp hex2string-$(ARCH) $(DESTDIR)/bin/hex2string

string2hex-$(ARCH):
	gcc -o string2hex-$(ARCH) string2hex.c


pull: geth-$(ARCH)

.PHONY: clean pull
