<?xml version="1.0" encoding="utf-8"?>
<stylesheet
    xmlns="http://www.w3.org/1999/XSL/Transform"
    xmlns:iana="http://www.iana.org/assignments"
    version="1.0">
  <output method="text"/>

  <!-- Parameters passed from the Makefile -->
  <param name="module"/>
  <param name="iana-url"/>
  <param name="category"/>
  <param name="regid"/>

  <!--
      Parse a single-space-separated list of registry IDs contained in
      the regid parameter, and produce a list of Org mode links for
      use in the README table.
  -->
  <template name="registry-links">
    <param name="regid"/>
    <choose>
      <when test="contains($regid, ' ')">
	<call-template name="org-link">
	  <with-param name="rid" select="substring-before($regid, ' ')"/>
	</call-template>
	<text>, </text>
	<call-template name="registry-links">
	  <with-param name="regid" select="substring-after($regid, ' ')"/>
	</call-template>
      </when>
      <otherwise>
	<call-template name="org-link">
	  <with-param name="rid" select="$regid"/>
	</call-template>
      </otherwise>
    </choose>
  </template>

  <template name="org-link">
    <param name="rid"/>
    <value-of select="concat('[[', $iana-url, '#', $rid, '][')"/>
    <value-of select="concat(//iana:registry[@id=$rid]/iana:title, ']]')"/>
  </template>

  <template match="/">
    <text>| [[file:</text>
    <value-of select="concat($category, '/', $module, '][', $module)"/>
    <text>]] | </text>
    <call-template name="registry-links">
      <with-param name="regid" select="$regid"/>
    </call-template>
    <text> |&#xA;</text>
  </template>
  
</stylesheet>
