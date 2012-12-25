PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin
LIBDIR ?= $(PREFIX)/lib
ETCDIR ?= $(PREFIX)/etc
FMOD ?= 0644 # File default mode
EXECMODE ?= 0755 # Executable default mode
DMOD ?= 0755 # Directory default mode
INSTALL_DIRS += $(PREFIX) $(ETCDIR)
# supported tar.xz and tar.bz2
PKG_EXT ?= tar.xz

export AUTHOR ?= Unknown
export PROJECT_NAME ?= project
export ARCHIVE_NAME ?= $(PROJECT_NAME)
export PROJECT_DESC 
export MAJOR_VER ?= 0
export MINOR_VER
export URL
export SOURCE_URL ?= $(URL)/
export SOURCE ?= $(PKGNAME)-stickbuild.$(PKG_EXT)
export LICENSE ?= custom
export ARCHS ?= i686 x86_64
export DEPS

# help macros
export VERSION = $(MAJOR_VER).$(MINOR_VER)
