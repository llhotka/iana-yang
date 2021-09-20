<?xml version="1.0" encoding="utf-8"?>
<stylesheet
    xmlns="http://www.w3.org/1999/XSL/Transform"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:iana="http://www.iana.org/assignments"
    xmlns:yin="urn:ietf:params:xml:ns:yang:yin:1"
    version="1.0">
  <output method="xml" encoding="utf-8"/>
  <strip-space elements="*"/>
  <include href="../../xslt/iana-yin.xsl"/>

  <template match="iana:registry[@id='dns-parameters-2']">
    <comment>Typedefs</comment>
    <element name="yin:typedef">
      <attribute name="name">dns-class-name</attribute>
      <element name="yin:type">
	<attribute name="name">enumeration</attribute>
	<apply-templates
	    select="iana:record[not(iana:description = 'Unassigned' or
                    starts-with(iana:description, 'Reserved'))]"
	    mode="dns-class"/>
      </element>
      <element name="yin:description">
	<element name="yin:text">
          This enumeration type defines mnemonic names and
	  corresponding numeric values of DNS classes.
	</element>
      </element>
      <element name="yin:reference">
	<element name="yin:text">
          RFC 6895: Domain Name System (DNS) IANA Considerations
	</element>
      </element>
    </element>
    <element name="yin:typedef">
      <attribute name="name">dns-class</attribute>
      <element name="yin:type">
	<attribute name="name">union</attribute>
	<element name="yin:type">
	  <attribute name="name">uint16</attribute>
	</element>
	<element name="yin:type">
	  <attribute name="name">dns-class-name</attribute>
	</element>
      </element>
      <element name="yin:description">
	<element name="yin:text">
          This type allows reference to a DNS class using either the
	  assigned mnemonic name or numeric value.
	</element>
      </element>
    </element>
  </template>

  <template match="iana:record" mode="dns-class">
    <call-template name="enum">
      <with-param name="id">
	<choose>
	  <when test="contains(iana:description,'(')">
	    <value-of select="substring-before(substring-after(
                              iana:description, '('), ')')"/>
	  </when>
	  <otherwise>
	    <value-of select="substring-after(iana:description, ' ')"/>
	  </otherwise>
	</choose>
      </with-param>
    </call-template>
  </template>

  <template match="iana:registry[@id='dns-parameters-4']">
    <element name="yin:typedef">
      <attribute name="name">rr-type-name</attribute>
      <element name="yin:type">
	<attribute name="name">enumeration</attribute>
	<apply-templates
	    select="iana:record[not(iana:type = 'Unassigned' or
		    iana:type = 'Private use' or iana:type =
		    'Reserved')]"
	    mode="type"/>
      </element>
      <element name="yin:description">
	<element name="yin:text">
          This enumeration type defines mnemonic names and
	  corresponding numeric values of DNS resource record types.
	</element>
      </element>
      <element name="yin:reference">
	<element name="yin:text">
	  <element name="html:ul">
	    <element name="html:li">
              RFC 6895: Domain Name System (DNS) IANA Considerations
	    </element>
	    <element name="html:li">
              RFC 1035: Domain names - implementation and specification
	    </element>
	  </element>
	</element>
      </element>
    </element>
    <element name="yin:typedef">
      <attribute name="name">rr-type</attribute>
      <element name="yin:type">
	<attribute name="name">union</attribute>
	<element name="yin:type">
	  <attribute name="name">uint16</attribute>
	</element>
	<element name="yin:type">
	  <attribute name="name">rr-type-name</attribute>
	</element>
      </element>
      <element name="yin:description">
	<element name="yin:text">
          This type allows reference to a DNS resource record type
          using either the assigned mnemonic name or numeric value.
	</element>
      </element>
    </element>
  </template>

</stylesheet>
