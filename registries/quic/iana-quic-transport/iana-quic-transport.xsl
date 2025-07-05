<?xml version="1.0" encoding="utf-8"?>
<stylesheet
    xmlns="http://www.w3.org/1999/XSL/Transform"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:iana="http://www.iana.org/assignments"
    xmlns:str="http://exslt.org/strings"
    xmlns:yin="urn:ietf:params:xml:ns:yang:yin:1"
    version="1.0">
  <import href="../../../xslt/iana-yinx.xsl"/>
  <output method="xml" encoding="utf-8"/>
  <strip-space elements="*"/>

  <template match="iana:registry[@id='quic-transport']">
    <element name="yin:typedef">
      <attribute name="name">quic-transport-parameter</attribute>
      <element name="yin:type">
        <attribute name="name">enumeration</attribute>
        <apply-templates select="iana:record"/>
      </element>
      <element name="yin:description">
        <element name="yin:text">
          This enumeration type defines QUIC transport parameters.
        </element>
      </element>
      <element name="yin:reference">
        <element name="yin:text">
          RFC 9000: QUIC: A UDP-Based Multiplexed and Secure Transport
        </element>
      </element>
    </element>
    <element name="yin:typedef">
      <attribute name="name">transport-parameter</attribute>
      <element name="yin:type">
        <attribute name="name">quic-transport-parameter</attribute>
      </element>
      <element name="yin:description">
        <element name="yin:text">
          This type allows reference to a QUIC transport parameters
          using the assigned value.
        </element>
      </element>
    </element>
  </template>

  <template match="iana:record">
    <param name="deprecated"
           select="contains(iana:notes,'Deprecated') or
                   contains(iana:notes,'deprecated')"/>
    <param name="refs">
      <call-template name="process-xrefs"/>
    </param>

    <element name="yin:enum">
      <attribute name="name">
        <!-- Remove parenthesis from name and replace space with underscore -->
        <value-of select="translate(translate(iana:name,'()',''),
                          ' ','_')"/>
      </attribute>
      <if test="$deprecated">
        <element name="yin:status">
          <attribute name="value">deprecated</attribute>
        </element>
      </if>
      <element name="yin:description">
        <element name="yin:text">
          <value-of select="iana:value"/>
          <value-of select="concat(' (',iana:status,') ')"/>
          <value-of select="iana:notes"/>
        </element>
      </element>
      <if test="$refs != ''">
        <element name="yin:reference">
          <element name="yin:text">
            <choose>
              <when test="string-length($refs) &lt; 59">
                <copy-of select="$refs"/>
              </when>
              <otherwise>
                <!-- Wrap a long URL in the registry -->
                <value-of select="str:replace($refs,'wiki','wiki ')"/>
              </otherwise>
            </choose>
          </element>
        </element>
      </if>
    </element>
  </template>

</stylesheet>
