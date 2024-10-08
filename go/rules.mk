ifndef GO_RULES_MK
GO_RULES_MK := 1

include $(MAKESYSTEM_BASE_DIR)/common/shell.mk
include $(MAKESYSTEM_BASE_DIR)/common/utils.mk
include $(MAKESYSTEM_BASE_DIR)/common/version.mk
include $(MAKESYSTEM_BASE_DIR)/common/upgrade.mk
include $(MAKESYSTEM_BASE_DIR)/go/commands.mk
include $(MAKESYSTEM_BASE_DIR)/go/packages.mk
include $(MAKESYSTEM_BASE_DIR)/go/github_workflow_configs.mk

all: fix_imports generate fmt lint vet build test
.PHONY: all

build: tidy
	$(call ExecWithMsg,Building,$(GOBUILD) .)
.PHONY: build

build_stripped: tidy
	$(call ExecWithMsg,Building Stripped,$(GOSTRIPPEDBUILD) .)
.PHONY: build_stripped

clean:
	$(call ExecWithMsg,Cleaning,$(CLEAN_ALL))
.PHONY: clean

coverage_out: tidy
	$(call ExecWithMsg,Testing with Coverage generation,$(GOCOVERAGE_OUT) ./...)
.PHONY: coverage_out

coverage_summary: coverage_out
	$(call ExecWithMsg,Generating Coverage Summary,$(GOCOVERAGE_SUMMARY))
.PHONY: coverage_summary

coverage: coverage_summary
	$(call ExecWithMsg,Generating Coverage HTML,$(GOCOVERAGE_HTML))
.PHONY: coverage

deps_list:
	$(call ExecWithMsg,Listing dependencies,$(GOLIST) -m all)
.PHONY: deps_list

deps_list_latest_version:
	$(call ExecWithMsg,Listing latest dependency versions,$(GOLIST) -u -m all)
.PHONY: deps_list_latest_version

deps_update_tuxdude_latest_only:
	$(call ExecWithMsg,Updating to the latest version of dependencies for \"$(DEP_PKGS_TEXT)\",GONOPROXY=github.com/tuxdude $(GOGET) -t -u $(DEP_PKGS))
.PHONY: deps_update_tuxdude_latest_only

deps_update_tuxdude_latest: deps_update_tuxdude_latest_only tidy
.PHONY: deps_update_tuxdude_latest

deps_update_only:
	$(call ExecWithMsg,Updating to the latest version of all direct dependencies,$(GOGET) -t -u ./...)
.PHONY: deps_update_only

deps_update: deps_update_only tidy
.PHONY: deps_update

fix_imports:
	$(call ExecWithMsg,Fixing imports,$(GOIMPORTS) .)
.PHONY: fix_imports

fmt:
	$(call ExecWithMsg,Fixing formatting,$(GOFMT) .)
.PHONY: fmt

generate:
	$(call ExecWithMsg,Generating,$(GOCLEAN) ./...)
.PHONY: generate

github_dump_build_os_matrix:
	@$(DUMP_GITHUB_BUILD_OS_MATRIX)
.PHONY: github_dump_build_os_matrix

github_dump_codeql_os_matrix:
	@$(DUMP_GITHUB_CODEQL_OS_MATRIX)
.PHONY: github_dump_codeql_os_matrix

github_dump_lint_os_matrix:
	@$(DUMP_GITHUB_LINT_OS_MATRIX)
.PHONY: github_dump_lint_os_matrix

github_dump_tests_os_matrix:
	@$(DUMP_GITHUB_TESTS_OS_MATRIX)
.PHONY: github_dump_tests_os_matrix

goreleaser_check_config:
	$(call ExecWithMsg,GoReleaser Checking config,$(GORELEASERCHECK))
.PHONY: goreleaser_check_config

goreleaser_local_release:
	$(call ExecWithMsg,GoReleaser Building Local Release,$(GORELEASERRELEASE) --snapshot --clean)
.PHONY: goreleaser_local_release

goreleaser_local_release_skip_signing:
	$(call ExecWithMsg,GoReleaser Building Local Release,$(GORELEASERRELEASE) --snapshot --clean --skip sign)
.PHONY: goreleaser_local_release_skip_signing

goreleaser_verify_install_prereqs:
	$(call ExecWithMsg,GoReleaser Pre-Release Installing Prereqs,$(INSTALL_GORELEASER_HOOK_PREREQS))
.PHONY: goreleaser_verify_install_prereqs

goreleaser_verify: goreleaser_verify_install_prereqs generate fmt lint vet build test
.PHONY: goreleaser_verify

lint: tidy
	$(call ExecWithMsg,Linting,$(GOLANGCILINT))
.PHONY: lint

lint_agg: tidy
	$(call ExecWithMsg,Aggressive Linting,$(GOLANGCILINTAGG))
.PHONY: lint_agg

lint_deprecated: tidy
	$(call ExecWithMsg,Linting (Deprecated),$(GOLINT) .)
.PHONY:lint_deprecated

lint_deprecated_agg: tidy
	$(call ExecWithMsg,Aggressive Linting (Deprecated),$(GOLINTAGG) .)
.PHONY:lint_deprecated_agg

test: tidy
	$(call ExecWithMsg,Testing,$(GOTEST) ./...)
.PHONY: test

tidy:
	$(call ExecWithMsg,Tidying module,$(GOMOD) tidy)
.PHONY: tidy

vet: tidy
	$(call ExecWithMsg,Vetting,$(GOVET) ./...)
.PHONY: vet

endif
