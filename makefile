
PREFIX ?= /usr

all:
	@echo Run \'make install\' to install gdrivemenu.

install:
	@echo 'Making directories...'
	@mkdir -vp $(PREFIX)/bin
	@mkdir -vp $(PREFIX)/lib/gdrivemenu/modules
	@mkdir -vp $(PREFIX)/share/doc/gdrivemenu
	
	@echo 'Installing script...'
	@cp -vp gdrivemenu.sh $(PREFIX)/bin
	@chmod 755 $(PREFIX)/bin/gdrivemenu.sh
	
	@echo 'Installing Readme...'
	@cp -vp README.md  $(PREFIX)/share/doc/gdrivemenu
	
	@echo 'Installing Desktop entry...'
	@cp -vp	desktop/gdrivemenu.desktop $(PREFIX)/share/applications
	@cp -vp	desktop/gdrivemenuicon.png $(PREFIX)/share/pixmaps

	@echo 'DONE!'


