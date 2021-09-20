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

  <template match="iana:registry[@id='zonemd-schemes']">
    <element name="yin:typedef">
      <attribute name="name">zonemd-scheme-name</attribute>
      <element name="yin:type">
	<attribute name="name">enumeration</attribute>
	<apply-templates
	    select="iana:record[not(iana:description = 'Unassigned' or
		    starts-with(iana:description, 'Reserved'))]"/>
      </element>
      <element name="yin:description">
	<element name="yin:text">
          This enumeration type defines mnemonic names and
	  corresponding numeric values of ZONEMD schemes.
	</element>
      </element>
      <element name="yin:reference">
	<element name="yin:text">
              RFC 8976: Message Digest for DNS Zones
	</element>
      </element>
    </element>
    <element name="yin:typedef">
      <attribute name="name">zonemd-scheme</attribute>
      <element name="yin:type">
	<attribute name="name">union</attribute>
	<element name="yin:type">
	  <attribute name="name">uint8</attribute>
	</element>
	<element name="yin:type">
	  <attribute name="name">zonemd-scheme-name</attribute>
	</element>
      </element>
      <element name="yin:description">
	<element name="yin:text">
          This type allows reference to a ZONEMD scheme using either
          the assigned mnemonic name or numeric value.
	</element>
      </element>
    </element>
  </template>

  <template match="iana:registry[@id='zonemd-hash-algorithms']">
    <element name="yin:typedef">
      <attribute name="name">zonemd-hash-algorithm-name</attribute>
      <element name="yin:type">
	<attribute name="name">enumeration</attribute>
	<apply-templates
	    select="iana:record[not(iana:description = 'Unassigned' or
		    starts-with(iana:description, 'Reserved'))]"/>
      </element>
      <element name="yin:description">
	<element name="yin:text">
          This enumeration type defines mnemonic names and
          corresponding numeric values of ZONEMD hash algorithms.
	</element>
      </element>
      <element name="yin:reference">
	<element name="yin:text">
              RFC 8976: Message Digest for DNS Zones
	</element>
      </element>
    </element>
    <element name="yin:typedef">
      <attribute name="name">zonemd-hash-algorithm</attribute>
      <element name="yin:type">
	<attribute name="name">union</attribute>
	<element name="yin:type">
	  <attribute name="name">uint8</attribute>
	</element>
	<element name="yin:type">
	  <attribute name="name">zonemd-hash-algorithm-name</attribute>
	</element>
      </element>
      <element name="yin:description">
	<element name="yin:text">
          This type allows reference to a ZONEMD hash algorithm using
          either the assigned mnemonic name or numeric value.
	</element>
      </element>
    </element>
  </template>

</stylesheet>
