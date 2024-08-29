#!/usr/bin/env -S make -f

MAKEFLAGS += --warn-undefined-variable
MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --silent

SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
.DEFAULT_GOAL := help

help: Makefile  ## Show help
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' "$(MAKEFILE_LIST)" | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'


# =============================================================================
# Common
# =============================================================================
install:  ## Install deps
	pre-commit install --install-hooks
.PHONY: install

update:  ## Update deps and tools
	pre-commit autoupdate
.PHONY: update


# =============================================================================
# CI
# =============================================================================
ci: format lint scan  ## Run CI tasks
.PHONY: ci

format:  ## Autoformat codes

.PHONY: format

lint:  ## Lint codes

.PHONY: lint

scan:  ## Scan codes
	checkov --quiet --directory .
.PHONY: scan


# =============================================================================
# Handy Scripts
# =============================================================================
clean:  ## Cleanup temporary files
	find . -path '*.log*' -delete
.PHONY: clean
