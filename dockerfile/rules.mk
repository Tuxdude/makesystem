ifndef DOCKERFILE_RULES_MK
DOCKERFILE_RULES_MK := 1

include $(MAKESYSTEM_BASE_DIR)/common/shell.mk
include $(MAKESYSTEM_BASE_DIR)/common/utils.mk
include $(MAKESYSTEM_BASE_DIR)/common/upgrade.mk
include $(MAKESYSTEM_BASE_DIR)/common/version.mk
include $(MAKESYSTEM_BASE_DIR)/dockerfile/image.mk
include $(MAKESYSTEM_BASE_DIR)/dockerfile/commands.mk

all: build test lint
.PHONY: all

clean:
	$(call ExecWithMsg,Cleaning,)
.PHONY: clean

build:
	$(call ExecWithMsg,Building,$(DOCKERBUILD) --tag "$(FULL_IMAGE_NAME)" .)
.PHONY: build

github_env_vars:
	@echo "DOCKERHUB_REPO_NAME=$(DOCKERHUB_USER_NAME)/$(IMAGE_NAME)"
	@echo "GHCR_REPO_NAME=ghcr.io/$(GHCR_USER_NAME)/$(IMAGE_NAME)"
.PHONY: github_env_vars

github_dump_docker_build_args:
	@$(DUMP_BUILD_ARGS)
.PHONY: github_dump_docker_build_args

github_dump_docker_entitlements:
	@$(DUMP_ENTITLEMENTS)
.PHONY: github_dump_docker_entitlements

github_dump_docker_buildkitd_flags:
	@$(DUMP_BUILDKITD_FLAGS)
.PHONY: github_dump_docker_buildkitd_flags

lint:
	$(call ExecWithMsg,Linting,$(DOCKERLINT) Dockerfile)
.PHONY: lint

test:
	$(call ExecWithMsg,Testing,$(DOCKERTEST))
.PHONY: test

update_packages:
	$(call ExecWithMsg,Updating Packages to Install List,$(UPDATE_PACKAGES_INSTALL))
.PHONY: update_packages

update_latest_upstream:
	$(call ExecWithMsg,Updating Latest Upstream Version,$(UPDATE_LATEST_UPSTREAM))
.PHONY: update_latest_upstream

prepare_release:
	$(call ExecWithMsg,Preparing Release,$(PREPARE_RELEASE))
.PHONY: prepare_release

endif
