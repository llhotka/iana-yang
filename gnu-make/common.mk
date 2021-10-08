MODULE ?= $(shell basename `pwd`)
ytxslt = ../../yin-tools/xslt

.PHONY: all clean orgrow refresh validate $(MODULE).yinx

all: $(MODULE).yang

$(MODULE).yinx:
	@curl --silent $(basename $(IANA_URL)).xml | \
	    xsltproc --stringparam module $(MODULE) \
	        --stringparam prefix $(PREFIX) \
	        --stringparam iana-url "$(dir $(IANA_URL))" \
	        --stringparam regid "$(REGISTRY_ID)" \
	        --output $@ $(MODULE).xsl -

%.yang: %.yinx
	@xsltproc $(ytxslt)/canonicalize.xsl $< | \
	    xsltproc --output $@  $(ytxslt)/yin2yang.xsl -

validate: $(MODULE).yang
	@pyang --strict $<

orgrow:
	@curl --silent $(basename $(IANA_URL)).xml | \
	    xsltproc --stringparam module $(MODULE) \
	        --stringparam iana-url "$(IANA_URL)" \
	        --stringparam category "$(shell basename $(dir $(shell pwd)))" \
	        --stringparam regid "$(REGISTRY_ID)" \
		../../xslt/org-table-row.xsl -

clean:
	@rm -rf *.yinx *.yang
