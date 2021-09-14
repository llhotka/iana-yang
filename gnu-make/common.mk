xslpars = --stringparam module $(MODULE) --stringparam prefix $(PREFIX) \
	  --stringparam iana-url "$(IANA_URL)" --stringparam regid "$(REGISTRY_ID)"
ytxslt = ../yin-tools/xslt

.PHONY: all clean refresh

all: $(MODULE).yang

$(MODULE).yinx:
	@curl --silent $(IANA_URL) | \
	    xsltproc $(xslpars) --output $@ $(MODULE).xsl -

%.yang: %.yinx
	@xsltproc $(ytxslt)/canonicalize.xsl $< | \
	    xsltproc --output $@  $(ytxslt)/yin2yang.xsl -

clean:
	@rm -rf *.yinx *.yang
