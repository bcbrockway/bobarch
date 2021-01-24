ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
PACKAGES := $(shell cat $(ROOT_DIR)/aur-pkg-builder/packages)
TRUSTED_KEYS := $(shell cat $(ROOT_DIR)/aur-pkg-builder/trusted-keys)
DOCKER_AUR_BUILDER := "bobarch:aur-pkg-builder"

build/packages : build/package-builder
	docker run -it --rm \
		-v $(ROOT_DIR)/aur-pkg-builder/cache:/pkg \
		$(DOCKER_AUR_BUILDER) -k "$(TRUSTED_KEYS)" -p "$(PACKAGES)"

build/package-builder : 
	pushd $(ROOT_DIR)/aur-pkg-builder; \
	docker build -t $(DOCKER_AUR_BUILDER) --target aur-pkg-builder .; \
	popd

.PHONY: build/packages build/package-builder