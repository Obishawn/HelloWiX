<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:wix="http://schemas.microsoft.com/wix/2006/wi">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

	<!-- Copy all attributes and elements to the output. -->
	<xsl:template match="@*|*">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:key name="FileId" use="@Id"
					 match='//wix:Component[wix:File[@Source="$(var.HelloWixService.TargetDir)\HelloWixService.exe"]]' />

	<!-- Exclude Service Executable -->
	<xsl:template match='//wix:Component[wix:File[@Source="$(var.HelloWixService.TargetDir)\HelloWixService.exe"]]' />

	<!--Exclude Service Executable Component from ComponentGroup-->
	<xsl:template match="wix:ComponentRef[key('FileId',@Id)]" />
</xsl:stylesheet>
