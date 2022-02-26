ifndef DOCKERFILE_RULES_MK
DOCKERFILE_RULES_MK := 1

include $(MAKESYSTEM_BASE_DIR)/common/shell.mk
include $(MAKESYSTEM_BASE_DIR)/common/utils.mk
include $(MAKESYSTEM_BASE_DIR)/common/upgrade.mk
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
	@echo "DOCKERHUB_REPO_NAME=$(USER_NAME)/$(IMAGE_NAME)"
.PHONY: github_env_vars

github_dump_docker_build_args:
	@$(DUMP_BUILD_ARGS)
.PHONY: github_dump_docker_build_args

lint:
	$(call ExecWithMsg,Linting,$(DOCKERLINT) Dockerfile)
.PHONY: lint

test:
	$(call ExecWithMsg,Testing,$(DOCKERTEST))
.PHONY: test

update_packages:
	$(call ExecWithMsg,Updating Packages to Install List,$(UPDATE_PACKAGES_INSTALL))
.PHONY: update_packages

endif
