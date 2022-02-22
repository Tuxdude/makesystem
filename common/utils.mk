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

endif
