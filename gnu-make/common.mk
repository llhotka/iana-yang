MODULE ?= $(shell basename `pwd`)
CATEGORY ?= $(shell basename $(dir $(shell pwd)))
PYANG_OPTS ?= --path=.:../../../yang-modules --strict
ytxslt = ../../../yin-tools/xslt
xmlurl = $(basename $(IANA_URL)).xml
xmlfile = ../$(CATEGORY).xml

.PHONY: all clean orgrow update validate

all: update $(MODULE).yang

update:
	@lastmod=`curl --silent --head $(xmlurl) \
	    | grep -Po '(?<=^Last-Modified:\s).*$$'`; \
	tstamp=`date -d "$${lastmod}" +%s`; \
	if [[ -f $(xmlfile) && $${tstamp} -le `stat -c '%Y' $(xmlfile)` ]]; \
	then \
	    echo "$(xmlfile) is up to date"; \
	else \
	    echo "Retrieving $(xmlfile) as of $${lastmod}"; \
	    curl --silent $(xmlurl) --output $(xmlfile); \
	fi

$(MODULE).yinx: $(xmlfile)
	xsltproc --stringparam module $(MODULE) \
	    --stringparam prefix $(PREFIX) \
	    --stringparam iana-url "$(dir $(IANA_URL))" \
	    --stringparam xml-url "$(xmlurl)" \
	    --stringparam regid "$(REGISTRY_ID)" \
	    --output $@ $(MODULE).xsl $<

%.yang: %.yinx
	xsltproc $(ytxslt)/canonicalize.xsl $< | \
	    xsltproc --output $@  $(ytxslt)/yin2yang.xsl -

validate: $(MODULE).yang
	pyang $(PYANG_OPTS) $<

orgrow:
	@curl --silent $(basename $(IANA_URL)).xml | \
	    xsltproc --stringparam module $(MODULE) \
	        --stringparam iana-url "$(IANA_URL)" \
	        --stringparam category "$(CATEGORY)" \
	        --stringparam regid "$(REGISTRY_ID)" \
		../../../xslt/org-table-row.xsl -

clean:
	rm -rf *.yinx *.yang
