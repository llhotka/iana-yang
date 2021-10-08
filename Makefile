# Generate YANG modules for all registries

categories := dane-parameters \
	dns-parameters \
	dns-sec-alg-numbers \
	protocol-numbers
subdirs := $(wildcard $(addsuffix /*, $(categories)))

.PHONY: all $(subdirs)

all: $(subdirs)

$(subdirs):
	@$(MAKE) --directory=$@
