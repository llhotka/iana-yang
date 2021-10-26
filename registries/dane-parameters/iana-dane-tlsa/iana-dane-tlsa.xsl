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

  <template match="iana:registry[@id='certificate-usages']">
    <element name="yin:typedef">
      <attribute name="name">certificate-usage-name</attribute>
      <element name="yin:type">
	<attribute name="name">enumeration</attribute>
	<apply-templates
	    select="iana:record[not(iana:description = 'Unassigned' or
		    starts-with(iana:description, 'Reserved'))]"
	    mode="enum"/>
      </element>
      <element name="yin:description">
	<element name="yin:text">
          This enumeration type defines acronyms and corresponding
          numeric values of TLSA certificate usages.
	</element>
      </element>
      <element name="yin:reference">
	<element name="yin:text">
	  <element name="html:ul">
	    <element name="html:li">
              RFC 6698: The DNS-Based Authentication of Named Entities
              (DANE) Transport Layer Security (TLS) Protocol: TLSA
	    </element>
	    <element name="html:li">
              RFC 7218: Adding Acronyms to Simplify Conversations
              about DNS-Based Authentication of Named Entities (DANE)
	    </element>
	  </element>
	</element>
      </element>
    </element>
    <element name="yin:typedef">
      <attribute name="name">certificate-usage</attribute>
      <element name="yin:type">
	<attribute name="name">union</attribute>
	<element name="yin:type">
	  <attribute name="name">uint8</attribute>
	</element>
	<element name="yin:type">
	  <attribute name="name">certificate-usage-name</attribute>
	</element>
      </element>
      <element name="yin:description">
	<element name="yin:text">
          This type allows reference to a TLSA certificate usage using
          either the assigned acronym or numeric value.
	</element>
      </element>
    </element>
  </template>

  <template match="iana:registry[@id='selectors']">
    <element name="yin:typedef">
      <attribute name="name">tlsa-selector-name</attribute>
      <element name="yin:type">
	<attribute name="name">enumeration</attribute>
	<apply-templates
	    select="iana:record[not(iana:description = 'Unassigned' or
		    starts-with(iana:description, 'Reserved'))]"
	    mode="enum"/>
      </element>
      <element name="yin:description">
	<element name="yin:text">
          This enumeration type defines acronyms and corresponding
          numeric values of TLSA selectors.
	</element>
      </element>
      <element name="yin:reference">
	<element name="yin:text">
	  <element name="html:ul">
	    <element name="html:li">
              RFC 6698: The DNS-Based Authentication of Named Entities
              (DANE) Transport Layer Security (TLS) Protocol: TLSA
	    </element>
	    <element name="html:li">
              RFC 7218: Adding Acronyms to Simplify Conversations
              about DNS-Based Authentication of Named Entities (DANE)
	    </element>
	  </element>
	</element>
      </element>
    </element>
    <element name="yin:typedef">
      <attribute name="name">tlsa-selector</attribute>
      <element name="yin:type">
	<attribute name="name">union</attribute>
	<element name="yin:type">
	  <attribute name="name">uint8</attribute>
	</element>
	<element name="yin:type">
	  <attribute name="name">tlsa-selector-name</attribute>
	</element>
      </element>
      <element name="yin:description">
	<element name="yin:text">
          This type allows reference to a TLSA selector using
          either the assigned acronym or numeric value.
	</element>
      </element>
    </element>
  </template>

  <template match="iana:registry[@id='matching-types']">
    <element name="yin:typedef">
      <attribute name="name">tlsa-matching-type-name</attribute>
      <element name="yin:type">
	<attribute name="name">enumeration</attribute>
	<apply-templates
	    select="iana:record[not(iana:description = 'Unassigned' or
		    starts-with(iana:description, 'Reserved'))]"
	    mode="enum"/>
      </element>
      <element name="yin:description">
	<element name="yin:text">
          This enumeration type defines acronyms and corresponding
          numeric values of TLSA matching types.
	</element>
      </element>
      <element name="yin:reference">
	<element name="yin:text">
	  <element name="html:ul">
	    <element name="html:li">
              RFC 6698: The DNS-Based Authentication of Named Entities
              (DANE) Transport Layer Security (TLS) Protocol: TLSA
	    </element>
	    <element name="html:li">
              RFC 7218: Adding Acronyms to Simplify Conversations
              about DNS-Based Authentication of Named Entities (DANE)
	    </element>
	  </element>
	</element>
      </element>
    </element>
    <element name="yin:typedef">
      <attribute name="name">tlsa-matching-type</attribute>
      <element name="yin:type">
	<attribute name="name">union</attribute>
	<element name="yin:type">
	  <attribute name="name">uint8</attribute>
	</element>
	<element name="yin:type">
	  <attribute name="name">tlsa-matching-type-name</attribute>
	</element>
      </element>
      <element name="yin:description">
	<element name="yin:text">
          This type allows reference to a TLSA matching type using
          either the assigned acronym or numeric value.
	</element>
      </element>
    </element>
  </template>

</stylesheet>
