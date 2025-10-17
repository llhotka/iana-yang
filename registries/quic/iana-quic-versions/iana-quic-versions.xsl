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

  <template match="iana:registry[@id='quic-versions']">
    <element name="yin:typedef">
      <attribute name="name">quic-version</attribute>
      <element name="yin:type">
        <attribute name="name">enumeration</attribute>
        <apply-templates select="iana:record"/>
      </element>
      <element name="yin:description">
        <element name="yin:text">
          This enumeration type defines QUIC protocol versions.
        </element>
      </element>
      <element name="yin:reference">
        <element name="yin:text">
          RFC 9000: QUIC: A UDP-Based Multiplexed and Secure Transport
        </element>
      </element>
    </element>
    <element name="yin:typedef">
      <attribute name="name">version</attribute>
      <element name="yin:type">
        <attribute name="name">quic-version</attribute>
      </element>
      <element name="yin:description">
        <element name="yin:text">
          This type allows reference to a QUIC version using the
          assigned value.
        </element>
      </element>
    </element>
  </template>

  <template match="iana:record">
    <param name="refs">
      <call-template name="process-xrefs"/>
    </param>

    <element name="yin:enum">
      <attribute name="name">
        <value-of select="iana:value"/>
      </attribute>
      <element name="yin:description">
        <element name="yin:text">
          <value-of select="concat('(',iana:status,') ')"/>
          <value-of select="iana:notes"/>
        </element>
      </element>
      <if test="$refs != ''">
        <element name="yin:reference">
          <element name="yin:text">
            <copy-of select="$refs"/>
          </element>
        </element>
      </if>
    </element>
  </template>

</stylesheet>
