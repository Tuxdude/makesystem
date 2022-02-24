ifndef DOCKERFILE_COMMANDS_MK
DOCKERFILE_COMMANDS_MK := 1

include $(MAKESYSTEM_BASE_DIR)/dockerfile/toolchain.mk

BUILD_OPTIONS :=

ifeq ($(ENABLE_DOCKER_BUILDKIT),y)
    BUILD_OPTIONS += DOCKER_BUILDKIT=1
    ifeq ($(DOCKER_BUILDKIT_PROGRESS_PLAIN),y)
        BUILD_OPTIONS += BUILDKIT_PROGRESS=plain
    endif
endif

# Commands invoked from rules.
DUMP_BUILD_ARGS         := ./scripts/build-args.sh
UPDATE_PACKAGES_INSTALL := ./scripts/update-packages-install.sh
DOCKERBUILD             := $(BUILD_OPTIONS) $(DOCKER_CMD) build $(shell $(DUMP_BUILD_ARGS) docker-flags)
DOCKERTEST              := IMAGE=$(FULL_IMAGE_NAME) ./scripts/test.sh
DOCKERLINT              := $(DOCKER_CMD) run --rm -i hadolint/hadolint:v2.8.0 hadolint - <

endif
