INSTALL += $(addprefix $(BINDIR)/,$(foreach i,$(BINS),$(basename $(i)))) 
.PHONY: install
install: $(addprefix $(DESTDIR)/,$(INSTALL))

$(DESTDIR)/$(BINDIR)/%: ./%
	[ -e '$(@D)' ] || mkdir -p '$(@D)' && chmod $(DMOD) '$(@D)'
	cp -if '$<' '$@'
	-strip -s '$@'
	chmod $(EXECMODE) '$@'

$(DESTDIR)/$(LIBDIR)/%: ./%
	[ -e '$(@D)' ] || mkdir -p '$(@D)' && chmod $(DMOD) '$(@D)'
	cp -if '$<' '$@'
	-strip -s '$@'
	chmod $(FMOD) '$@'

$(DESTDIR)/% $(foreach i,$(INSTALL_DIRS), $(DESTDIR)/$(i)/%): ./%
	[ -e '$(@D)' ] || mkdir -p '$(@D)' && chmod $(DMOD) '$(@D)'
	cp -irf '$<' '$@'
	[ -d '$@' ] && chmod $(DMOD) '$@' || chmod $(FMOD) '$@'
