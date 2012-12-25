STICKBUILD_PATH := $(dir $(lastword $(MAKEFILE_LIST)))

-include config.mk

include $(STICKBUILD_PATH)/defaults.mk
include $(STICKBUILD_PATH)/clean.mk
include $(STICKBUILD_PATH)/install.mk
include $(STICKBUILD_PATH)/git.mk
include $(STICKBUILD_PATH)/ctargets.mk
include $(STICKBUILD_PATH)/archpkg.mk
