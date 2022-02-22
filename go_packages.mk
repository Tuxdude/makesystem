ifndef GO_PACKAGES_MK
GO_PACKAGES_MK := 1

include $(MAKESYSTEM_BASE_DIR)/shell.mk
include $(MAKESYSTEM_BASE_DIR)/go_commands.mk

# List of packages in the current directory.
PKGS ?= $(shell $(GOLIST) ./... | grep -v /vendor/)

DEP_PKGS := $(shell $(GOLIST) -f '{{ join .Imports "\n" }}' | grep tuxdude || true)
ifeq ($(DEP_PKGS),)
    DEP_PKGS_TEXT := None
else
    DEP_PKGS_TEXT := $(DEP_PKGS)
    DEP_PKGS := $(addsuffix @master,$(DEP_PKGS))
endif

endif
