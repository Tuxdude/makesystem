ifndef COMMON_UPGRADE_MK
COMMON_UPGRADE_MK := 1

LATEST_MAKESYSTEM_VERSION := curl --silent https://api.github.com/repos/tuxdude/makesystem/tags?per_page=1 | jq --raw-output '.[0].name' | sed -E 's;^v(.*)$$;\1;'

makesystem_upgrade:
	@./.bootstrap/setup-makesystem.sh $$($(LATEST_MAKESYSTEM_VERSION)) "$(MAKESYSTEM_BASE_DIR)" --upgrade
.PHONY: makesystem_upgrade

endif
