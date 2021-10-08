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

  <template match="iana:registry[@id='protocol-numbers-1']">
    <comment>Typedefs</comment>
    <element name="yin:typedef">
      <attribute name="name">protocol-name</attribute>
      <element name="yin:type">
	<attribute name="name">enumeration</attribute>
	<!-- IPTM has to be excluded because its number collides with
	     TTP. -->
	<apply-templates
	    select="iana:record[iana:description != 'Unassigned' and
                    iana:name != 'Reserved' and iana:name != 'IPTM']"
	    mode="internet-protocol"/>
      </element>
      <element name="yin:description">
	<element name="yin:text">
          This enumeration type defines mnemonic names and
	  corresponding numeric values of Internet protocols.
	</element>
      </element>
      <element name="yin:reference">
	<element name="yin:text">
	  <html:ul>
	    <html:li>RFC 5237: IANA Allocation Guidelines for the
	    Protocol Field</html:li>
	    <html:li>RFC 7045: Transmission and Processing of IPv6
	    Extension Headers</html:li>
	  </html:ul>
	</element>
      </element>
    </element>
    <element name="yin:typedef">
      <attribute name="name">protocol</attribute>
      <element name="yin:type">
	<attribute name="name">union</attribute>
	<element name="yin:type">
	  <attribute name="name">uint8</attribute>
	</element>
	<element name="yin:type">
	  <attribute name="name">protocol-name</attribute>
	</element>
      </element>
      <element name="yin:description">
	<element name="yin:text">
          This type allows reference to an Internet protocol using
          either the assigned mnemonic name or numeric value.
	</element>
      </element>
    </element>
  </template>

  <template match="iana:record" mode="internet-protocol">
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
      <with-param name="description">
	<element name="html:p">
	  <value-of select="concat(iana:description, '.')"/>
	</element>
	<if test="iana:ipv6 = 'Y'">
	  <element name="html:p">
	    This entry is also an IPv6 Extension Header Type.
	  </element>
	</if>
      </with-param>
      <with-param name="refs">
	<call-template name="process-xrefs">
	  <with-param
	      name="xrefs"
	      select="iana:xref[@type = 'rfc' or
		      @type = 'text' or @type = 'person']"/>
	</call-template>
      </with-param>
      <with-param name="deprecated"
		  select="contains(iana:name, '(deprecated)')"/>
    </call-template>
  </template>

</stylesheet>
