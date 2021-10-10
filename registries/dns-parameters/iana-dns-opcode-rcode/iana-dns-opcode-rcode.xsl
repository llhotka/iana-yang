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

  <template match="iana:registry[@id='dns-parameters-5']">
    <comment>Typedefs</comment>
    <element name="yin:typedef">
      <attribute name="name">opcode-name</attribute>
      <element name="yin:type">
	<attribute name="name">enumeration</attribute>
	<apply-templates
	    select="iana:record[not(iana:description = 'Unassigned' or
                    starts-with(iana:description, 'Reserved'))]"
	    mode="opcode"/>
      </element>
      <element name="yin:description">
	<element name="yin:text">
          This enumeration type defines mnemonic names and
	  corresponding numeric values of DNS opcodes.
	</element>
      </element>
      <element name="yin:reference">
	<element name="yin:text">
          RFC 6895: Domain Name System (DNS) IANA Considerations
	</element>
      </element>
    </element>
    <element name="yin:typedef">
      <attribute name="name">opcode</attribute>
      <element name="yin:type">
	<attribute name="name">union</attribute>
	<element name="yin:type">
	  <attribute name="name">uint8</attribute>
	  <element name="range">
	    <attribute name="value">0..15</attribute>
	  </element>
	</element>
	<element name="yin:type">
	  <attribute name="name">opcode-name</attribute>
	</element>
      </element>
      <element name="yin:description">
	<element name="yin:text">
          This type allows reference to a DNS opcode using either the
          assigned mnemonic name or numeric value.
	</element>
      </element>
    </element>
  </template>

  <template match="iana:record" mode="opcode">
    <call-template name="enum">
      <with-param name="id">
	<choose>
	  <when test="iana:value = 1">IQuery</when>
	  <when test="contains(iana:description,'(')">
	    <value-of select="substring-before(substring-after(
                              iana:description, '('), ')')"/>
	  </when>
	  <otherwise>
	    <value-of select="iana:description"/>
	  </otherwise>
	</choose>
      </with-param>
    </call-template>
  </template>

  <template match="iana:registry[@id='dns-parameters-6']">
    <element name="yin:typedef">
      <attribute name="name">rcode-name</attribute>
      <element name="yin:type">
	<attribute name="name">enumeration</attribute>
	<apply-templates
	    select="iana:record[not(iana:name = 'Unassigned' or
		    starts-with(iana:name, 'Reserved'))]"/>
      </element>
      <element name="yin:description">
	<element name="yin:text">
          This enumeration type defines mnemonic names and
	  corresponding numeric values of DNS response codes.
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
      <attribute name="name">rcode</attribute>
      <element name="yin:type">
	<attribute name="name">union</attribute>
	<element name="yin:type">
	  <attribute name="name">uint16</attribute>
	</element>
	<element name="yin:type">
	  <attribute name="name">rcode-name</attribute>
	</element>
      </element>
      <element name="yin:description">
	<element name="yin:text">
          This type allows reference to a DNS response code using
          either the assigned mnemonic name or numeric value.
	</element>
      </element>
    </element>
  </template>

  <template match="iana:record[iana:value = 9]">
    <if test="preceding-sibling::iana:record[iana:value = 9]">
      <call-template name="enum">
	<with-param name="id">NotAuth</with-param>
	<with-param name="value">9</with-param>
	<with-param name="description">
	  <html:p>This RCODE has two meanings depending on the
	  context:
	  <html:ul>
	    <html:li>Not Authoritative - if it appears as the RCODE in
	    the header of a DNS response without a TSIG RR or with a
	    TSIG RR having a zero error field</html:li>
	    <html:li>Not Authorized - if it appears as the RCODE in the
	    header of a DNS response that includes a TSIG RR with a
	    non-zero error field.</html:li>
	  </html:ul></html:p>
	</with-param>
	<with-param name="refs">
	  <html:ul>
	    <html:li>RFC 2136</html:li>
	    <html:li>RFC 2845</html:li>
	    <html:li>RFC 6895</html:li>
	    <html:li>RFC 8945</html:li>
	  </html:ul>
	</with-param>
      </call-template>
    </if>
  </template>

  <template match="iana:record[iana:value = 16]">
    <if test="preceding-sibling::iana:record[iana:value = 16]">
      <call-template name="enum">
	<with-param name="id">BADVERS-BADSIG</with-param>
	<with-param name="value">16</with-param>
	<with-param name="description">
	  <html:p>This RCODE was accidentally assigned twice:
	  <html:ul>
	    <html:li>in an OPT RR it means 'Bad OPT Version'
	    (BADVERS)</html:li>
	    <html:li>in an TSIG RR it means 'TSIG Signature Failure'
	    (BADSIG).</html:li>
	  </html:ul></html:p>
	</with-param>
	<with-param name="refs">
	  <html:ul>
	    <html:li>RFC 6891</html:li>
	    <html:li>RFC 6895</html:li>
	    <html:li>RFC 8945</html:li>
	  </html:ul>
	</with-param>
      </call-template>
    </if>
  </template>

</stylesheet>
