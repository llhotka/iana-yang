<?xml version="1.0" encoding="utf-8"?>
<stylesheet
    xmlns="http://www.w3.org/1999/XSL/Transform"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:iana="http://www.iana.org/assignments"
    xmlns:yin="urn:ietf:params:xml:ns:yang:yin:1"
    version="1.0">

  <!-- Parameters passed from the Makefile -->
  <param name="module"/>
  <param name="prefix"/>
  <param name="iana-url"/>
  <param name="regid"/>

  <!-- Prefix of the namespace URI -->
  <param name="base-uri">urn:ietf:params:xml:ns:yang:</param>

  <variable name="nregid" select="normalize-space($regid)"/>
  <variable name="dq">"</variable>
  <variable name="sq">'</variable>

  <template name="iana-contact">
    <element name="yin:contact">
      <element name="yin:text">
	<element name="html:p">
	  <text>Internet Assigned Numbers Authority</text>
	</element>
	<element name="html:p">
	  <text>ICANN</text>
	  <element name="html:br"/>
	  <text>12025 Waterfront Drive, Suite 300</text>
	  <element name="html:br"/>
	  <text>Los Angeles, CA 90094</text>
	  <element name="html:br"/>
	</element>
	<element name="html:p">
	  <text>Tel: +1 424 254 5300</text>
	</element>
	<element name="html:p">
	  <text>&lt;mailto:iana@iana.org&gt;</text>
	</element>
      </element>
    </element>
  </template>

  <template name="module-description">
    <variable name="suffix">
      <choose>
	<when test="contains($nregid, ' ')">ies</when>
	<otherwise>y</otherwise>
      </choose>
    </variable>
    <element name="yin:description">
      <element name="yin:text">
	<element name="html:p">
	  <text>This YANG module translates IANA registr</text>
	  <value-of select="concat($suffix, ' ')"/>
	  <call-template name="registry-names">
	    <with-param name="rids" select="$nregid"/>
	  </call-template>
	  <text> to YANG derived types.</text>
	</element>
	<element name="html:p">
	  <text>Copyright (c) </text>
	  <value-of select="substring-before(/iana:registry/iana:updated,
			    '-')"/>
	  <text> IETF Trust. All rights reserved.</text>
	</element>
	<element name="html:p">
	  Redistribution and use in source and binary forms, with or
	  without modification, is permitted pursuant to, and subject
	  to the license terms contained in, the Simplified BSD
	  License set forth in Section 4.c of the IETF Trust's Legal
	  Provisions Relating to IETF Documents
	  (https://trustee.ietf.org/license-info).
	</element>
	<element name="html:p">
	  <text>This version of this YANG module was generated from
	  the corresponding IANA registr</text>
	  <value-of select="$suffix"/>
	  using an XSLT stylesheet from the 'iana-yang' project
	  (https://github.com/llhotka/iana-yang).
	</element>
      </element>
    </element>
  </template>

  <template name="module-intro">
    <element name="yin:yang-version">
      <attribute name="value">1.1</attribute>
    </element>
    <element name="yin:namespace">
      <attribute name="uri">
	<value-of select="concat($base-uri, $module)"/>
      </attribute>
    </element>
    <element name="yin:prefix">
      <attribute name="value">
	<value-of select="$prefix"/>
      </attribute>
    </element>
    <element name="yin:organization">
      <element name="yin:text">
	Internet Assigned Numbers Authority (IANA)
      </element>
    </element>
    <call-template name="iana-contact"/>
    <call-template name="module-description"/>
    <element name="yin:reference">
      <element name="yin:text">
	<value-of select="concat(/iana:registry/iana:title, ' (',
			  $iana-url, ')')"/>
      </element>
    </element>
    <element name="yin:revision">
      <attribute name="date">
	<value-of select="/iana:registry/iana:updated"/>
      </attribute>
      <element name="yin:description">
	<element name="yin:text">
	  <text>Current revision as of the revision date.</text>
	</element>
      </element>
    </element>
  </template>

  <!--
      Parse a single-space-separated list of registry IDs contained in
      the regid parameter, and produce a list of registry names for
      use in module description.
  -->
  <template name="registry-names">
    <param name="rids"/>
    <choose>
      <when test="contains($rids, ' ')">
	<call-template name="quoted-title">
	  <with-param name="rid" select="substring-before($rids, ' ')"/>
	</call-template>
	<variable name="cdr" select="substring-after($rids, ' ')"/>
	<choose>
	  <when test="contains($cdr, ' ')">
	    <text>, </text>
	  </when>
	  <otherwise>
	    <text> and </text>
	  </otherwise>
	</choose>
	<call-template name="registry-names">
	  <with-param name="rids" select="$cdr"/>
	</call-template>
      </when>
      <otherwise>
	<call-template name="quoted-title">
	  <with-param name="rid" select="$rids"/>
	</call-template>
      </otherwise>
    </choose>
  </template>

  <template name="quoted-title">
    <param name="rid"/>
    <value-of
	select="concat($sq, //iana:registry[@id=$rid]/iana:title, $sq)"/>
  </template>

  <template name="process-registries">
    <param name="rids"/>
    <if test="string-length($rids) &gt; 0">
      <apply-templates select="//iana:registry[
			       @id=substring-before($rids, ' ')]"/>
      <call-template name="process-registries">
	<with-param name="rids" select="substring-after($rids, ' ')"/>
      </call-template>
    </if>
  </template>

  <!-- Template for a YANG enum entry  -->
  <template name="enum">
    <param name="id"
	   select="normalize-space(iana:type|iana:name|iana:mnemonic)"/>
    <param name="value"
	   select="normalize-space(iana:value|iana:number)"/>
    <param name="description">
      <element name="html:p">
	<value-of select="iana:description"/>
      </element>
    </param>
    <param name="refs">
      <call-template name="process-xrefs"/>
    </param>
    <param name="deprecated"
	   select="contains(iana:description, 'deprecated')"/>
    <param name="obsolete"
	   select="contains(iana:description, 'OBSOLETE')"/>
    <element name="yin:enum">
      <attribute name="name">
	<value-of select="normalize-space($id)"/>
      </attribute>
      <element name="yin:value">
	<attribute name="value">
	  <value-of select="$value"/>
	</attribute>
      </element>
      <choose>
	<when test="$deprecated">
	  <element name="yin:status">
	    <attribute name="value">deprecated</attribute>
	  </element>
	</when>
	<when test="$obsolete">
	  <element name="yin:status">
	    <attribute name="value">obsolete</attribute>
	  </element>
	</when>
      </choose>
      <if test="$description">
	<element name="yin:description">
	  <element name="yin:text">
	    <copy-of select="$description"/>
	  </element>
	</element>
      </if>
      <if test="$refs">
	<element name="yin:reference">
	  <element name="yin:text">
	    <copy-of select="$refs"/>
	  </element>
	</element>
      </if>
    </element>
  </template>

  <!-- Process references of an IANA record -->
  <template name="process-xrefs">
    <param name="xrefs" select="iana:xref[@type != 'note']"/>
    <if test="$xrefs">
      <choose>
	<when test="count($xrefs) &gt; 1">
	  <element name="html:ul">
	    <for-each select="$xrefs">
	      <element name="html:li">
		<apply-templates select="."/>
	      </element>
	    </for-each>
	  </element>
	</when>
	<otherwise>
	  <element name="html:p">
	    <apply-templates select="$xrefs"/>
	  </element>
	</otherwise>
      </choose>
    </if>
  </template>

  <template match="/">
    <element name="yin:module">
      <attribute name="name">
	<value-of select="$module"/>
      </attribute>
      <call-template name="module-intro"/>
      <call-template name="process-registries">
	<with-param name="rids" select="concat($nregid, ' ')"/>
      </call-template>
    </element>
  </template>

  <!-- Template for a standard record with well-defined name. -->
  <template match="iana:record">
    <call-template name="enum"/>
  </template>

  <template match="iana:xref">
    <choose>
      <when test="@type='rfc'">
        <value-of
            select="concat('RFC ', substring-after(@data, 'rfc'))"/>
      </when>
      <when test="@type='person'">
        <apply-templates
            select="/iana:registry/iana:people/iana:person[
                    @id=current()/@data]"/>
      </when>
      <when test="@type='text'">
        <value-of select="translate(., $dq, $sq)"/>
      </when>
      <otherwise>
        <value-of select="@data"/>
      </otherwise>
    </choose>
  </template>

  <template match="iana:person">
    <value-of select="concat(iana:name, ' &lt;', iana:uri, '&gt;')"/>
  </template>
  
</stylesheet>
