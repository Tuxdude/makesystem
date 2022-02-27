ifndef COMMON_VERSION_MK
COMMON_VERSION_MK := 1

CURRENT_VERSION_CMD := cat .bootstrap/VERSION

makesystem_version:
	@$(CURRENT_VERSION_CMD)
.PHONY: makesystem_version

github_dump_makesystem_version:
	@echo "::set-output name=version::$$($(CURRENT_VERSION_CMD))"
.PHONY: github_dump_makesystem_version

endif
