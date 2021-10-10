# Generate YANG modules for all registries

subdirs := $(wildcard registries/*/*)

.PHONY: all $(subdirs)

all: $(subdirs)

$(subdirs):
	@$(MAKE) --directory=$@
