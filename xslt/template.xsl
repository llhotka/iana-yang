<?xml version="1.0" encoding="utf-8"?>
<stylesheet
    xmlns="http://www.w3.org/1999/XSL/Transform"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:iana="http://www.iana.org/assignments"
    xmlns:yin="urn:ietf:params:xml:ns:yang:yin:1"
    version="1.0">
  <import href="../../../xslt/iana-yin.xsl"/>
  <output method="xml" encoding="utf-8"/>
  <strip-space elements="*"/>

  <!-- Replace REGISTRY-ID with the the value specified in the 'id'
       attribute of the <registry> element. -->
  <template match="iana:registry[@id='REGISTRY-ID']">
  </template>

</stylesheet>
