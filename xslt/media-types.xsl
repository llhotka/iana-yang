<?xml version="1.0" encoding="utf-8"?>
<stylesheet
    xmlns="http://www.w3.org/1999/XSL/Transform"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:iana="http://www.iana.org/assignments"
    xmlns:yin="urn:ietf:params:xml:ns:yang:yin:1"
    version="1.0">
  <import href="iana-yinx.xsl"/>
  <output method="xml" encoding="utf-8"/>
  <strip-space elements="*"/>

  <template name="prolog">
    <element name="yin:import">
      <attribute name="module">iana-media-type</attribute>
      <element name="prefix">
	<attribute name="value">ianamt</attribute>
      </element>
    </element>
    <comment>Identities</comment>
  </template>
  
  <template match="iana:registry">
    <element name="yin:identity">
      <attribute name="name">
	<value-of select="iana:title"/>
      </attribute>
      <element name="yin:base">
	<attribute name="name">ianamt:media-type</attribute>
      </element>
      <element name="yin:description">
	<element name="yin:text">
	  <text>This identity represents the '</text>
	  <value-of select="iana:title"/>
	  <text>' top-level media type.</text>
	</element>
      </element>
    </element>
    <apply-templates select="iana:record"/>
  </template>

  <template match="iana:record">
    <call-template name="identity">
      <with-param name="id">
	<choose>
	  <when test="contains(iana:name, ' ')">
	    <value-of select="substring-before(iana:name, ' ')"/>
	  </when>
	  <otherwise>
	    <value-of select="iana:name"/>
	  </otherwise>
	</choose>
      </with-param>
      <with-param name="base" select="../iana:title"/>
      <with-param name="description">
	<text>This identity represents the '</text>
	<value-of select="iana:file"/>
	<text>' media type.</text>
      </with-param>
      <with-param name="deprecated"
		  select="contains(iana:name, 'DEPRECATED')"/>
    </call-template>
  </template>

</stylesheet>
