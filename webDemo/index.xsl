<?xml version="1.0" encoding="UTF-8"?>
<!-- Edited by XMLSpy® -->
<html xsl:version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
	<body style="font-family:Arial;font-size:12pt;background-color:#EEEEEE">
		<xsl:for-each select="root/child">
			<div style="background-color:teal;color:white;padding:4px">
				<span style="font-weight:bold">第一行<xsl:value-of select="child"/></span>
			</div>
			<div style="margin-left:20px;margin-bottom:1em;font-size:10pt">
				<p><xsl:value-of select="subchild"/></p>
			</div>
		</xsl:for-each>
		<xsl:for-each select="root/note">
			<div style="background-color:teal;color:white;padding:4px">
				<span style="font-weight:bold"><xsl:value-of select="name"/></span>
				-<xsl:value-of select="age"/>
			</div>
			<div style="margin-left:20px;margin-bottom:1em;font-size:10pt">
				<p><xsl:value-of select="body"/></p>
			</div>
		</xsl:for-each>
		<div style="background-color:teal;color:white;padding:4px">
			<span style="font-weight:bold">符号</span>
		</div>
		<xsl:for-each select="root/message/test">
			<div style="margin-left:20px;margin-bottom:1em;font-size:10pt">
				<div>
					<xsl:value-of select="test"/>
				</div>
			</div>
		</xsl:for-each>
	</body>
</html>