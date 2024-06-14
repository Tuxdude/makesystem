ifndef COMMON_UPGRADE_MK
COMMON_UPGRADE_MK := 1

LATEST_MAKESYSTEM_VERSION := git -c 'versionsort.suffix=-' ls-remote --exit-code --refs --sort='version:refname' --tags https://github.com/tuxdude/makesystem/ '*.*.*' | cut -d '/' -f 3 | sort --version-sort --reverse | head -1 | sed -E 's@^v(.*)$$@\1@g'

makesystem_upgrade:
	@./.bootstrap/setup-makesystem.sh $$($(LATEST_MAKESYSTEM_VERSION)) "$(MAKESYSTEM_BASE_DIR)" --upgrade
.PHONY: makesystem_upgrade

endif
