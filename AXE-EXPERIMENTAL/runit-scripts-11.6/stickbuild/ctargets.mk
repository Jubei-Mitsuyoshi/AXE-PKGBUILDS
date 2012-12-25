.ctargets.mk: Makefile $(STICKBUILD_PATH)/ctargets.mk
	( \
	$(foreach k,$(CBINS),$(foreach k,$(CBINS),echo "$(k): $(k).o $(addsuffix .o, $($(k)_OBJ))";)) \
	for i in $(CBINS) $(foreach k,$(CBINS),$($(k)_OBJ) ); do \
		echo "-include $$i.d"; \
		echo "CLEAN += $$i.o $$i.d"; \
	done ) > $@
include .ctargets.mk
CLEAN += .ctargets.mk $(CBINS)

ifeq ($(shell $(CC) --version | grep -q GCC && echo GCC),GCC)
CFLAGS+=-MMD
endif

%: %.o
	$(CC) $(CFLAGS) $(LDFLAGS) $^ $(LIBS) -o $@
