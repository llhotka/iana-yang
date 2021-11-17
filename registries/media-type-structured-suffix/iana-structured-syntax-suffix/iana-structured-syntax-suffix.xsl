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

  <!-- Replace REGISTRY-ID with the the value specified in the 'id'
       attribute of the <registry> element. -->
  <template match="iana:registry[@id='structured-syntax-suffix']">
    <element name="yin:typedef">
      <attribute name="name">structured-syntax-suffix</attribute>
      <element name="yin:type">
	<attribute name="name">enumeration</attribute>
	<apply-templates select="iana:record"/>
      </element>
      <element name="yin:description">
	<element name="yin:text">
          This enumeration type defines structured syntax suffixes for
	  media types.
	</element>
      </element>
      <element name="yin:reference">
	<element name="yin:text">
              RFC 6836: Media Type Specifications and Registration
	      Procedures
	</element>
      </element>
    </element>
  </template>

  <template match="iana:record">
    <call-template name="enum">
      <with-param name="id" select="normalize-space(iana:suffix)"/>
      <with-param name="value"/>
      <with-param name="description">
	<element name="html:p">
	  <value-of select="iana:name"/>
	</element>
      </with-param>
    </call-template>
  </template>

</stylesheet>
