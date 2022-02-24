ifndef COMMON_SILENT_MK
COMMON_SILENT_MK := 1

# Enable a verbose output from the makesystem.
VERBOSE ?= n

# Silence echoing the commands being invoked unless
# overridden to be verbose.
ifneq ($(VERBOSE),y)
    silent := @
else
    silent :=
endif

endif
