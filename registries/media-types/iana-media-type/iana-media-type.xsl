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

  <template match="iana:registry">
    <element name="yin:typedef">
      <attribute name="name">
	<value-of select="concat('media-type-', iana:title)"/>
      </attribute>
      <element name="yin:type">
	<attribute name="name">enumeration</attribute>
	<apply-templates select="iana:record"/>
	<element name="yin:description">
	  <element name="yin:text">
	    <text>
	      This enumeration type defines subtypes for top-level
	      media type
	    </text>
	    <value-of select="concat($sq, iana:title, $sq, '.')"/>
	  </element>
	</element>
	<element name="yin:reference">
	  <element name="yin:text">
	    <element name="html:ul">
	      <element name="html:li">
		RFC 6838: Media Type Specifications and Registration
		Procedures
	      </element>
	      <element name="html:li">
		RFC 4855: Media Type Registration of RTP Payload
		Formats
	      </element>
	    </element>
	  </element>
	</element>
      </element>
    </element>
  </template>

  <template match="iana:record">
    <call-template name="enum">
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
      <with-param name="value"/>
      <with-param name="description">
	<text>Media type </text>
	<value-of select="concat($sq, iana:file[@type='template'],
			  $sq, '.')"/>
      </with-param>
      <with-param name="deprecated"
		  select="contains(iana:name, 'DEPRECATED')"/>
    </call-template>
  </template>

</stylesheet>
