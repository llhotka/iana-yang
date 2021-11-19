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

  <template name="prolog">
    <comment>Identities</comment>
  </template>

  <template match="iana:registry[@id='structured-syntax-suffix']">
    <call-template name="identity">
      <with-param name="id">structured-syntax-suffix</with-param>
      <with-param name="description">
	<element name="html:p">
          Base identity from which all identities representing
          structured syntax suffixes for media types are derived.
	</element>
      </with-param>
      <with-param name="refs">
	<element name="html:p">
          RFC 6836: Media Type Specifications and Registration
	  Procedures
	</element>
      </with-param>
    </call-template>
    <apply-templates select="iana:record"/>
  </template>

  <template match="iana:record">
    <call-template name="identity">
      <with-param name="id"
		  select="substring(normalize-space(iana:suffix), 2)"/>
      <with-param name="base">structured-syntax-suffix</with-param>
      <with-param name="description">
	<element name="html:p">
	  <value-of select="iana:name"/>
	</element>
      </with-param>
    </call-template>
  </template>

</stylesheet>
