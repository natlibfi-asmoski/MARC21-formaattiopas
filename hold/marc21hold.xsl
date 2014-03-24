<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

  <xsl:output method="html"/>
  <xsl:template match="/">
<html>

<head>
<meta http-equiv="Content-Language" content="fi" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>MARC 21: Varastotiedot</title>
</head>

<body>
<a name="alku"></a>

<center>
<table border="2" width="600" bordercolor="#000000" id="table1" bgcolor="#FFCC00">
	<tr>
		<td>
		<p align="center">Kansalliskirjasto</p>
		<h1 align="center">MARC 21 -formaatti:<br />
		VARASTOTIEDOT</h1>
		</td>
	</tr>
</table>
</center>
      <xsl:apply-templates/>
<p><a href="index.htm">Varastotiedot-etusivulle</a> | <a href="../index.htm">MARC 21 -etusivulle</a></p>
<hr/>
<p>&#160;</p>
</body>
</html>
  </xsl:template>


  <xsl:template match="modified">
<p align="center">
<i><span style="background-color: #FFFF00">
P�ivitetty viimeksi <xsl:value-of select="."/>.<br/>
Ks. <a href="../ohje.htm">Ohjeita formaattien kommentointiin</a>.</span></i></p>
  </xsl:template>

  <xsl:template match="leader-directory">
<h2 align="left"><xsl:value-of select="title"/></h2>
<p><a href="index.htm">Varastotiedot-etusivulle</a> |
<a href="../index.htm">MARC 21 -etusivulle</a></p>
<hr />

<ul>
	<li><a href="#nimio">NIMI�</a></li>
	<li><a href="#hakemisto">HAKEMISTO</a></li>
</ul>

<hr />
    <xsl:apply-templates select="leader|directory"/>
  </xsl:template>

  <xsl:template match="leader">
    <h3><a name="nimio"></a>NIMI�</h3>
    <p><xsl:apply-templates select="description"/></p>
    <xsl:apply-templates select="positions"/>
    <p><a href="#alku">Sivun alkuun</a></p>
    <hr/>
  </xsl:template>

  <xsl:template match="directory">
    <h3><a name="hakemisto"></a>HAKEMISTO</h3>
    <p><xsl:value-of select="description"/></p>
    <xsl:apply-templates select="positions"/>
    <p><a href="#alku">Sivun alkuun</a></p>
    <hr/>
  </xsl:template>

  <xsl:template match="positions">
    <xsl:if test="name(parent::node()) != 'subfield'">
    <h4>Merkkipaikat</h4>
    </xsl:if>
    <ul>
    <xsl:apply-templates select="position"/>
    </ul>
  </xsl:template>

  <xsl:template match="position">
    <li><strong><xsl:value-of select="@pos"/></strong> - <xsl:value-of select="name"/><xsl:choose><xsl:when test="equals"> (= <xsl:value-of select="equals/@tag"/>/<xsl:value-of select="equals/@positions"/>)</xsl:when></xsl:choose>
    <xsl:choose><xsl:when test="description"><br/></xsl:when></xsl:choose>
    <xsl:apply-templates select="description"/>
    <xsl:apply-templates select="alternatives"/>
    <xsl:apply-templates select="values"/>
    </li>
  </xsl:template>

  <xsl:template match="alternatives">
    <ul>
    <xsl:apply-templates select="alternative"/>
    </ul>
  </xsl:template>

  <xsl:template match="alternative">
    <li>
    <em><xsl:value-of select="name"/></em>
    <xsl:apply-templates select="values"/>
    </li>
  </xsl:template>

  <xsl:template match="controlfields">
    <h2 align="left"><xsl:value-of select="title"/></h2>
    <p><a href="index.htm">Varastotiedot-etusivulle</a> |
    <a href="../index.htm">MARC 21 -etusivulle</a></p>
    <hr/>

    <p><xsl:value-of select="description"/></p>
    <ul>
      <xsl:for-each select="controlfield">
        <xsl:variable name="anchor"><xsl:choose><xsl:when test="@type"><xsl:value-of select="@type"/></xsl:when><xsl:otherwise><xsl:value-of select="@tag"/></xsl:otherwise></xsl:choose></xsl:variable>
        <li><a href="#{$anchor}"><xsl:value-of select="@tag"/> - <xsl:call-template name="capitalize"><xsl:with-param name="str" select="name"/></xsl:call-template></a><xsl:choose><xsl:when test="@repeatable='Y'"> (T)</xsl:when><xsl:when test="@repeatable='N'"> (ET)</xsl:when></xsl:choose></li>
      </xsl:for-each>
    </ul>
    <xsl:apply-templates select="terminology"/>
    <hr/>
    <xsl:apply-templates select="controlfield"/>
  </xsl:template>

  <xsl:template match="controlfield">
    <xsl:variable name="anchor"><xsl:choose><xsl:when test="@type"><xsl:value-of select="@type"/></xsl:when><xsl:otherwise><xsl:value-of select="@tag"/></xsl:otherwise></xsl:choose></xsl:variable>
    <h3><a name="{$anchor}"/><xsl:value-of select="@tag"/> - <xsl:call-template name="capitalize"><xsl:with-param name="str" select="name"/></xsl:call-template><xsl:choose><xsl:when test="@repeatable='Y'"> (T)</xsl:when><xsl:when test="@repeatable='N'"> (ET)</xsl:when></xsl:choose></h3>
    <xsl:for-each select="description"><p><xsl:apply-templates/></p></xsl:for-each>
    <xsl:apply-templates select="positions"/>
    <xsl:apply-templates select="examples"/>
    <p><a href="#alku">Sivun alkuun</a></p>
    <hr/>
  </xsl:template>

  <xsl:template match="datafields">
    <h2 align="left"><xsl:value-of select="title"/></h2>
    <p><a href="index.htm">Varastotiedot-etusivulle</a> |
    <a href="../index.htm">MARC 21 -etusivulle</a></p>
    <hr/>

    <p><xsl:apply-templates select="description"/></p>
    <ul>
      <xsl:for-each select="datafield">
	    <xsl:choose>
        <xsl:when test="@tag='853'">
          <li><a href="#yleista">ILMESTYMISTIEDOT--YLEIST� TIETOA</a></li>
        </xsl:when>
        <xsl:when test="@tag='863'">
          <li><a href="#yleista">M��R�MUOTOISET VARASTOTIEDOT--YLEIST� TIETOA</a></li>
        </xsl:when>
        <xsl:when test="@tag='866'">
          <li><a href="#yleista">VAPAAMUOTOISET VARASTOTIEDOT--YLEIST� TIETOA</a></li>
        </xsl:when>
        <xsl:when test="@tag='876'">
          <li><a href="#yleista">KAPPALETIEDOT--YLEIST� TIETOA</a></li>
        </xsl:when>
        </xsl:choose>
      <li><a href="#{@tag}"><xsl:value-of select="@tag"/> - <xsl:call-template name="capitalize"><xsl:with-param name="str" select="name"/></xsl:call-template></a><xsl:choose><xsl:when test="@repeatable='Y'"> (T)</xsl:when><xsl:when test="@repeatable='N'"> (ET)</xsl:when></xsl:choose></li>
      </xsl:for-each>
    </ul>
    <xsl:apply-templates select="terminology"/>
    <hr/>
    <xsl:apply-templates select="datafield"/>
  </xsl:template>

  <xsl:template match="datafield">
    <xsl:choose>
    <xsl:when test="@tag='853'">
      <xsl:call-template name="yleista853"/>
    </xsl:when>
    <xsl:when test="@tag='863'">
      <xsl:call-template name="yleista863"/>
    </xsl:when>
    <xsl:when test="@tag='866'">
      <xsl:call-template name="yleista866"/>
    </xsl:when>
    <xsl:when test="@tag='876'">
      <xsl:call-template name="yleista876"/>
    </xsl:when>
    </xsl:choose>
    <xsl:choose>
    <xsl:when test="@local">
      <span style="color: red;">
	    <h3><a name="{@tag}"></a><xsl:value-of select="@tag"/> - <xsl:call-template name="capitalize"><xsl:with-param name="str" select="name"/></xsl:call-template><xsl:choose><xsl:when test="@repeatable='Y'"> (T)</xsl:when><xsl:when test="@repeatable='N'"> (ET)</xsl:when></xsl:choose></h3>
	    <xsl:for-each select="description"><p><xsl:apply-templates/></p></xsl:for-each>
	    <xsl:apply-templates select="indicators"/>
	    <xsl:apply-templates select="subfields"/>
	    <xsl:apply-templates select="positions"/>
	    <xsl:apply-templates select="instruments"/>
	    <xsl:apply-templates select="examples"/>
	  </span>
    </xsl:when>
    <xsl:otherwise>
	    <h3><a name="{@tag}"></a><xsl:value-of select="@tag"/> - <xsl:call-template name="capitalize"><xsl:with-param name="str" select="name"/></xsl:call-template><xsl:choose><xsl:when test="@repeatable='Y'"> (T)</xsl:when><xsl:when test="@repeatable='N'"> (ET)</xsl:when></xsl:choose></h3>
	    <xsl:for-each select="description"><p><xsl:apply-templates/></p></xsl:for-each>
	    <xsl:apply-templates select="indicators"/>
	    <xsl:apply-templates select="subfields"/>
	    <xsl:apply-templates select="positions"/>
	    <xsl:apply-templates select="instruments"/>
	    <xsl:apply-templates select="examples"/>
    </xsl:otherwise>
    </xsl:choose>
    <p><a href="#alku">Sivun alkuun</a></p>
    <hr/>
  </xsl:template>

  <xsl:template match="indicators">
    <h4>Indikaattorit</h4>
		<ul>
		<xsl:apply-templates select="indicator"/>
		</ul>
  </xsl:template>

  <xsl:template match="indicator">
    <li><xsl:choose><xsl:when test="@num='1'">Ensimm�inen</xsl:when><xsl:when test="@num='2'">Toinen</xsl:when></xsl:choose> - <xsl:apply-templates select="description"/>
    <ul>
    <xsl:for-each select="values/value"><li><strong><xsl:value-of select="@code"/></strong> - <xsl:apply-templates select="description"/>
    </li>
    </xsl:for-each>
    </ul>
    </li>
  </xsl:template>

  <xsl:template match="subfields">
    <h4>Osakentt�koodit</h4>
		<ul>
		<xsl:apply-templates select="subfield"/>
		</ul>
  </xsl:template>

  <xsl:template match="subfield">
    <li><strong>&#8225;<xsl:value-of select="@code"/></strong> - <xsl:value-of select="name"/><xsl:choose><xsl:when test="@repeatable='Y'"> (T)</xsl:when><xsl:when test="@repeatable='N'"> (ET)</xsl:when></xsl:choose>
    <xsl:if test="description"><br/><xsl:apply-templates select="description"/></xsl:if>
    <xsl:apply-templates select="positions"/>
    <xsl:apply-templates select="values"/>
    </li>
  </xsl:template>

  <xsl:template match="instruments">
    <h4>Soitinten ja ��nialojen MARC 21 -koodit</h4>
    <ul>
    <xsl:apply-templates select="instrument"/>
    </ul>
  </xsl:template>

  <xsl:template match="instrument">
    <li><strong><xsl:value-of select="@code"/></strong> - <xsl:value-of select="name"/>
    </li>
  </xsl:template>

  <xsl:template match="examples">
    <xsl:param name="tag"/>
    <h4><xsl:choose><xsl:when test="count(example)=1">Esimerkki</xsl:when><xsl:otherwise>Esimerkkej�</xsl:otherwise></xsl:choose></h4>

  <xsl:for-each select="example"><p><xsl:apply-templates select="text"/></p>
      <xsl:choose><xsl:when test="description"><xsl:call-template name="example-description"/></xsl:when></xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="values">
    <ul>
    <xsl:for-each select="value"><li>
    <xsl:choose>
      <xsl:when test="@local">
        <span style="color: red;">
	    <xsl:choose>
	      <xsl:when test="name"><strong><xsl:value-of select="@code"/></strong> - <xsl:apply-templates select="name"/></xsl:when>
		  <xsl:otherwise><em><xsl:value-of select="@code"/></em></xsl:otherwise>
		</xsl:choose>
	    <xsl:if test="description"><br/><xsl:apply-templates select="description"/></xsl:if>
	    </span>
      </xsl:when>
      <xsl:otherwise>
	    <xsl:choose>
	      <xsl:when test="name"><strong><xsl:value-of select="@code"/></strong> - <xsl:apply-templates select="name"/></xsl:when>
		  <xsl:otherwise><em><xsl:value-of select="@code"/></em></xsl:otherwise>
		</xsl:choose>
	    <xsl:if test="description"><br/><xsl:apply-templates select="description"/></xsl:if>
      </xsl:otherwise>
    </xsl:choose>
    </li>
    </xsl:for-each>
    </ul>
  </xsl:template>

  <xsl:template name="yleista853">
<h3><a name="yleista"></a>ILMESTYMISTIEDOT--YLEIST� TIETOA</h3>
<p>Kent�t 853-855 sis�lt�v�t selosteita, joiden avulla tunnistetaan 
kohteen numerointi- ja julkaisuaikatasot, sek� koodeja, jotka m��rittelev�t kentiss� 
863-865 kuvattujen varastotietojen 
julkaisukaavan. Kenttien 853-855 ja 863-865 toisiinsa liittyv�t esiintym�t  
linkitet��n toisiinsa numerolla osakent�ss� &#8225;8 (Linkki- ja j�rjestysnumero).</p>
<p>Yleinen kuvaus varastotietojen nelj�st� eri kentt�ryhm�st�, niiden suhteista 
toisiinsa ja niiden toistettavuudesta l�ytyy osiosta <em><a href="yleista.htm">
Varastotiedot--yleist� tietoa</a></em>.</p>
<h3>Indikaattorit</h3>
<ul>
	<li>Ensimm�inen - Tiivistett�vyys ja laajennettavuus <em>[853/854]</em><br/>
	Kentiss� 853 ja 854 t�ll� arvolla ilmaistaan voidaanko n�ihin liittyvien 
	m��r�muotoisten varastotietokenttien osakenttien &#8225;a-&#8225;m tiedot muuntaa 
	automaattisesti joko kappalekohtaisesta v�liksi, joka ilmaisee samat 
	varastotiedot n�ytt�m�ll� vain ensimm�isen ja viimeisen osan tiedot tai 
	tiivistetyst� &quot;ensimm�inen-viimeinen&quot; -v�list� selke�ksi merkinn�ksi, 
	joka listaa jokaisen osan erikseen.<ul>
		<li><strong>0</strong> - Ei voida tiivist�� tai laajentaa</li>
		<li><strong>1</strong> - Voidaan tiivist��, mutta ei laajentaa</li>
		<li><strong>2</strong> - Voidaan tiivist�� tai laajentaa</li>
		<li><strong>3</strong> - Tuntematon</li>
		</ul>
	</li>
	<li>Ensimm�inen - M��rittelem�t�n <em>[855]</em><ul>
		<li><strong>#</strong> - M��rittelem�t�n</li>
	</ul>
	</li>
	<li>Toinen - Selostetietojen luotettavuus <em>[853/854]</em><br/>
	Kentiss� 853 ja 854 t�ll� arvolla ilmaistaan 
	selosteissa annettujen tietojen t�ydellisyys 
	suhteessa m��r�muotoisten varastotietojen eri tasoihin (&#8225;a-&#8225;m), 
	sek� niiden n�kyminen bibliografisessa kohteessa.<ul>
		<li><strong>0</strong> - Tasojen selosteet tarkistettu, kaikki tasot 
		l�ytyv�t kohteesta</li>
		<li><strong>1</strong> - Tasojen selosteet tarkistettu, tasoja voi puuttua 
		kohteesta</li>
		<li><strong>2</strong> - Tasojen selosteet tarkistamatta, kaikki tasot 
		l�ytyv�t kohteesta</li>
		<li><strong>3</strong> - Tasojen selosteet tarkistamatta, tasoja voi puuttua 
		kohteesta</li>
	</ul>
	</li>
	<li>Toinen - M��rittelem�t�n <em>[855]</em><ul>
		<li><strong>#</strong> - M��rittelem�t�n</li>
	</ul>
	</li>
	</ul>
<h3>Osakentt�koodit</h3>
<p><strong>&#8225;a-&#8225;h</strong> - Numerointitasojen selosteet</p>
	<p>Kentiss� 863-865 ja 853-855 osakent�t &#8225;a-&#8225;h ovat vastaavuussuhteessa 
	toisiinsa, joskaan k�ytettyjen osakenttien ei tarvitse olla samat. 
	T�ydellist� vastaavuutta ei tarvita, kun numerointitasojen selosteita ei haluta k�ytt�� n�yt�iss�. 
	Sen sijaan osakenttien on vastattava toisiaan t�ydellisesti, kun kent�n 863 tai 864 
	tiedot halutaan tiivist�� tai laajentaa automaattisesti. T�ll�in mahdolliset 
	puuttuvat numerointitasojen selosteet voidaan keksi� ja merkit� hakasulkeisiin 
	([ ]).</p>
	<p>Kun kohteeseen soveltuu vaihtoehtoisia numerointeja, niiden selosteet 
	merkit��n osakenttiin &#8225;g ja &#8225;h. Jos vaihtoehtoisia numerointitasoja on 
	enemm�n kuin kaksi, k�ytet��n kentti� 866-868 (Vapaamuotoiset varastotiedot).</p>
	<p>Kun k�ytet��n vain julkaisuaikatasoja (kohteessa ei ole 
	numerointia), ne merkit��n asianomaisiin osakenttiin &#8225;a-&#8225;h. Jos 
	julkaisuaikatasoa 
	kuvaavaa selostetta ei ole tarkoitettu k�ytett�v�ksi n�yt�ss�, se merkit��n 
	sulkeisiin, esim. <em>(year)</em>.</p>
<p>Kun oheisaineiston tai hakemiston nime� k�ytet��n n�yt�ss� (jos niiden 
numerointi liittyy tietyn bibliografisen perusyksik�n tiettyyn volyymiin tai osaan, esim. v. 9, suppl.1-3), ne merkit��n 
asianomaisiin osakenttiin &#8225;a-&#8225;f.</p>
	<p>Kun numerointi koostuu varastossa olevien yksik�iden m��r�st�, jota 
	seuraa yksik�it� kuvaava termi, koko fraasi sijoitetaan sopivaan 863-865 
	kentt��n ja 853-855 kentt� sis�lt�� yksikk�termin (sulkeissa, jos sit� ei haluta n�ytt��n).</p>
	<ul>
		<li><strong>&#8225;a</strong> - Ensimm�inen numerointitaso (ET)</li>
		<li><strong>&#8225;b</strong> - Toinen numerointitaso (ET)</li>
		<li><strong>&#8225;c</strong> - Kolmas numerointitaso (ET)</li>
		<li><strong>&#8225;d</strong> - Nelj�s numerointitaso (ET)</li>
		<li><strong>&#8225;e</strong> - Viides numerointitaso (ET)</li>
		<li><strong>&#8225;f</strong> - Kuudes numerointitaso (ET)</li>
		<li><strong>&#8225;g</strong> - Vaihtoehtoinen numerointi, ensimm�inen numerointitaso (ET)</li>
		<li><strong>&#8225;h</strong> - Vaihtoehtoinen numerointi, toinen numerointitaso (ET)</li>
	    <li><strong>&#8225;i-&#8225;m</strong> - Julkaisuaikatasojen selosteet</li>
	</ul>
	<p>Kentiss� 863-865 ja 853-855 osakent�t &#8225;i-&#8225;m ovat vastaavuussuhteessa 
	toisiinsa, joskaan k�ytettyjen osakenttien ei tarvitse olla samat. 
	T�ydellist� vastaavuutta ei tarvita, kun julkaisuaikatasojen selosteita ei haluta k�ytt�� 
	n�yt�iss�. 
	Sen sijaan osakenttien on vastattava toisiaan t�ydellisesti, kun kent�n 863 tai 864 
	tiedot halutaan tiivist�� tai laajentaa automaattisesti. T�ll�in yleens� 
	puuttuvat julkaisuaikatasojen selosteet voidaan keksi� ja merkit� hakasulkeisiin 
	([ ]).</p>
	<p>Kun kohteeseen soveltuu vaihtoehtoinen julkaisuaika, sen seloste 
	merkit��n osakentt��n &#8225;m. Jos vaihtoehtoisia julkaisuaikatasoja on useita, 
	k�ytet��n kentti� 866-868 (Vapaamuotoiset varastotiedot).</p>
	<p>Kun k�ytet��n vain julkaisuaikatasoja (kohteessa ei ole numerointia), niit� 
	ei merkit� osakenttiin &#8225;i-&#8225;m, vaan ne merkit��n asianomaisiin osakenttiin &#8225;a-&#8225;h. 
	Jos julkaisuaikatasoa kuvaavaa selostetta ei ole tarkoitettu k�ytett�v�ksi 
	n�yt�ss�, se merkit��n sulkeisiin, esim. <em>(year)</em>.</p>
	<ul>
		<li><strong>&#8225;i</strong> - Ensimm�inen julkaisuaikataso (ET)</li>
		<li><strong>&#8225;j</strong> - Toinen julkaisuaikataso (ET)</li>
		<li><strong>&#8225;k</strong> - Kolmas julkaisuaikataso (ET)</li>
		<li><strong>&#8225;l</strong> - Nelj�s julkaisuaikataso (ET)</li>
		<li><strong>&#8225;m</strong> - Vaihtoehtoinen numerointi, julkaisuaikataso (ET)<br/>
</li>
		<li><strong>&#8225;n</strong> - Huomautus julkaisukaavasta (ET)</li>
		<li><strong>&#8225;o</strong> - Oheisaineiston tyyppi (ET) <em>[854]</em><br/>
		Seloste, joka kuvaa oheisaineiston tyyppi�, esim. ostajan opas. 
		Osakentt� &#8225;o seuraa v�litt�m�sti sit� selostetta, johon se liittyy. 
		Jos oheisaineiston nimeke on eri kuin sen tyyppi, nimeke 
		tallennetaan kent�n 864 osakentt��n &#8225;o (Oheisaineiston nimeke).</li>
		<li><strong>&#8225;o</strong> - Hakemiston tyyppi (ET) <em>[855]</em><br/>
		Seloste, joka kuvaa hakemiston tyyppi�, esim. aihehakemisto. Osakentt� &#8225;o seuraa v�litt�m�sti sit� 
		selostetta, johon se liittyy. Jos hakemiston nimeke on eri kuin sen 
		tyyppi, nimeke tallennetaan kent�n 865 osakentt��n &#8225;o (Hakemiston 
		nimeke).</li>
		<li><strong>&#8225;p</strong> - Kappaleiden m��r� per painos (ET)</li>
		<li><strong>&#8225;t</strong> - Kappaletiedon m��re (ET)<br/>
		Seloste kappalenumerolle, joka on linkitetyn m��r�muotoisen varastotietokent�n osakent�ss� &#8225;t.</li>
		<li><strong>&#8225;u</strong> - Kuvailtavan numerointitason sis�lt�mien bibliografisten yksik�iden m��r� (T)<br/>
		Osakentt� &#8225;u seuraa v�litt�m�sti sit� numerointitason selostetta, johon se viittaa.
		Osakentt�� &#8225;u ei k�ytet� osakenttien &#8225;a tai &#8225;g kanssa.<ul>
			<li><strong>[n]</strong> - Osien m��r�<br/>
			Esim. nelj� kertaa vuodessa ilmestyv� julkaisu vaatii 4 numeroa, 
			jotta siit� muodostuu yksi volyymi. Koska &#8225;u on vaihtuvamittainen 
			osakentt�, numeroissa ei tarvita etunollia.</li>
			<li><strong>var</strong> - Vaihtelee<br/>
			K�ytet��n, kun tarkka numero olisi merkitykset�n.</li>
			<li><strong>und</strong> - M��rittelem�t�n<br/>
			K�ytet��n, kun osien m��r�� ei tunneta.</li>
		</ul>
		</li>
		<li><strong>&#8225;v</strong> - Numeroinnin jatkuvuus (T)<br/>
		Onko kuvaillun tason numerointi jatkuva, vai alkaako se alusta jokaisen 
		yksik�n (volyymi tms.) alussa.<ul>
		<li><strong>c</strong> - Numero kasvaa jatkuvasti</li>
		<li><strong>r</strong> - Numerointi alkaa alusta jokaisen yksik�n alussa</li>
	</ul>
		</li>
		<li><strong>&#8225;w</strong> - 
Ilmestymistiheys (ET)<br/>Koodi tai numero, joka ilmaisee kohteen ilmestymistiheyden. Osakentt� &#8225;w 
tallennetaan viimeisen julkaisuaikatason selosteen j�lkeen. Tarkemmat 
		julkaisukaavaa koskevat tiedot tallennetaan osakentt��n &#8225;y 
		(S��nn�llisyys) ja my�s osakentt�� &#8225;p voidaan k�ytt��, kun moniosaisille 
		kohteille on tallennettava sek� ilmestymistiheyden koodi ett� 
		kappaleiden m��r� per painos.<ul>
		<li>Koodit:<ul>
		<li><strong>a</strong> - Kerran vuodessa</li>
		<li><strong>b</strong> - Joka toinen kuukausi</li>
		<li><strong>c</strong> - Kaksi kertaa viikossa</li>
		<li><strong>d</strong> - P�ivitt�in</li>
		<li><strong>e</strong> - Kerran kahdessa viikossa</li>
		<li><strong>f</strong> - Puolivuosittain</li>
		<li><strong>g</strong> - Kerran kahdessa vuodessa</li>
		<li><strong>h</strong> - Kerran kolmessa vuodessa</li>
		<li><strong>i</strong> - Kolme kertaa viikossa</li>
		<li><strong>j</strong> - Kolme kertaa kuukaudessa</li>
		<li><strong>k</strong> - Jatkuva p�ivitys</li>
		<li><strong>m</strong> - Kerran kuukaudessa</li>
		<li><strong>q</strong> - Nelj�sosavuosittain</li>
		<li><strong>s</strong> - Kaksi kertaa kuukaudessa</li>
		<li><strong>t</strong> - Kolme kertaa vuodessa</li>
		<li><strong>w</strong> - Kerran viikossa</li>
		<li><strong>x</strong> - T�ysin ep�s��nn�llinen</li>
	</ul>
		</li>
		<li>Numero<br/>
		Kun mik��n yll� mainituista s��nn�llisen ilmestymistiheyden koodeista ei 
		sovellu, voidaan vuodessa ilmestyvien numeroiden m��r� merkit� numerolla. 
		Koska &#8225;w on vaihtuvamittainen osakentt�, numerossa ei tarvita etunollia.</li>
	</ul>
		</li>
		<li><strong>&#8225;x</strong> - Kalenterin vaihtuminen (ET)<br/>
		Yksi tai useampi kaksi- tai nelinumeroinen koodi, joka ilmaisee 
		ajankohdan jolloin ylin julkaisuaikataso vaihtuu.<ul>
		<li>Koodit<br/>
		Kaksinumeroinen koodi ilmaisee vaihtumisajankohdan kuukauden tai 
		vuodenajan. Nelinumeroinen koodi (kuukausi ja p�iv�) tallennetaan 
		muodossa <em>kkpp</em>. Numerot tasataan vasemmalle ja k�ytt�m�tt�miss� 
		merkkipaikoissa on nolla.<ul>
		<li><u>Kuukausi:</u></li>
		<li>01-12 - Kuukausi</li>
		<li><u>P�iv�:</u></li>
		<li>01-31 - P�iv�</li>
		<li><u>Vuodenaika:</u></li>
		<li>21 - Kev�t</li>
		<li>22 - Kes�</li>
		<li>23 - Syksy</li>
		<li>24 - Talvi</li>
	</ul>
		</li>
	</ul>
		</li>
		<li><strong>&#8225;y</strong> - S��nn�llisyys (T)<br/>
		Kuvaa osakent�ss� &#8225;w (Ilmestymistiheys) koodatun julkaisukaavan 
		s��nn�llisyytt�. Osakentt� voidaan rakentaa kahdella tavalla k�ytt�m�ll� 
		joko julkaisuaika- tai numerointikoodeja. Molemmat aloitetaan 
		julkaisukoodilla.<ul>
		<li><em>Julkaisukoodi</em><br/>
		Osakent�n ensimm�isen merkkipaikan koodi osoittaa viittaavatko seuraavat 
		koodit kohteen osien julkaisemiseen tai julkaisemattomuuteen, tai joko 
		numerointi- tai julkaisuaikaelementtien yhdist�miseen.<ul>
		<li><strong>c</strong> - Yhdistetty</li>
		<li><strong>o</strong> - J�tetty julkaisematta</li>
		<li><strong>p</strong> - Julkaistu</li>
	</ul>
		</li>
		<li><strong><em>Julkaisuaikakoodi</em></strong><br/>
		K�ytett�ess� julkaisuaikakoodeja, tiedot kootaan seuraavasti:<br/>
		&lt;Julkaisukoodi&gt;&lt;Julkaisuaikakoodin 
		m��ritelm�&gt;&lt;Julkaisuaikakoodi&gt;&lt;Julkaisuaikakoodi&gt;...<br/>
		Osakentt� voi sis�lt�� yhden tai useampia julkaisuaikakoodeja, jotka 
		liittyv�t ensimm�isess� ja toisessa merkkipaikassa annettuihin 
		julkaisukoodiin ja julkaisuaikakoodin m��ritelm��n. Osakentt�� voidaan 
		toistaa ja tallentaa toisenlainen Julkaisukoodi/Julkaisuaikakoodin 
		m��ritelm�/Julkaisuaikakoodi -jakso, kun halutaan merkit� s��nn�llinen 
		poikkeus s��nn�llisess� julkaisukaavassa.</li>
		<li><em>Julkaisuaikakoodin m��ritelm�</em><br/>
		Osakent�n toisessa merkkipaikassa oleva koodi osoittaa ilmaisevatko 
		seuraavat julkaisuaikakoodit p�iv�n nime�, numeerista kuukausi- tai 
		kuukausi-ja-p�iv� -koodia, vuodenajan tai vuoden koodia, tai vuoden tai 
		kuukauden viikon koodia. (Jos osakent�ss� k�ytet��n numerointikoodeja, 
		toisen merkkipaikan koodi on e.)<ul>
		<li><strong>d</strong> - P�iv�</li>
		<li><strong>m</strong> - Kuukausi</li>
		<li><strong>s</strong> - Vuodenaika</li>
		<li><strong>w</strong> - Viikko</li>
		<li><strong>y</strong> - Vuosi</li>
	</ul>
		</li>
		<li><em>Julkaisuaikakoodi</em><br/>
		Ilmaisee kohteen osan, jota merkitty s��nn�llisyystieto koskee. 
		Useammat koodit erotetaan toisistaan pilkulla ja kaksoisnumerot 
		merkit��n kauttaviivalla (/). P�iville, viikoille, kuukausille ja/tai 
		vuodenajoille k�ytet��n kaksimerkkist� kirjain- tai numerokoodia. 
		Vuosille k�ytet��n nelinumeroista koodia. Koodit, joissa on v�hemm�n 
		kuin kaksi merkki� tasataan oikealle ja k�ytt�m�tt�m�ss� merkkipaikassa 
		on nolla.<br/>
		Ks. <a href="esimerkit_julkaisuaika.htm">esimerkit julkaisuaikakoodien 
		k�yt�st�</a>.</li>
		<li><strong><em>Numerointikoodi</em></strong><br/>
		K�ytett�ess� numerointikoodeja, tiedot kootaan seuraavasti:<br/>
		&lt;Julkaisukoodi&gt;&lt;Numerointikoodin 
		m��ritelm�&gt;&lt;Numerointikoodi&gt;&lt;Numerointikoodi&gt;...<br/>
		Numerointikoodia k�ytet��n osakent�n &#8225;y toisessa ja kolmannessa 
		merkkipaikassa kun halutaan merkit� s��nn�llisyyskaava kohteelle, jossa 
		j�rjestys perustuu ainoastaan numerointiin ja/tai kohteille, joissa 
		j�rjestys pit�� m��ritell� erikseen kaksoisnumeroiden kohdalla.</li>
		<li><em>Numerointikoodin m��ritelm�</em><br/>
		Ilmaisevatko m��ritelm�� seuraavat koodit numerointia vai julkaisuaikaa. 
		Kun k�ytet��n koodia e, lis�t��n sen j�lkeen my�s numero ilmaisemaan 
		numerointitasoa jota s��nn�llisyys koskee.<ul>
		<li><strong>e1</strong> - Numerointi, ensimm�inen taso</li>
		<li><strong>e2</strong> - Numerointi, toinen taso</li>
	</ul>
		</li>
		<li><em>Numerointikoodi</em><br/>
		Ilmaisee kohteen numerot, joita merkitty s��nn�llisyystieto koskee. 
		Useammat koodit erotetaan toisistaan pilkulla ja kaksoisnumerot 
		merkit��n kauttaviivalla (/).<br/>
		<br/>
		Numerointikoodin yhteydess� esiintyv� jatkuva numerointi (osakentt� &#8225;v, 
		koodi c) osoittaa kaksoisnumerot tiettyjen numeroiden j�rjestyksess�. 
		Jatkuvan numeroinnin vuoksi todellista numerointia ei voida k�ytt�� 
		osakent�ss� &#8225;y. Numerointiarvot on esitett�v� odotettujen numeroiden 
		m��r�n�, jotta kaksoisnumerot voidaan ennakoida. Automaattisissa 
		j�rjestelmiss� voi olla keinoja ennakoida jatkuvan numeroinnin toinen 
		numerointitaso tilauksen alussa annetun toisen numerointitason 
		l�ht�arvon perusteella.<br/>
		<br/>
		S��nn�llisyyskoodeja yll�pit�� Library of Congress, Network Development and MARC Standards Office. 
		Koodeihin liittyv�t kysymykset osoitetaan sinne:
		<a href="mailto:ndmso@loc.gov">ndmso@loc.gov</a>.<br/>
</li>
	</ul>
		</li>
		<li><strong>&#8225;z</strong> - Numerointi (T)<br/>Kuusimerkkinen koodi, joka kertoo julkaisun numerointisuunnitelman. Koodien 
avulla voidaan tallentaa erilaisia numerointisuunnitelmia eri 
numerointitasoille.<ul>
		<li>Merkinn�n tyyppi<br/>Ensimm�isess� merkkipaikassa kerrotaan onko numerointi merkitty numeroina, 
kirjaimina vai niiden yhdistelm�n� (numero vai kirjain ensin). Koodia c 
(Yhdistelm�) tulee k�ytt�� vain silloin, kun toinen merkinn�n elementeist� on 
pysyv� (esim. 1a, 2a, 3a), ei silloin, kun kyseess� on pikemminkin kaksi eri 
numerointitasoa (esim. 1a, 1b, 1c).<ul>
		<li><strong>a</strong> - Numero</li>
		<li><strong>b</strong> - Kirjain</li>
		<li><strong>c</strong> - Yhdistelm�, numero ensin</li>
		<li><strong>d</strong> - Yhdistelm�, kirjain ensin</li>
		<li><strong>e</strong> - Symboli tai erityismerkki</li>
	</ul>
		</li>
		<li>Aakkoslaji<br/>Toisen merkkipaikan koodi on k�yt�ss�, kun numerointisuunnitelma 
		merkit��n kirjaimin (ensimm�isess� merkkipaikassa on koodi b) tai roomalaisin numeroin.<ul>
		<li><strong>a</strong> - Ei aakkoslajia</li>
		<li><strong>b</strong> - Gemena (pienaakkoset)</li>
		<li><strong>c</strong> - Versaali (suuraakkoset)</li>
		<li><strong>d</strong> - Sekalajinen (k�ytetty sek� versaalia ett� gemenaa)</li>
	</ul>
		</li>
		<li>Merkist�- tai tyyppikoodi<br/>Numerointikaavassa k�ytetty merkist� 
		merkit��n nelimerkkisen� koodina
		<a href="http://www.unicode.org/iso15924/">ISO 15924</a> (<em>Codes for 
		the representation of names of scripts</em>) -standardin mukaisesti. 
		Tyyppikoodi on tarkoitettu numeroille, joita ei ole kirjoitettu 
		vaihtoehtoisilla merkist�ill� ja siten koodattu merkist�koodeilla. 
		Symboleita varten on k�ytett�viss� koodi sy, jota seuraa k�ytetty 
		symboli. Esimerkkej�:<ul>
		<li><u>Merkist�koodeja:</u></li>
		<li><strong>latn</strong> - latina</li>
		<li><strong>arab</strong> - arabia</li>
		<li><strong>grek</strong> - kreikka</li>
		<li><u>Tyyppikoodeja:</u></li>
		<li><strong>an##</strong> - arabialaiset numerot</li>
		<li><strong>rn##</strong> - roomalaiset numerot</li>
		<li><strong>sy&lt;symboli&gt;#</strong> - symboli</li>
	</ul>
		</li>
	</ul>
		</li>
		<li><strong>&#8225;2</strong> - Ilmestymistietojen lyhenteiden l�hde (T)<br/>
		Koodi otetaan listalta, ks. <em>
		<a href="http://www.loc.gov/marc/relators/relahome.html">MARC Code Lists 
		for Relators, Sources, and Description Conventions</a></em>.</li>
		<li><strong>&#8225;3</strong> - Aineiston osa, jota tiedot koskevat (ET)<br/>
		M��rittelee volyymi- tai aikav�lin, jota kent�n tiedot koskevat.</li>
		<li><strong>&#8225;6</strong> - Linkitys (ET) ks. <em><a href="kontrolliosakentat.htm#6">Kontrolliosakent�t</a></em></li>
		<li><strong>&#8225;8</strong> - Linkki- ja j�rjestysnumero (T) <em>ks. 
		<a href="kontrolliosakentat.htm#8">Kontrolliosakent�t</a></em></li>
	</ul>
<h3>Tiivist�misen ja laajentamisen vaatimukset</h3>
<p>Varastotietojen pit�� t�ytt�� seuraavat ehdot, jotta ne voidaan 
automaattisesti tiivist�� tai laajentaa.</p>
<ul>
	<li><em>Nimi�/17 Koodaustaso</em><br/>
	<strong>Tiivist�minen</strong> voidaan tehd� varastotiedoille, joiden koodaustaso on 4 
	tai 5.<br/>
	<strong>Laajentaminen</strong> voidaan tehd� varastotiedoille, joiden koodaustaso on 
	3, 4 tai 5.<br/>
</li>
	<li><em>Ilmestymistietojen ja varastotietojen vastaavuussuhde kentiss� 
	853/854 ja 863/864</em><br/>
	<strong>Tiivist�minen ja laajentaminen</strong> edellytt�v�t, ett� selosteosakent�t 
	(&#8225;a-&#8225;m) on tallennettu ilmestymistietojen kenttiin (853/854) ja niit� 
	vastaavat numerointi- ja julkaisuaikatasot on tallennettu niihin 
	linkitettyihin varastotietojen kenttiin (863/864).<br/>
</li>
	<li><em>Julkaisukaavaosakent�t &#8225;u-&#8225;y</em><br/>
	Kun kenttiin 863 tai 864 on merkitty vain korkein numerointitaso 
	(osakent�t &#8225;a, &#8225;g, &#8225;i, &#8225;m), tiivist�minen tai laajentaminen ei edellyt� 
	julkaisukaavaan liittyvi� osakentti� kentiss� 853 tai 854. Kun seuraavia 
	tasoja on merkitty, tiivist�minen tai laajentaminen edellytt�� 
	asiaankuuluvat julkaisukaavaan liittyv�t tiedot seuraaviin osakenttiin:<ul>
		<li><strong>&#8225;u</strong> - Kuvailtavan numerointitason sis�lt�mien bibliografisten 
		yksik�iden m��r�</li>
		<li><strong>&#8225;v</strong> - Numeroinnin jatkuvuus</li>
		<li><strong>&#8225;w</strong> - Ilmestymistiheys</li>
		<li><strong>&#8225;x</strong> - Kalenterin vaihtuminen</li>
		<li><strong>&#8225;y</strong> - S��nn�llisyys</li>
	</ul>
	</li>
</ul>
<blockquote>
	<p>Osakenttien &#8225;a-&#8225;m <strong>tiivist�minen</strong> kentiss� 863-864 edellytt�� 
	tietoja osakentiss� &#8225;u ja &#8225;v. Osakent�ss� &#8225;u ei saa olla koodia var 
	(Vaihtelee) tai und (M��rittelem�t�n).<br/>
	Osakenttien &#8225;a-&#8225;m <strong>laajentaminen</strong> kentiss� 863-864 edellytt�� tietoja 
	osakentiss� &#8225;u, &#8225;v ja &#8225;w ja mahdollisesti my�s osakentiss� &#8225;x ja &#8225;y.</p>
</blockquote>
<h3>J�rjestysluvut</h3>
<p>Kun halutaan osoittaa ett� j�rjestyslukujen pit�� n�ky� n�yt�ss�, selosteen 
eteen voidaan tallentaa plus-merkki (+). Jos selostetta ei ole tallennettu, 
plus-merkki voidaan tallentaa yksin��n, jolloin vastaava 863 osakentt� n�ytet��n 
j�rjestyslukuna.</p>
<p><strong>853 03&#8225;8</strong>1<strong>&#8225;a</strong>(year)<strong>&#8225;b</strong>+qtr.<br/>
<strong>863 40&#8225;8</strong>1.1<strong>&#8225;a</strong>1982<strong>&#8225;b</strong>1</p>
<p><strong>853 03&#8225;8</strong>1<strong>&#8225;a</strong>+<br/>
<strong>863 40&#8225;8</strong>1.1<strong>&#8225;a</strong>1</p>
<p>Huom, edell� kuvattu tekniikka j�rjestys- ja p��lukujen erottamiselle ei ole 
pakollista, eik� erottelua tarvitse tehd�. J�rjestelm�ss� tarvitaan sis�iset 
kielitaulukot, jos j�rjestysluvut halutaan n�ytt�� oikein. Varastotietojen 
formaatissa ei ole ohjeita taulukoiden toteutukseen.</p>
<p><a href="#alku">Sivun alkuun</a></p>
<hr/>
  </xsl:template>

  <xsl:template name="yleista863">
<h3><a name="yleista"></a>M��R�MUOTOISET VARASTOTIEDOT--YLEIST� TIETOA</h3>
<p>Kent�t 863-865 sis�lt�v�t omistajaorganisaation tekem�n kuvauksen 
kokoelmiinsa sis�ltyv�n bibliografisen kohteen varastotiedoista.</p>
<p>Selosteet, joiden avulla tunnistetaan kohteen numerointi- ja 
julkaisuaikatasot, sek� koodit, jotka m��rittelev�t varastotietojen 
julkaisukaavan sis�ltyv�t ilmestymistietojen kenttiin (853-855), jotka 
linkitet��n niihin liittyviin 863-865 kenttiin osakentt��n &#8225;8 (Linkki- ja 
j�rjestysnumero) tallennetun numeron avulla.</p>
<p>Yleinen kuvaus varastotietokenttien nelj�st� eri tyypist� ja niiden suhteista 
toisiinsa l�ytyy osiosta <em><a href="yleista.htm">Varastotiedot--Yleist� tietoa</a></em>.<br/>
Varastotietojen automaattisessa tiivist�misess� tai laajentamisessa tarvittavat tietoelementit on kuvattu osiossa <em><a href="853-855.htm#yleista">Ilmestymistiedot--yleist� tietoa</a></em>.<br/>
Kuvaus tietojen tiivistett�vyydest� ja laajennettavuudesta annetaan osiossa <em>
<a href="yleista.htm#tiivistys">Varastotiedot--Yleist� tietoa</a></em>.</p>
<h3>Indikaattorit</h3>
<ul>
	<li>Ensimm�inen - Kent�n koodaustaso<br/>M��rittelee ISO 10324 (ANSI/NISO Z39.71) 
	tai ANSI Z39.42 -standardin mukaisen tarkkuustason, jota kent�n koodauksessa on noudatettu.<ul>
		<li><strong>#</strong> - Tieto puuttuu</li>
		<li><strong>3</strong> - Taso 3 <em>[863/864]</em><br/>Kentt� sis�lt�� joko bibliografista 
perusyksikk�� (863) tai oheisaineistoa (864) koskevat tiivistetyt numerointi- ja 
julkaisuaikatiedot (vain ensimm�isest� tasosta).</li>
		<li><strong>4</strong> - Taso 4<br/>Kentt� sis�lt�� tiivist�m�tt�m�t numerointi- ja 
julkaisutiedot (sek� ensimm�isest� ett� sit� seuraavista tasoista).</li>
		<li><strong>5</strong> - Taso 4 lis�ttyn� kappaleen tunnistustiedoilla<br/>Kentt� sis�lt�� 
sek� tiivist�m�tt�m�t varastotiedot ett� fyysisen kappaleen (esim. 
		osa/volyymi/nide) tunnistustiedot 
osakent�ss� &#8225;p (Kappaleen tunnistus).</li>
	</ul>
	</li>
	<li>Toinen - Varastotietojen muoto<br/>Merkit��nk� varastotiedot tiivistetyss� vai tiivist�m�tt�m�ss� muodossa ja 
pit�isik� n�yt�n muodostamiseen k�ytt�� t�t� m��r�muotoista varastotietojen 
kentt�� vai vastaavaa vapaamuotoisten varastotietojen kentt��.<ul>
		<li><strong>#</strong> - Tieto puuttuu</li>
		<li><strong>0</strong> - Tiivistetty <em>[863/864]</em></li>
		<li><strong>1</strong> - Tiivist�m�t�n</li>
		<li><strong>2</strong> - Tiivistetty, n�yt�n muodostamiseen k�ytett�v� vapaamuotoisia 
varastotietoja <em>[863/864]</em></li>
		<li><strong>3</strong> - Tiivist�m�t�n, n�yt�n muodostamiseen k�ytett�v� vapaamuotoisia 
varastotietoja</li>
		<li><strong>4</strong> - Kohdetta/kohteita ei ole julkaistu <em>[863/864]</em></li>
	</ul>
	</li>
</ul>
<h3>Osakentt�koodit</h3>
<p><strong>&#8225;a-&#8225;h</strong> - Numerointi<br/>
Numeroinnin tasot, jotka joko n�kyv�t kohteessa tai varastotietojen tallentaja on k�ytt�nyt 
niit� ilmestymistietojen m��rittelyss�. N�m� osakent�t ovat vastaavuussuhteessa kenttien 
853-855 osakenttiin &#8225;a-&#8225;h (selosteet), joskaan k�ytettyjen osakenttien ei tarvitse olla 
samat. T�ydellist� vastaavuutta ei tarvita, kun numerointitasojen selosteita ei 
haluta k�ytt�� n�yt�iss�. Sen sijaan osakenttien on vastattava toisiaan 
t�ydellisesti, kun kent�n 863 tai 864 tiedot halutaan tiivist�� tai laajentaa 
automaattisesti. T�ll�in mahdollinen puuttuva numerointi voidaan keksi� ja 
merkit� hakasulkeisiin ([ ]).</p>
<p>Kun kohteeseen soveltuu vaihtoehtoisia numerointeja, ne 
	merkit��n osakenttiin &#8225;g ja &#8225;h. Jos vaihtoehtoisia numerointitasoja on 
	enemm�n kuin kaksi, k�ytet��n kentti� 866-868 (Vapaamuotoiset varastotiedot).</p>
<p>Kun k�ytet��n vain julkaisuaikatasoja (kohteessa ei ole numerointia), niit� 
ei merkit� osakenttiin &#8225;i-&#8225;m, vaan ne merkit��n asianomaisiin osakenttiin &#8225;a-&#8225;h.</p>
	<ul>
		<li><strong>&#8225;a</strong> - Ensimm�inen numerointitaso (ET)</li>
		<li><strong>&#8225;b</strong> - Toinen numerointitaso (ET)</li>
		<li><strong>&#8225;c</strong> - Kolmas numerointitaso (ET)</li>
		<li><strong>&#8225;d</strong> - Nelj�s numerointitaso (ET)</li>
		<li><strong>&#8225;e</strong> - Viides numerointitaso (ET)</li>
		<li><strong>&#8225;f</strong> - Kuudes numerointitaso (ET)</li>
		<li><strong>&#8225;g</strong> - Vaihtoehtoinen numerointi, ensimm�inen numerointitaso (ET)</li>
		<li><strong>&#8225;h</strong> - Vaihtoehtoinen numerointi, toinen numerointitaso (ET)</li>
	</ul>
<p><strong>&#8225;i-&#8225;m</strong> - Julkaisuaika<br/>
Julkaisuaikojen hierarkkiset tasot, jotka joko n�kyv�t kohteessa tai 
tallentajaorganisaatio on k�ytt�nyt niit� ilmestymistietojen m��rittelyss�. N�m� 
osakent�t ovat vastaavuussuhteessa kenttien 853-855 osakenttiin &#8225;i-&#8225;m 
(selosteet), joskaan k�ytettyjen osakenttien ei tarvitse olla samat. T�ydellist� 
vastaavuutta ei tarvita, kun julkaisuaikatasojen selosteita ei haluta k�ytt�� 
n�yt�iss�. Sen sijaan osakenttien on vastattava toisiaan t�ydellisesti, kun 
kent�n 863 tai 864 tiedot halutaan tiivist�� tai laajentaa automaattisesti. 
T�ll�in yleens� puuttuvat julkaisuaikatasojen selosteet voidaan keksi� ja 
merkit� hakasulkeisiin ([ ]).</p>
<p>Kuukaudet ja vuodenajat voidaan merkit� joko luonnollisella kielell� tai 
seuraavilla koodeilla:</p>
<ul>
	<li><u>Kuukausi:</u><ul>
		<li>01-12 - Kuukausi</li>
	</ul>
	</li>
	<li><u>Vuodenaika:</u><ul>
		<li>21 - Kev�t</li>
		<li>22 - Kes�</li>
		<li>23 - Syksy</li>
		<li>24 - Talvi</li>
	</ul>
	</li>
</ul>
<p>Kuukausikoodi tasataan oikealle ja k�ytt�m�tt�m�ss� merkkipaikassa on nolla.</p>
<p>Kun kohteeseen soveltuu vaihtoehtoinen julkaisuaika, se 
	merkit��n osakentt��n &#8225;m. Jos vaihtoehtoisia julkaisuaikatasoja on useita, 
	k�ytet��n kentti� 866-868 (Vapaamuotoiset varastotiedot).</p>
<p>Kun k�ytet��n vain julkaisuaikatasoja (kohteessa ei ole numerointia), niit� 
ei merkit� osakenttiin &#8225;i-&#8225;m, vaan ne merkit��n asianomaisiin osakenttiin &#8225;a-&#8225;h.</p>
	<ul>
		<li><strong>&#8225;i</strong> - Ensimm�inen julkaisuaikataso (ET)</li>
		<li><strong>&#8225;j</strong> - Toinen julkaisuaikataso (ET)</li>
		<li><strong>&#8225;k</strong> - Kolmas julkaisuaikataso (ET)</li>
		<li><strong>&#8225;l</strong> - Nelj�s julkaisuaikataso (ET)</li>
		<li><strong>&#8225;m</strong> - Vaihtoehtoinen numerointi, julkaisuaikataso (ET)<br/>
</li>
		<li><strong>&#8225;n</strong> - Muunnettu gregoriaaninen vuosiluku (ET)<br/>Jos osakentiss� &#8225;i-&#8225;m annettu vuosiluku ei ole gregoriaanisen ajanlaskun 
mukainen, t�h�n osakentt��n tallennetaan sama vuosiluku muunnettuna 
gregoriaanisen ajanlaskun mukaiseksi.</li>
		<li><strong>&#8225;o</strong> - Oheisaineiston nimeke (ET) <em>[864]</em><br/>Esim. Ostajan opas. Kun osakentt�� &#8225;o k�ytet��n, se seuraa v�litt�m�sti sit� 
numerointia, johon se liittyy. Jos oheisaineiston nimeke on sama kuin seloste 
kent�n 854 osakent�ss� &#8225;o (Oheisaineiston tyyppi), nimekett� ei tallenneta 
kentt��n 864.</li>
		<li><strong>&#8225;o</strong> - Hakemiston nimeke (ET) <em>[865]</em><br/>Esim. Aihehakemisto. Kun osakentt�� &#8225;o k�ytet��n, se seuraa v�litt�m�sti sit� 
numerointia, johon se liittyy. Jos hakemiston nimeke on sama kuin seloste kent�n 
855 osakent�ss� &#8225;o (Hakemiston tyyppi), nimekett� ei tallenneta kentt��n 865.</li>
		<li><strong>&#8225;p</strong> - Kappaleen tunnistus (ET)<br/>Kappaleen (esim. 
		osa/volyymi/nide) tunnistustiedot, esim. viivakoodi- tai hankintanumero. 
Tunnistustietoja voi edelt�� joko versaali B tai versaali U merkitsem�ss� onko 
		kappaleet sidottu (B=bound) vai sitomattomia (U=unbound). Osakentt��n &#8225;p 
		voidaan merkit� my�s kaksi kauttaviivaa (//) merkitsem��n sit�, ett� 
		varastotiedot ovat kappalekohtaisia.<br/>
		Kun kappaletiedot koskevat koko varastotietojen merkint��, ne 
		tallennetaan kent�n 852 (Sijainti) osakentt��n &#8225;p (Kappaleen tunnistus). 
		Kun kappaleen tiedot koskevat numerointia ja julkaisuaikaa, ne merkit��n 
		kenttiin 863-865. Kun kappaleen tiedot ovat p�tevi� ainoastaan 
		kappaletasolla, ne tallennetaan kappaletietojen kenttien (876-878) 
		osakentt��n &#8225;p.</li>
		<li><strong>&#8225;q</strong> - Kappaleen fyysinen kunto (ET)<br/>
		Kun kappaleen fyysist� kuntoa kuvaava tieto koskee koko varastotietojen 
		merkint��, se tallennetaan kent�n 852 (Sijainti) osakentt��n &#8225;q 
		(Kappaleen fyysinen kunto). S�ilytt�mistoimenpiteisiin vaikuttavat 
		fyysist� kuntoa koskevat tiedot tallennetaan kentt��n 583 (Huomautus 
		toimenpiteist�).</li>
		<li><strong>&#8225;s</strong> - Artikkelin tekij�noikeusmaksun koodi (T)<br/>
		Ks. bibliografisen formaatin kentt�
		<a href="../bib/01X-04X.htm#018">018</a>.</li>
		<li><strong>&#8225;t</strong> - Kappaleen numero (ET)<br/>
		Yksitt�isen kappaleen numero, tai numerov�li kappaleille, joilla on sama 
		sijainti ja luokitus.</li>
		<li><strong>&#8225;v</strong> - Julkaisuvuosi (T) <em>[865]</em></li>
		<li><strong>&#8225;w</strong> - Puutemerkinn�n tyyppi (ET)<br/>Osoittaa varastotiedoissa 
		olevan aukon syyn.<ul>
		<li><strong>g</strong> - Osia puuttuu<br/>Olemassa olevia osia puuttuu. K�ytet��n my�s kun aukon syy on ep�varma 
		tai tuntematon.</li>
		<li><strong>n</strong> - Osia ei ole julkaistu<br/>Puuttuvaa(ia) osaa(ia) ei ole julkaistu lainkaan tai ilmestymistiedot 
		hypp��v�t puuttuva(ie)n osa(ie)n yli.</li>
	</ul>
		</li>
		<li><strong>&#8225;x</strong> - Sis�inen huomautus (T)</li>
		<li><strong>&#8225;z</strong> - Julkinen huomautus (T)</li>
		<li><strong>&#8225;6</strong> - Linkitys (ET) ks. <em><a href="kontrolliosakentat.htm#6">Kontrolliosakent�t</a></em></li>
		<li><strong>&#8225;8</strong> - Linkki- ja j�rjestysnumero (T) <em>ks. 
		<a href="kontrolliosakentat.htm#8">Kontrolliosakent�t</a></em></li>
	</ul>
<p><a href="#alku">Sivun alkuun</a></p>
<hr/>
  </xsl:template>

  <xsl:template name="yleista866">
<h3><a name="yleista"></a>VAPAAMUOTOISET VARASTOTIEDOT--YLEIST� TIETOA</h3>
<p>Kent�t 866-868 sis�lt�v�t vapaamuotoisia varastotietoja, joissa voi olla 
mukana sek� selosteita ett� numerointi- ja julkaisuaikatietoja. N�it� kentti� 
k�ytet��n yleens� yksiosaisten monografioiden varastotietojen merkitsemiseen, 
tai moniosaisten monografioiden tai kausijulkaisujen kohdalla silloin, kun 
ilmestymistietojen (853-855) ja m��r�muotoisten varastotietojen kent�t (863-865) 
eiv�t sovellu niiden varastotietojen kuvailemiseen. Kentti� 866-868 voidaan 
k�ytt�� m��r�muotoisten varastotietokenttien tai ilmestymistietojen kenttien 
lis�ksi, kun niist� kaikista tai osasta niist� halutaan muodostaa vaihtoehtoisia 
n�ytt�j�.</p>
<p>Yleinen kuvaus varastotietojen nelj�st� eri kentt�ryhm�st�, niiden suhteista 
toisiinsa ja niiden toistettavuudesta l�ytyy osiosta <em><a href="yleista.htm">
Varastotiedot--yleist� tietoa</a></em>.<br/>
Ohjeet siit�, miten tallennetaan 866-868 
kenttiin liittyvi� kappalekohtaisia tietoja, l�ytyy osiosta <em>
<a href="876-878.htm#yleista">Kappalekohtaiset tiedot--yleist� tietoa</a></em>.</p>
<h4>Indikaattorit</h4>
<ul>
	<li>Ensimm�inen - Kent�n koodaustaso<br/>M��rittelee kentt��n merkittyjen 
	numerointi- ja julkaisuaikatietojen tarkkuustason.<ul>
		<li><strong>#</strong> - Tieto puuttuu</li>
		<li><strong>3</strong> - Taso 3<br/>Kentt� sis�lt�� tiivistetyt numerointi- ja 
julkaisuaikatiedot (vain ensimm�isest� tasosta).</li>
		<li><strong>4</strong> - Taso 4<br/>Kentt� sis�lt�� tiivist�m�tt�m�t numerointi- ja 
julkaisutiedot (sek� ensimm�isest� ett� sit� seuraavista tasoista).</li>
		<li><strong>5</strong> - Taso 4 lis�ttyn� kappaleen tunnistustiedoilla<br/>Kentt� sis�lt�� 
sek� tiivist�m�tt�m�t varastotiedot ett� fyysisen kappaleen tunnistusnumeron 
osakent�ss� &#8225;a (Tiedot tekstin�).</li>
	</ul>
	</li>
	<li>Toinen - Merkint�tavan tyyppi<br/>
	Onko osakent�n &#8225;a varastotiedot tallennettu jonkin standardoidun vai 
	standardoimattoman merkint�tavan mukaan.<ul>
		<li><font color="#FF0000"><strong># - </strong>M��rittelem�t�n/ei koodattu - 
		suomalainen koodi</font></li>
		<li><strong>0</strong> - Standardoimaton</li>
		<li><strong>1</strong> - ISO 10324 (ANSI/NISO Z39.71)</li>
		<li><strong>2</strong> - ANSI Z39.42</li>
		<li><strong>7</strong> - Merkint�tapa m��ritell��n osakent�ss� &#8225;2</li>
	</ul>
	</li>
</ul>
<h4>Osakentt�koodit</h4>
<ul>
	<li><strong>&#8225;a</strong> - Tiedot tekstin� (ET)<br/>
	Varastotiedot tekstimuodossa, joko kenttien 853-855 ja 863-865 sijasta tai 
	niiden lis�ksi.</li>
	<li><strong>&#8225;x</strong> - Sis�inen huomautus (T)</li>
	<li><strong>&#8225;z</strong> - Julkinen huomautus (T)</li>
	<li><strong>&#8225;2</strong> - Merkint�tavan l�hde (ET)</li>
	<li><strong>&#8225;6</strong> - Linkitys (ET) ks. <em><a href="kontrolliosakentat.htm#6">Kontrolliosakent�t</a></em></li>
	<li><strong>&#8225;8</strong> - Linkki- ja j�rjestysnumero (T) <em>ks. 
	<a href="kontrolliosakentat.htm#8">Kontrolliosakent�t</a></em></li>
</ul>
<p><a href="#alku">Sivun alkuun</a></p>
<hr/>
  </xsl:template>

  <xsl:template name="yleista876">
<h3><a name="yleista"></a>KAPPALETIEDOT--YLEIST� TIETOA</h3>
<p>Kent�t 876-878 sis�lt�v�t kappaletason tietoja varastotietueessa 
tarkoitetusta kohteesta. Kent�t sis�lt�v�t monia erilaisia tietoelementtej�, 
jota voivat olla k�ytt�kelpoisia mm. hankinnassa tai lainauksessa.</p>
<h3>Kappaletietojen linkitt�minen kohteeseen, jota varastotiedot koskevat</h3>
<h4>Kohteessa, jota varastotiedot koskevat, on yksi fyysinen osa:</h4>
<blockquote>
	<p><em>Yksi kappale, yksi 852 kentt�</em><br/>
	Kappaletietojen kentiss� ei tarvita linkitysosakentti�, koska kaikki tiedot 
	liittyv�t yhteen varastotietojen kohteeseen. (Varastotiedot on tallennettu 
	tasolla 1 tai 2 nimi�n merkkipaikassa 17.)</p>
	<p><em>Useita kappaleita, yksi tai useampia 852 kentti�</em><br/>
	Osakentt�� &#8225;3 k�ytet��n linkitt�m��n kappaletiedot niihin liittyv�n 
	kappaleen 852 kentt��n/kenttiin. (Varastotiedot on tallennettu tasolla 1 tai 
	2 nimi�n merkkipaikassa 17.)</p>
</blockquote>
<h4>Kohteessa, jota varastotiedot koskevat, on useita fyysisi� osia:</h4>
<blockquote>
	<p><em>Vapaamuotoiset varastotiedot kentiss� 866-868</em><br/>
	Osakentt�� &#8225;3 k�ytet��n linkitt�m��n kappaletiedot niihin liittyv�n osan 
	tietoihin kentiss� 866-868. (Varastotiedot on tallennettu tasolla 3 tai 4 
	nimi�n merkkipaikassa 17.)</p>
	<p><em>M��r�muotoiset varastotiedot kentiss� 863-865</em><br/>
	Osakentt�� &#8225;8 k�ytet��n linkitt�m��n kappaletiedot niihin liittyv�n osan 
	tietoihin kentiss� 863-865. Jokainen osa (volyymi tai volyymit) johon 
	sis�llytet��n kappaletason tietoja, vaatii erillisen 863-865 kent�n. 
	(Varastotiedot on tallennettu tasolla 3 tai 4 nimi�n merkkipaikassa 17.)</p>
</blockquote>
<h4>Bibliografiseen tietueeseen sis�llytetyt varastotiedot:</h4>
<p>Kun varastotiedot sis�llytet��n 
bibliografiseen MARC-tietueeseen, useita 876-878 kentti� voidaan k�ytt�� vain 
silloin, kun varastotiedot eiv�t sis�ll� muita kentti�, jotka pit�isi linkitt�� 
johonkin kentist� 876-878. Kun linkityst� tarvitaan, vain yksi 876-878 kentt� ja 
siihen liittyv�t varastotietojen kent�t voidaan sis�llytt�� bibliografiseen 
tietueeseen. Muista 876-878 kentist� ja niihin liittyvist� kentist� t�ytyy tehd� 
erilliset varastotietueet.</p>
<p>Kuitenkin, bibliografisessa tietueessa voi olla useita 852 kentti� ja niihin 
liittyvi� 876-878 kentti�, joissa m��ritell��n joko kappaleen numero osakent�ss� 
&#8225;t tai aineiston osa, jota tiedot koskevat osakent�ss� &#8225;3.</p>
<h4>Indikaattorit</h4>
<ul>
	<li>Ensimm�inen - M��rittelem�t�n<ul>
		<li><strong>#</strong> - M��rittelem�t�n</li>
	</ul>
	</li>
	<li>Toinen - M��rittelem�t�n<ul>
		<li><strong>#</strong> - M��rittelem�t�n</li>
	</ul>
	</li>
</ul>
<h4>Osakentt�koodit</h4>
<ul>
	<li><strong>&#8225;a</strong> - Kohteen sis�inen numero (ET)<br/>Uniikki identifikaationumero 
	kohteelle.</li>
	<li><strong>&#8225;b</strong> - Virheellinen tai peruttu kohteen sis�inen numero. (T)</li>
	<li><strong>&#8225;c</strong> - Kustannus (T)<br/>Hinta tai kohteen korvaamisen kustannus. 
	Kustannuksen laatu voidaan merkit� sulkeisiin, esim. normaali, alennettu.</li>
	<li><strong>&#8225;d</strong> - Hankinta-aika (T)<br/>Kohteen hankintap�iv� ISO 8601 (<em>Representations of Dates 
	and Times</em>) -standardin mukaisessa muodossa <em>vvvvkkpp</em>. Jos 
	p�iv�ykseen liittyy kustannus, osakentt� &#8225;d seuraa sit� osakentt�� &#8225;c, johon 
	se liittyy.</li>
	<li><strong>&#8225;e</strong> - Hankintapaikka (T)</li>
	<li><strong>&#8225;h</strong> - K�ytt�rajoitukset (T)<br/>Tietoja mist� tahansa kappaleen 
	k�ytt�� koskevista rajoituksista. T�t� osakentt�� k�ytet��n tiedoille, jotka 
	ovat liian kappalekohtaisia voidakseen sopia bibliografisen tietueen 
	kentt��n 506 (Huomautus k�ytt�rajoituksista).</li>
	<li><strong>&#8225;j</strong> - Kappaleen tila (T)<br/>
	Tietoa kappaleen tilasta, esim. kadonnut tai poistettu.</li>
	<li><strong>&#8225;l</strong> - V�liaikainen sijainti (T)<br/>
	Pysyv��n, kent�ss� 852 merkittyyn sijaintiin liittyv�� tietoa tilap�isest� 
	sijainnista.</li>
	<li><strong>&#8225;p</strong> - Kappaleen tunnistus (T)<br/>
	Kappaleen (esim. osa/volyymi/nide) tunnistustiedot, esim. viivakoodi- tai 
	hankintanumero.</li>
	<li><strong>&#8225;r</strong> - Virheellinen tai peruttu kappaleen tunnistus (T)</li>
	<li><strong>&#8225;t</strong> - Kappaleen numero (ET)</li>
	<li><strong>&#8225;x</strong> - Sis�inen huomautus (T)</li>
	<li><strong>&#8225;z</strong> - Julkinen huomautus (T)</li>
	<li><strong>&#8225;3</strong> - Aineiston osa, jota tiedot koskevat (ET)</li>
	<li><strong>&#8225;6</strong> - Linkitys (ET) ks. <em><a href="kontrolliosakentat.htm#6">Kontrolliosakent�t</a></em></li>
	<li><strong>&#8225;8</strong> - Linkki- ja j�rjestysnumero (T) <em>ks. 
	<a href="kontrolliosakentat.htm#8">Kontrolliosakent�t</a></em></li>
</ul>
<p><a href="#alku">Sivun alkuun</a></p>
<hr/>
  </xsl:template>

  <xsl:template name="example-description">
    <blockquote>
	  <p><i><xsl:value-of select="description"/></i></p>
    </blockquote>
  </xsl:template>

  <xsl:template match="terminology">
    <p><xsl:value-of select="description"/>:</p>
    <xsl:for-each select="term">
    <p><a name="{@id}"></a><strong><xsl:value-of select="name"/></strong> - <xsl:value-of select="description"/></p>
	</xsl:for-each>
  </xsl:template>

  <xsl:template match="a">
    <xsl:variable name="href">
      <xsl:call-template name="replace_all">
        <xsl:with-param name="result" select="@href"/>
        <xsl:with-param name="src" select="'.xml'"/>
        <xsl:with-param name="dest" select="'.htm'"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:choose><xsl:when test="@type"></xsl:when><xsl:otherwise><xsl:value-of select="@tag"/></xsl:otherwise></xsl:choose>
    <a href="{$href}"><xsl:apply-templates/></a></xsl:template>

  <xsl:template match="em">
    <em><xsl:apply-templates/></em>
  </xsl:template>

  <xsl:template match="br">
    <br/>
  </xsl:template>

  <xsl:template match="strong">
    <strong><xsl:apply-templates/></strong>
  </xsl:template>

  <xsl:template name="capitalize">
    <xsl:param name="str"/>
    <xsl:value-of select="translate($str, 'abcdefghijklmnopqrstuvwxyz���', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ���')"/>
  </xsl:template>

  <xsl:template name="replace_all">
    <xsl:param name="result"/>
    <xsl:param name="src"/>
    <xsl:param name="dest"/>
    <xsl:choose>
      <xsl:when test="contains($result, $src)">
        <xsl:value-of select="concat(substring-before($result, $src), $dest)"/>
        <xsl:call-template name="replace_all">
          <xsl:with-param name="result" select="substring-after($result, $src)"/>
          <xsl:with-param name="src" select="$src"/>
          <xsl:with-param name="dest" select="$dest"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$result"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
