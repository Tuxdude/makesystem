ifndef GO_COMMANDS_MK
GO_COMMANDS_MK := 1

include $(MAKESYSTEM_BASE_DIR)/go/toolchain.mk
include $(MAKESYSTEM_BASE_DIR)/go/gen_files.mk
include $(MAKESYSTEM_BASE_DIR)/go/version_info.mk

# Commands invoked from rules.
GOBUILD                           := $(GO_CMD) build $(GO_BUILD_FLAGS)
GOSTRIPPEDBUILD                   := CGO_ENABLED=0 GOOS=linux $(GO_CMD) build -a -ldflags "-s -w" $(GO_BUILD_FLAGS)
GOCLEAN                           := $(GO_CMD) clean
GOGENERATE                        := $(GO_CMD) generate
GOGET                             := $(GO_CMD) get
GOLIST                            := $(GO_CMD) list
GOMOD                             := $(GO_CMD) mod
GOTEST                            := $(GO_CMD) test -v
GOCOVERAGE_OUT                    := $(GO_CMD) test -v -race -coverprofile coverage.out -covermode atomic
GOCOVERAGE_HTML                   := $(GO_CMD) tool cover -html coverage.out -o coverage.html
GOVET                             := $(GO_CMD) vet
GOIMPORTS                         := $(GO_IMPORTS_CMD) -w
GOFMT                             := $(GO_FMT_CMD) -s -w
GOLINT                            := $(GO_LINT_CMD) -set_exit_status -min_confidence 0.200001
GOLINTAGG                         := $(GO_LINT_CMD) -set_exit_status -min_confidence 0
GOLANGCILINT                      := $(GO_CI_LINT_CMD) run
GOLANGCILINTAGG                   := $(GO_CI_LINT_CMD) run --enable-all
GORELEASERRELEASE                 := $(GO_RELEASER) release
GORELEASERCHECK                   := $(GO_RELEASER) check
INSTALL_GORELEASER_HOOK_PREREQS   := $(GO_CMD) install \
    github.com/golangci/golangci-lint/cmd/golangci-lint@latest
CLEAN_ALL                         := $(GOCLEAN) ./... && rm -rf $(GEN_FILES)

# Alternative for running golangci-lint, using docker instead:
# docker run \
#   --rm \
#   --tty \
#   --volume $$(pwd):/go-src:ro \
#   --workdir /go-src \
#   golangci/golangci-lint:v1.44.0 \
#   golangci-lint run

endif
