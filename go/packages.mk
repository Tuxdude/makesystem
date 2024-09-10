ifndef GO_PACKAGES_MK
GO_PACKAGES_MK := 1

include $(MAKESYSTEM_BASE_DIR)/common/shell.mk
include $(MAKESYSTEM_BASE_DIR)/go/commands.mk

# List of packages in the current directory.
PKGS ?= $(shell $(GOLIST) ./... | grep -v /vendor/)

DEP_PKGS := $(shell $(GOLIST) -f '{{ join .Imports "\n" }}' | grep 'github.com/tuxdude' || true)
ifeq ($(DEP_PKGS),)
    DEP_PKGS_TEXT := None
else
    DEP_PKGS_TEXT := $(DEP_PKGS)
    DEP_PKGS := $(addsuffix @master,$(DEP_PKGS))
endif

endif
