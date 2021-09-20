MODULE ?= $(shell basename `pwd`)
xslpars = --stringparam module $(MODULE) --stringparam prefix $(PREFIX) \
	  --stringparam iana-url "$(IANA_URL)" \
	  --stringparam regid "$(REGISTRY_ID)"
ytxslt = ../../yin-tools/xslt

.PHONY: all clean refresh validate

all: $(MODULE).yang

$(MODULE).yinx:
	@curl --silent $(IANA_URL) | \
	    xsltproc $(xslpars) --output $@ $(MODULE).xsl -

%.yang: %.yinx
	@xsltproc $(ytxslt)/canonicalize.xsl $< | \
	    xsltproc --output $@  $(ytxslt)/yin2yang.xsl -

validate: $(MODULE).yang
	@pyang --strict $<

clean:
	@rm -rf *.yinx *.yang
