<?xml version="1.0" encoding="utf-8"?>
<stylesheet
    xmlns="http://www.w3.org/1999/XSL/Transform"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:iana="http://www.iana.org/assignments"
    xmlns:yin="urn:ietf:params:xml:ns:yang:yin:1"
    version="1.0">
  <output method="xml" encoding="utf-8"/>
  <strip-space elements="*"/>
  <include href="../../../xslt/iana-yin.xsl"/>

  <template match="iana:registry[@id='dns-sec-alg-numbers-1']">
    <comment>Typedefs</comment>
    <element name="yin:typedef">
      <attribute name="name">algorithm-name</attribute>
      <element name="yin:type">
	<attribute name="name">enumeration</attribute>
	<apply-templates
	    select="iana:record[iana:description != 'Unassigned' and
                    iana:description != 'Reserved']"
	    mode="dnssec-alg"/>
      </element>
      <element name="yin:description">
	<element name="yin:text">
          This enumeration type defines mnemonic names and
	  corresponding numeric values of DNSSEC algorithms.
	</element>
      </element>
      <element name="yin:reference">
	<element name="yin:text">
	  <html:ul>
	    <html:li>RFC 3755: Legacy Resolver Compatibility for
	    Delegation Signer (DS)</html:li>
	    <html:li>RFC 4034: Resource Records for the DNS Security
	    Extensions</html:li>
	    <html:li>RFC 6014: Cryptographic Algorithm Identifier
	    Allocation for DNSSEC</html:li>
	    <html:li>RFC 6944: Applicability Statement: DNS Security
	    (DNSSEC) DNSKEY Algorithm Implementation Status</html:li>
	  </html:ul>
	</element>
      </element>
    </element>
    <element name="yin:typedef">
      <attribute name="name">algorithm</attribute>
      <element name="yin:type">
	<attribute name="name">union</attribute>
	<element name="yin:type">
	  <attribute name="name">uint8</attribute>
	</element>
	<element name="yin:type">
	  <attribute name="name">algorithm-name</attribute>
	</element>
      </element>
      <element name="yin:description">
	<element name="yin:text">
          This type allows reference to a DNSSEC algorithm using
          either the assigned mnemonic name or numeric value.
	</element>
      </element>
    </element>
  </template>

  <template match="iana:record" mode="dnssec-alg">
    <call-template name="enum">
      <with-param name="description">
	<element name="html:p">
	  <value-of select="concat(iana:description, '.')"/>
	</element>
	<element name="html:p">
	  <text>Usability:</text>
	  <element name="html:ul">
	    <element name="html:li">
	      <text>zone signing: </text>
	      <choose>
		<when test="iana:signing = 'Y'">YES</when>
		<when test="iana:signing = 'N'">NO</when>
	      </choose>
	    </element>
	    <element name="html:li">
	      <text>transaction security: </text>
	      <choose>
		<when test="iana:transsec = 'Y'">YES</when>
		<when test="iana:transsec = 'N'">NO</when>
		<when test="iana:transsec = '*'">not determined</when>
	      </choose>
	    </element>
	  </element>
	</element>
      </with-param>
      <with-param name="refs">
	<call-template name="process-xrefs">
	  <with-param
	      name="xrefs"
	      select="iana:xref[@type = 'rfc' or
		      @type = 'text' and . != 'proposed standard']"/>
	</call-template>
      </with-param>
    </call-template>
  </template>

</stylesheet>
