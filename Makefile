IMAGE_TAG = bpftrace-builder:${LLVM_VERSION}

LLVM_5 := 5.0
LLVM_6 := 6.0
LLVM_7 := 7
LLVM_8 := 8

DOCKER_RUN_FLAGS := -it --rm --privileged
DOCKER_VOLUMES := -v $(BPFTRACE_PATH):/bpftrace -v /sys/kernel/debug:/sys/kernel/debug:rw -v /lib/modules:/lib/modules:ro -v /usr/src:/usr/src:ro
DOCKER_RUN := docker run $(DOCKER_RUN_FLAGS) $(DOCKER_VOLUMES)

.PHONY: all
all: build-llvm-5 build-llvm-6 build-llvm-7 build-llvm-8

.PHONY: build
build: Dockerfile
ifndef LLVM_VERSION
	$(error LLVM_VERSION is not set)
endif
	@echo "Building image ${IMAGE_TAG}"
	@docker build --build-arg llvm_version=${LLVM_VERSION} --tag bpftrace-builder:${LLVM_VERSION} .
	@echo "Image built"

.PHONY: build-llvm-%
build-llvm-%:
	@$(MAKE) -s build LLVM_VERSION=$(LLVM_$*)

.PHONY: run
run:
ifndef LLVM_VERSION
	$(error LLVM_VERSION is not set)
endif
	@sudo $(DOCKER_RUN) $(IMAGE_TAG) bash

.PHONY: run-%
run-%:
ifndef BPFTRACE_PATH
	$(error BPFTRACE_PATH is not set)
endif
	@$(MAKE) -s run LLVM_VERSION=$(LLVM_$*)
