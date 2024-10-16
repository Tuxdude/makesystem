ifndef GO_VERSION_INFO_MK
GO_VERSION_INFO_MK := 1

IN_GIT_REPO_WORKING_TREE := $(shell git rev-parse --is-inside-work-tree 2>/dev/null || true)
ifeq ($(IN_GIT_REPO_WORKING_TREE),true)
    REPO_COMMIT_SHA := $(shell git rev-parse --short --verify HEAD)
    REPO_RECENT_VERSION := $(shell git describe --abbrev=0 2>/dev/null || echo "v0.1.0")
    REPO_RECENT_VERSION_SHA := $(shell git rev-parse --short --verify $$(git rev-list -n 1 $(REPO_RECENT_VERSION) 2>/dev/null || true) 2>/dev/null || true)
    REPO_NEXT_VERSION :=$(shell echo -n "$(REPO_RECENT_VERSION)" | awk -F. -v OFS=. '{$$NF += 1 ; print}')
    DIRTY_CHANGES_SUFFIX := $(shell if [ -n "$$(git status --porcelain)" ]; then echo -n "+dirty"; fi)
    ifneq ($(DIRTY_CHANGES_SUFFIX),)
        # With local dirty changes.
        #   - version = tag_inc+dev
        #   - commit = sha+dirty
        #   - date = current-timestamp
        GO_PKG_VERSION := $(REPO_NEXT_VERSION)+dev
        GO_PKG_COMMIT  := $(REPO_COMMIT_SHA)$(DIRTY_CHANGES_SUFFIX)
        GO_PKG_DATE    := $(shell TZ=America/Los_Angeles date +"%Y-%m-%dT%H:%M:%S%:z")
    else
        GO_PKG_DATE    := $(shell TZ=America/Los_Angeles git show --no-patch --no-notes --format=%cd --date=iso-strict-local $(REPO_COMMIT_SHA))
        GO_PKG_COMMIT  := $(REPO_COMMIT_SHA)
        ifneq ($(REPO_COMMIT_SHA),$(REPO_RECENT_VERSION_SHA))
        # Not on an annotated tag, and without local dirty changes.
        #   - version = tag_inc+dev
        #   - commit = sha
        #   - date = commit-timestamp
        GO_PKG_VERSION := $(REPO_NEXT_VERSION)+dev
        else
        # On a pristine annotated tag without local dirty changes.
        #   - version = tag
        #   - commit = sha
        #   - date = commit-timestamp
        GO_PKG_VERSION := $(REPO_RECENT_VERSION)
        endif
    endif
else
    GO_PKG_VERSION := unknown
    GO_PKG_COMMIT  := unknown
    GO_PKG_DATE    := $(shell TZ=America/Los_Angeles date +"%Y-%m-%dT%H:%M:%S%:z")
endif

GO_BUILD_FLAGS += -ldflags "-X main.pkgVersion=$(GO_PKG_VERSION) -X main.pkgCommit=$(GO_PKG_COMMIT) -X main.pkgTimestamp=$(GO_PKG_DATE)"

endif
