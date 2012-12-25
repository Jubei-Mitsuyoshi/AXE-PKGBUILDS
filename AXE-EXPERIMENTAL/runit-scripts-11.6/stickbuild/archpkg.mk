PKGBUILD: $(STICKBUILD_PATH)/pkgbuild_tmpl $(STICKBUILD_PATH)/archpkg.mk Makefile $(SOURCE)
	$(SHELL) $< $@

.PHONY: archpkg archsrc
archpkg: .archpkg
.archpkg: PKGBUILD
	makepkg -f -c && touch .archpkg

archsrc: .archsrc
.archsrc: PKGBUILD
	makepkg --source -f -c && touch .archpkg

CLEAN += .archpkg .archsrc PKGBUILD
