ifndef DOCKERFILE_IMAGE_MK
DOCKERFILE_IMAGE_MK := 1

ifeq ($(IMAGE_NAME),)
    $(error IMAGE_NAME must be set in the Makefile)
endif

# Build image information.
USER_NAME         ?= tuxdude
IMAGE_TAG         ?= local-latest
FULL_IMAGE_NAME   := $(USER_NAME)/$(IMAGE_NAME):$(IMAGE_TAG)

endif
