PROJECT_NAME := runit-scripts
AUTHOR := Andrej Gelenberg <andrej.gelenberg@udo.edu>
URL := http://people.oh14.de/andrej/runit-scripts
PROJECT_DESC := Some scripts for runit
MAJOR_VER := 11
ARCHS := any
DEPS :=
BINS := nsvlog
INSTALL_DIRS = $(DESTDIR)/$(ETCDIR)
INSTALL = $(ETCDIR)/runit
all:

stickbuild:
	ln -s ../$@ $@
stickbuild/stickbuild.mk: stickbuild
include stickbuild/stickbuild.mk
