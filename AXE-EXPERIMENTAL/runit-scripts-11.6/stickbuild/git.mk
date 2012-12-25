__GIT_MK := $(lastword $(MAKEFILE_LIST))
.PHONY: package release
CLEAN += .minor_ver.mk

include .minor_ver.mk
.minor_ver.mk: $(STICKBUILD_PATH)/get_git_minor_ver $(__GIT_MK)
	$(SHELL) $< $@ $(MAJOR_VER) >$@

ifndef NO_GIT
PKGVER := $(MAJOR_VER).$(MINOR_VER)
PKGNAME := $(ARCHIVE_NAME)-$(PKGVER)
CLEAN += $(ARCHIVE_NAME)-*.tar stickbuild.tar $(ARCHIVE_NAME)-*.$(PKG_EXT)

release: $(PKGNAME).$(PKG_EXT)
package: $(PKGNAME).$(PKG_EXT)
fullpackage: $(PKGNAME)-stickbuild.$(PKG_EXT)
$(PKGNAME).tar: PKGPREFIX=$(PKGNAME)
$(PKGNAME).tar: .minor_ver.mk

include .last_stickbuild.mk
stickbuild.tar: .last_stickbuild.mk
	cd $(STICKBUILD_PATH) && make PKGPREFIX=$(PKGNAME)/stickbuild $(PWD)/$@

.last_stickbuild.mk:
	echo "$@: $(STICKBUILD_PATH)/.git/HEAD \
		$(STICKBUILD_PATH)/.git/logs/$$(awk '{print $$2}' $(STICKBUILD_PATH)/.git/HEAD)" > $@
CLEAN += .last_stickbuild.mk

$(PKGNAME)-stickbuild.tar: $(PKGNAME).tar stickbuild.tar
	cp $< $@
	tar -Af $@ $(filter-out $<, $^)

release: .git/refs/tags/v$(PKGVER)

.git/refs/tags/v$(PKGVER):
	git tag v$(PKGVER)

%.tar: .minor_ver.mk
	git archive --format=tar --prefix="$(PKGPREFIX)/" --output="$@" HEAD

%.tar.bz2: %.tar
	cat $< | bzip2 -c9 >$@
%.tar: %.tar.bz2
	cat $< | bunzip2 -c >$<

%.tar.gz: %.tar
	cat $< | gzip -c9 >$@
%.tar: %.tar.bz2
	cat $< | gunzip -c >$<

%.tar.xz: %.tar
	cat $< | xz -c9 >$@
%.tar: %.tar.xz
	cat $< | unxz -c >$<
endif
