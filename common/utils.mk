ifndef COMMON_UTILS_MK
COMMON_UTILS_MK := 1

include $(MAKESYSTEM_BASE_DIR)/common/colors.mk
include $(MAKESYSTEM_BASE_DIR)/common/silent.mk

# Common utilities.
ECHO                              := echo -e

# Helpful functions
# ExecWithMsg
# $(1) - Message
# $(2) - Command to be executed
define ExecWithMsg
    $(silent)$(ECHO) "\n===  $(COLOR_BLUE)$(1)$(COLOR_RESET)  ==="
    $(silent)$(2)
endef

# GithubSetOutputParam
# $(1) - Parameter Name
# $(2) - Parameter Value
define GithubSetOutputParam
if [ -n "$$GITHUB_OUTPUT" ]; then echo "$(1)=$(2)" >> $$GITHUB_OUTPUT; else echo "::set-output name=$(1)::$(2)"; fi
endef

endif
