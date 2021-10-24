# Generate YANG modules for all registries

subdirs != find registries/*/* -type d

.PHONY: all clean $(subdirs)

all: $(subdirs)

$(subdirs):
	$(MAKE) --directory=$@

clean:
	rm -f registries/*/*.xml
	for dir in $(subdirs); do \
	    $(MAKE) clean --directory=$${dir}; \
	done
