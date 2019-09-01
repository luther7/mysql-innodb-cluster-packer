
PACKER_ARGS ?=

.PHONY: main
main: build.centos

.PHONY: build
build:
	packer build -force $(PACKER_ARGS) packer.json | tee output

.PHONY: build.centos
build.centos: PACKER_ARGS=-only=centos-7
build.centos: build

.PHONY: build.ubuntu
build.ubuntu: PACKER_ARGS=-only=ubuntu-18
build.ubuntu: build

.PHONY: clean
clean:
	rm -rf output*

.PHONY: check
check:
	find scripts -type f | xargs shellcheck

.PHONY: up
up: up.centos

.PHONY: up.centos
up.centos:
	VAGRANT_BOX=centos-7 vagrant up

.PHONY: up.ubuntu
up.ubuntu:
	VAGRANT_BOX=ubuntu-18 vagrant up

.PHONY: down
down:
	vagrant destroy --force
