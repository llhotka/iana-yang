# Generate YANG modules for all registries

categories := dns-parameters dns-sec-alg-numbers
subdirs := $(wildcard $(addsuffix /*, $(categories)))

.PHONY: all $(subdirs)

all: $(subdirs)

$(subdirs):
	@$(MAKE) --directory=$@
