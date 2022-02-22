ifndef SILENT_MK
SILENT_MK := 1

# Enable a verbose output from the makesystem.
VERBOSE ?= no

# Silence echoing the commands being invoked unless
# overridden to be verbose.
ifneq ($(VERBOSE),yes)
    silent := @
else
    silent :=
endif

endif
