ifndef GO_TOOLCHAIN_MK
GO_TOOLCHAIN_MK := 1

# go and related binaries.
GO_CMD                            := go
GO_IMPORTS_CMD                    := goimports
GO_FMT_CMD                        := gofmt
GO_LINT_CMD                       := golint
GO_CI_LINT_CMD                    := golangci-lint
GO_RELEASER                       := goreleaser

endif
