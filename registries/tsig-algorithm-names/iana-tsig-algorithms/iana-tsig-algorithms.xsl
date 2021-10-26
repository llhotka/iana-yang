<?xml version="1.0" encoding="utf-8"?>
<stylesheet
    xmlns="http://www.w3.org/1999/XSL/Transform"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:iana="http://www.iana.org/assignments"
    xmlns:yin="urn:ietf:params:xml:ns:yang:yin:1"
    version="1.0">
  <import href="../../../xslt/iana-yinx.xsl"/>
  <output method="xml" encoding="utf-8"/>
  <strip-space elements="*"/>

  <template match="iana:registry[@id='tsig-algorithm-names-1']">
    <element name="yin:typedef">
      <attribute name="name">tsig-algorithm-name</attribute>
      <element name="yin:type">
	<attribute name="name">enumeration</attribute>
	<apply-templates select="iana:record"/>
      </element>
      <element name="yin:description">
	<element name="yin:text">
          This enumeration type defines mnemonic TSIG algorithm names.
	</element>
      </element>
      <element name="yin:reference">
	<element name="yin:text">
              RFC 8945: Secret Key Transaction Authentication for DNS
              (TSIG)
	</element>
      </element>
    </element>
  </template>

  <template match="iana:record">
    <call-template name="enum">
      <with-param name="value"/>
      <with-param
	  name="description"
	  select="concat('Algorithm ', iana:name)"/>
    </call-template>
  </template>

</stylesheet>
