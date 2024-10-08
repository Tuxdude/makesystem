ifndef DOCKERFILE_COMMANDS_MK
DOCKERFILE_COMMANDS_MK := 1

include $(MAKESYSTEM_BASE_DIR)/dockerfile/toolchain.mk

BUILD_OPTIONS :=
ENTITLEMENTS :=

ifeq ($(DOCKER_BUILD_PROGRESS_PLAIN),y)
    BUILD_OPTIONS += --progress=plain
endif

ifeq ($(DOCKER_BUILD_ALLOW_INSECURE),y)
    BUILD_OPTIONS += --allow security.insecure
    ENTITLEMENTS += security.insecure
endif

ifneq ($(DOCKER_BUILD_PLATFORM),)
    BUILD_OPTIONS += --platform=$(DOCKER_BUILD_PLATFORM)
endif

ifeq ($(DOCKER_BUILD_NO_CACHE),y)
    BUILD_OPTIONS += --no-cache
endif

# Commands invoked from rules.
DUMP_BUILD_ARGS         := ./.makesystem/dockerfile/scripts/build-args.sh
UPDATE_PACKAGES_INSTALL := ./.makesystem/dockerfile/scripts/update-packages-install.sh
UPDATE_LATEST_UPSTREAM  := ./.makesystem/dockerfile/scripts/update-latest-upstream.sh
PREPARE_RELEASE         := ./.makesystem/dockerfile/scripts/prepare-release.sh
DOCKERBUILD             := $(DOCKER_CMD) buildx build $(BUILD_OPTIONS) $(shell $(DUMP_BUILD_ARGS) docker-flags)
DOCKERTEST              := IMAGE=$(FULL_IMAGE_NAME) ./.makesystem/dockerfile/scripts/test.sh
DOCKERLINT              := $(DOCKER_CMD) run --rm -i hadolint/hadolint:v2.12.0 hadolint - <

DUMP_ENTITLEMENTS       := $(call GithubSetOutputParam,entitlements,$(ENTITLEMENTS))
ifneq ($(ENTITLEMENTS),)
    DUMP_BUILDKITD_FLAGS    := $(call GithubSetOutputParam,buildkitd_flags,$(addprefix --allow-insecure-entitlement=,$(ENTITLEMENTS)))
else
    DUMP_BUILDKITD_FLAGS    := $(call GithubSetOutputParam,buildkitd_flags,)
endif

endif
