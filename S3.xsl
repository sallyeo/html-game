<?xml version="1.0"?>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">
  
	<xsl:output method="xml" indent="yes" encoding="UTF-8"/>
	
	<!-- use of grouping key to group months together -->
	<xsl:key name="weatherMonth" match="weather" use="month" />
	
	<xsl:template match="/forecast">
		<html>
			<head>
				<title>Singapore Weather</title>
			</head>
			<body>
				<h2>Singapore weather &#x0005B;<xsl:value-of select="@qTime" />&#x0005D;</h2>
				<table border="1" style="border-collapse: collapse;">
				  
					<!-- First row -->
					<tr style="background-color:#F7CAAC">
						<th>Date</th>
						<th>Weather data</th>
						<th>Highest</th>
						<th>Lowest</th>
					</tr>
					
					<!-- Loop each weather, key grouping to group the months -->
					<xsl:for-each select="weather[count(. | key('weatherMonth', month)[1]) = 1]">
					<xsl:sort select="@yyyymmdd" order="ascending" />
						
							<tr>
								<xsl:attribute name="style">
									<xsl:choose>
									<!-- to set odd and even row background color -->
									<xsl:when test="position() mod 2 = 1">
										background-color:#D2EEF9
									</xsl:when>
									
									<xsl:otherwise>
										background-color:#F9FBDC
									</xsl:otherwise>
									</xsl:choose>
								</xsl:attribute>
							
								<th>
									<!-- display the month value in customized text -->
									<xsl:choose>
										<xsl:when test="month='01'">
											<xsl:text>Jan 20</xsl:text>
										</xsl:when>
										<xsl:when test="month='02'">
											<xsl:text>Feb 20</xsl:text>
										</xsl:when>
										<xsl:when test="month='03'">
											<xsl:text>Mar 20</xsl:text>
										</xsl:when>
										<xsl:when test="month='04'">
											<xsl:text>Apr 20</xsl:text>
										</xsl:when>
										<xsl:when test="month='05'">
											<xsl:text>May 20</xsl:text>
										</xsl:when>
										<xsl:when test="month='06'">
											<xsl:text>Jun 20</xsl:text>
										</xsl:when>
										<xsl:when test="month='07'">
											<xsl:text>Jul 20</xsl:text>
										</xsl:when>
										<xsl:when test="month='08'">
											<xsl:text>Aug 20</xsl:text>
										</xsl:when>
										<xsl:when test="month='09'">
											<xsl:text>Sep 20</xsl:text>
										</xsl:when>
										<xsl:when test="month='10'">
											<xsl:text>Oct 20</xsl:text>
										</xsl:when>
										<xsl:when test="month='11'">
											<xsl:text>Nov 20</xsl:text>
										</xsl:when>
											<xsl:when test="month='12'">
										<xsl:text>Dec 20</xsl:text>
											</xsl:when>
									</xsl:choose>
								</th>
								
								<td>
									<ul>
										<!-- apply key grouping to group months -->
										<xsl:for-each select="key('weatherMonth', month)">
										<xsl:sort select="@yyyymmdd" order="ascending" />
										
										<li>
											<xsl:value-of select="date" /> 
											<xsl:text>/</xsl:text>
											<xsl:value-of select="month" /> 
											<xsl:text>/</xsl:text>
											<xsl:value-of select="year" /> 
											<xsl:text>, from </xsl:text>
											<xsl:value-of select="lowest" /> 
											<xsl:text>&#8451; to </xsl:text>
											<xsl:value-of select="highest" /> 
											<xsl:text>&#8451;, </xsl:text>
											<xsl:value-of select="comment" /> 
											<xsl:text></xsl:text>
										</li>
										</xsl:for-each>
									</ul>
								</td>
							
								<td align="center">
									<!-- highest temperature -->
									<xsl:for-each select="key('weatherMonth',month)" >
									<xsl:sort select="highest" data-type="number" order="descending"/>
									<xsl:if test="position() = 1">
									<xsl:choose>
										<xsl:when test="code='cloudy'">
											<span style="color:blue">
												<xsl:value-of select="highest" />
												<xsl:text>&#8451;</xsl:text>
											</span>
										</xsl:when>
										
										<xsl:when test="code='thunderstorm'">
											<span style="color:green">
												<xsl:value-of select="highest" />
												<xsl:text>&#8451;</xsl:text>
											</span>
										</xsl:when>
										
										<xsl:when test="code='rain'">
											<span style="color:green">
												<xsl:value-of select="highest" />
												<xsl:text>&#8451;</xsl:text>
											</span>
										</xsl:when>
										
										<xsl:otherwise>
											<span style="color:orange">
												<xsl:value-of select="highest" />
												<xsl:text>&#8451;</xsl:text>
											</span>
										</xsl:otherwise>
									</xsl:choose>
									</xsl:if>
									</xsl:for-each>
									<br/>
									<!-- image -->
									<img>
									  <xsl:attribute name="src">
										<xsl:text>images/</xsl:text>
										<xsl:value-of select="code"/>
										<xsl:text>.png</xsl:text>
									  </xsl:attribute>

									  <xsl:attribute name="width">
										<xsl:text>100px</xsl:text>
									  </xsl:attribute>
								   </img>
								</td>
							
								<td align="center">
									<!-- lowest temperature -->
									<xsl:for-each select="key('weatherMonth',month)" >
									<xsl:sort select="lowest" data-type="number" order="ascending"/>
									<xsl:if test="position() = 1">
									<xsl:choose>
										<xsl:when test="code='cloudy'">
											<span style="color:blue">
												<xsl:value-of select="lowest" />
												<xsl:text>&#8451; </xsl:text>
											</span>
										</xsl:when>
										
										<xsl:when test="code='thunderstorm'">
											<span style="color:green">
												<xsl:value-of select="lowest" />
												<xsl:text>&#8451; </xsl:text>
											</span>
										</xsl:when>
										
										<xsl:when test="code='rain'">
											<span style="color:green">
												<xsl:value-of select="lowest" />
												<xsl:text>&#8451; </xsl:text>
											</span>
										</xsl:when>
										
										<xsl:otherwise>
											<span style="color:orange">
												<xsl:value-of select="lowest" />
												<xsl:text>&#8451; </xsl:text>
											</span>
										</xsl:otherwise>
									</xsl:choose>
									</xsl:if>
									</xsl:for-each>
									<br/>
									<!-- image -->
									<img>
									  <xsl:attribute name="src">
										<xsl:text>images/</xsl:text>
										<xsl:value-of select="code"/>
										<xsl:text>.png</xsl:text>
									  </xsl:attribute>

									  <xsl:attribute name="width">
										<xsl:text>100px</xsl:text>
									  </xsl:attribute>
								   </img>
								</td>
							</tr>	
					</xsl:for-each>				  
				</table>	
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>