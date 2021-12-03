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

  <template match="iana:registry[@id='tls-parameters-2']">
    <element name="yin:typedef">
      <attribute name="name">client-certificate-type-id-name</attribute>
      <element name="yin:type">
	<attribute name="name">enumeration</attribute>
	<apply-templates
	    select="iana:record[iana:description != 'Unassigned' and
                    not(starts-with(iana:description, 'Reserved'))]"/>
      </element>
      <element name="yin:description">
	<element name="yin:text">
          This enumeration type defines mnemonic names and
	  corresponding numeric values of TLS client certificate type
	  identifiers.
	</element>
      </element>
      <element name="yin:reference">
	<element name="yin:text">
	  <html:ul>
	    <html:li>RFC 5246: The Transport Layer Security (TLS)
	    Protocol Version 1.2</html:li>
	    <html:li>RFC 8447: IANA Registry Updates for TLS and
	    DTLS</html:li>
	  </html:ul>
	</element>
      </element>
    </element>
    <element name="yin:typedef">
      <attribute name="name">client-certificate-type-id</attribute>
      <element name="yin:type">
	<attribute name="name">union</attribute>
	<element name="yin:type">
	  <attribute name="name">uint8</attribute>
	</element>
	<element name="yin:type">
	  <attribute name="name">client-certificate-type-id-name</attribute>
	</element>
      </element>
      <element name="yin:description">
	<element name="yin:text">
          This type allows reference to a TLS client certificate type
          identifier using either the assigned mnemonic name or
          numeric value.
	</element>
      </element>
    </element>
  </template>

  <template match="iana:record">
    <call-template name="enum">
      <with-param name="id"
		  select="normalize-space(iana:description)"/>
      <with-param name="description">
	<element name="html:ul">
	  <element name="html:li">
	    <value-of select="concat('Client certificate type ID: ',
			      iana:description, '.')"/>
	  </element>
	  <element name="html:li">
	    <text>DTLS-OK: </text>
	    <choose>
	      <when test="iana:dtls = 'Y'">YES</when>
	      <when test="iana:dtls = 'N'">NO</when>
	    </choose>
	  </element>
	</element>
      </with-param>
    </call-template>
  </template>

</stylesheet>
