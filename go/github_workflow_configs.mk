ifndef GO_GITHUB_WORKFLOW_CONFIGS_MK
GO_GITHUB_WORKFLOW_CONFIGS_MK := 1

comma := ,
define DumpGithubJsonStrList
$(subst \" \",\"$(comma) \",$(addsuffix \",$(addprefix \",$(1))))
endef

define DumpGithubStrListOutput
echo "::set-output name=$(1)::[$(call DumpGithubJsonStrList,$(2))]"
endef

GITHUB_OS_LIST ?= ubuntu-latest macos-latest windows-latest

GITHUB_BUILD_OS_LIST := ubuntu-latest macos-latest windows-latest
GITHUB_CODEQL_OS_LIST := ubuntu-latest macos-latest
GITHUB_LINT_OS_LIST := ubuntu-latest macos-latest windows-latest
GITHUB_TESTS_OS_LIST := ubuntu-latest macos-latest windows-latest

DUMP_GITHUB_BUILD_OS_MATRIX := $(call DumpGithubStrListOutput,os-matrix,$(filter $(GITHUB_BUILD_OS_LIST),$(GITHUB_OS_LIST)))
DUMP_GITHUB_CODEQL_OS_MATRIX := $(call DumpGithubStrListOutput,os-matrix,$(filter $(GITHUB_CODEQL_OS_LIST),$(GITHUB_OS_LIST)))
DUMP_GITHUB_LINT_OS_MATRIX := $(call DumpGithubStrListOutput,os-matrix,$(filter $(GITHUB_LINT_OS_LIST),$(GITHUB_OS_LIST)))
DUMP_GITHUB_TESTS_OS_MATRIX := $(call DumpGithubStrListOutput,os-matrix,$(filter $(GITHUB_TESTS_OS_LIST),$(GITHUB_OS_LIST)))

endif
