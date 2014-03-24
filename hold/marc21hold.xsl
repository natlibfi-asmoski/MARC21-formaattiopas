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
Päivitetty viimeksi <xsl:value-of select="."/>.<br/>
Ks. <a href="../ohje.htm">Ohjeita formaattien kommentointiin</a>.</span></i></p>
  </xsl:template>

  <xsl:template match="leader-directory">
<h2 align="left"><xsl:value-of select="title"/></h2>
<p><a href="index.htm">Varastotiedot-etusivulle</a> |
<a href="../index.htm">MARC 21 -etusivulle</a></p>
<hr />

<ul>
	<li><a href="#nimio">NIMIÖ</a></li>
	<li><a href="#hakemisto">HAKEMISTO</a></li>
</ul>

<hr />
    <xsl:apply-templates select="leader|directory"/>
  </xsl:template>

  <xsl:template match="leader">
    <h3><a name="nimio"></a>NIMIÖ</h3>
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
          <li><a href="#yleista">ILMESTYMISTIEDOT--YLEISTÄ TIETOA</a></li>
        </xsl:when>
        <xsl:when test="@tag='863'">
          <li><a href="#yleista">MÄÄRÄMUOTOISET VARASTOTIEDOT--YLEISTÄ TIETOA</a></li>
        </xsl:when>
        <xsl:when test="@tag='866'">
          <li><a href="#yleista">VAPAAMUOTOISET VARASTOTIEDOT--YLEISTÄ TIETOA</a></li>
        </xsl:when>
        <xsl:when test="@tag='876'">
          <li><a href="#yleista">KAPPALETIEDOT--YLEISTÄ TIETOA</a></li>
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
    <li><xsl:choose><xsl:when test="@num='1'">Ensimmäinen</xsl:when><xsl:when test="@num='2'">Toinen</xsl:when></xsl:choose> - <xsl:apply-templates select="description"/>
    <ul>
    <xsl:for-each select="values/value"><li><strong><xsl:value-of select="@code"/></strong> - <xsl:apply-templates select="description"/>
    </li>
    </xsl:for-each>
    </ul>
    </li>
  </xsl:template>

  <xsl:template match="subfields">
    <h4>Osakenttäkoodit</h4>
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
    <h4>Soitinten ja äänialojen MARC 21 -koodit</h4>
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
    <h4><xsl:choose><xsl:when test="count(example)=1">Esimerkki</xsl:when><xsl:otherwise>Esimerkkejä</xsl:otherwise></xsl:choose></h4>

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
<h3><a name="yleista"></a>ILMESTYMISTIEDOT--YLEISTÄ TIETOA</h3>
<p>Kentät 853-855 sisältävät selosteita, joiden avulla tunnistetaan 
kohteen numerointi- ja julkaisuaikatasot, sekä koodeja, jotka määrittelevät kentissä 
863-865 kuvattujen varastotietojen 
julkaisukaavan. Kenttien 853-855 ja 863-865 toisiinsa liittyvät esiintymät  
linkitetään toisiinsa numerolla osakentässä &#8225;8 (Linkki- ja järjestysnumero).</p>
<p>Yleinen kuvaus varastotietojen neljästä eri kenttäryhmästä, niiden suhteista 
toisiinsa ja niiden toistettavuudesta löytyy osiosta <em><a href="yleista.htm">
Varastotiedot--yleistä tietoa</a></em>.</p>
<h3>Indikaattorit</h3>
<ul>
	<li>Ensimmäinen - Tiivistettävyys ja laajennettavuus <em>[853/854]</em><br/>
	Kentissä 853 ja 854 tällä arvolla ilmaistaan voidaanko näihin liittyvien 
	määrämuotoisten varastotietokenttien osakenttien &#8225;a-&#8225;m tiedot muuntaa 
	automaattisesti joko kappalekohtaisesta väliksi, joka ilmaisee samat 
	varastotiedot näyttämällä vain ensimmäisen ja viimeisen osan tiedot tai 
	tiivistetystä &quot;ensimmäinen-viimeinen&quot; -välistä selkeäksi merkinnöksi, 
	joka listaa jokaisen osan erikseen.<ul>
		<li><strong>0</strong> - Ei voida tiivistää tai laajentaa</li>
		<li><strong>1</strong> - Voidaan tiivistää, mutta ei laajentaa</li>
		<li><strong>2</strong> - Voidaan tiivistää tai laajentaa</li>
		<li><strong>3</strong> - Tuntematon</li>
		</ul>
	</li>
	<li>Ensimmäinen - Määrittelemätön <em>[855]</em><ul>
		<li><strong>#</strong> - Määrittelemätön</li>
	</ul>
	</li>
	<li>Toinen - Selostetietojen luotettavuus <em>[853/854]</em><br/>
	Kentissä 853 ja 854 tällä arvolla ilmaistaan 
	selosteissa annettujen tietojen täydellisyys 
	suhteessa määrämuotoisten varastotietojen eri tasoihin (&#8225;a-&#8225;m), 
	sekä niiden näkyminen bibliografisessa kohteessa.<ul>
		<li><strong>0</strong> - Tasojen selosteet tarkistettu, kaikki tasot 
		löytyvät kohteesta</li>
		<li><strong>1</strong> - Tasojen selosteet tarkistettu, tasoja voi puuttua 
		kohteesta</li>
		<li><strong>2</strong> - Tasojen selosteet tarkistamatta, kaikki tasot 
		löytyvät kohteesta</li>
		<li><strong>3</strong> - Tasojen selosteet tarkistamatta, tasoja voi puuttua 
		kohteesta</li>
	</ul>
	</li>
	<li>Toinen - Määrittelemätön <em>[855]</em><ul>
		<li><strong>#</strong> - Määrittelemätön</li>
	</ul>
	</li>
	</ul>
<h3>Osakenttäkoodit</h3>
<p><strong>&#8225;a-&#8225;h</strong> - Numerointitasojen selosteet</p>
	<p>Kentissä 863-865 ja 853-855 osakentät &#8225;a-&#8225;h ovat vastaavuussuhteessa 
	toisiinsa, joskaan käytettyjen osakenttien ei tarvitse olla samat. 
	Täydellistä vastaavuutta ei tarvita, kun numerointitasojen selosteita ei haluta käyttää näytöissä. 
	Sen sijaan osakenttien on vastattava toisiaan täydellisesti, kun kentän 863 tai 864 
	tiedot halutaan tiivistää tai laajentaa automaattisesti. Tällöin mahdolliset 
	puuttuvat numerointitasojen selosteet voidaan keksiä ja merkitä hakasulkeisiin 
	([ ]).</p>
	<p>Kun kohteeseen soveltuu vaihtoehtoisia numerointeja, niiden selosteet 
	merkitään osakenttiin &#8225;g ja &#8225;h. Jos vaihtoehtoisia numerointitasoja on 
	enemmän kuin kaksi, käytetään kenttiä 866-868 (Vapaamuotoiset varastotiedot).</p>
	<p>Kun käytetään vain julkaisuaikatasoja (kohteessa ei ole 
	numerointia), ne merkitään asianomaisiin osakenttiin &#8225;a-&#8225;h. Jos 
	julkaisuaikatasoa 
	kuvaavaa selostetta ei ole tarkoitettu käytettäväksi näytössä, se merkitään 
	sulkeisiin, esim. <em>(year)</em>.</p>
<p>Kun oheisaineiston tai hakemiston nimeä käytetään näytössä (jos niiden 
numerointi liittyy tietyn bibliografisen perusyksikön tiettyyn volyymiin tai osaan, esim. v. 9, suppl.1-3), ne merkitään 
asianomaisiin osakenttiin &#8225;a-&#8225;f.</p>
	<p>Kun numerointi koostuu varastossa olevien yksiköiden määrästä, jota 
	seuraa yksiköitä kuvaava termi, koko fraasi sijoitetaan sopivaan 863-865 
	kenttään ja 853-855 kenttä sisältää yksikkötermin (sulkeissa, jos sitä ei haluta näyttöön).</p>
	<ul>
		<li><strong>&#8225;a</strong> - Ensimmäinen numerointitaso (ET)</li>
		<li><strong>&#8225;b</strong> - Toinen numerointitaso (ET)</li>
		<li><strong>&#8225;c</strong> - Kolmas numerointitaso (ET)</li>
		<li><strong>&#8225;d</strong> - Neljäs numerointitaso (ET)</li>
		<li><strong>&#8225;e</strong> - Viides numerointitaso (ET)</li>
		<li><strong>&#8225;f</strong> - Kuudes numerointitaso (ET)</li>
		<li><strong>&#8225;g</strong> - Vaihtoehtoinen numerointi, ensimmäinen numerointitaso (ET)</li>
		<li><strong>&#8225;h</strong> - Vaihtoehtoinen numerointi, toinen numerointitaso (ET)</li>
	    <li><strong>&#8225;i-&#8225;m</strong> - Julkaisuaikatasojen selosteet</li>
	</ul>
	<p>Kentissä 863-865 ja 853-855 osakentät &#8225;i-&#8225;m ovat vastaavuussuhteessa 
	toisiinsa, joskaan käytettyjen osakenttien ei tarvitse olla samat. 
	Täydellistä vastaavuutta ei tarvita, kun julkaisuaikatasojen selosteita ei haluta käyttää 
	näytöissä. 
	Sen sijaan osakenttien on vastattava toisiaan täydellisesti, kun kentän 863 tai 864 
	tiedot halutaan tiivistää tai laajentaa automaattisesti. Tällöin yleensä 
	puuttuvat julkaisuaikatasojen selosteet voidaan keksiä ja merkitä hakasulkeisiin 
	([ ]).</p>
	<p>Kun kohteeseen soveltuu vaihtoehtoinen julkaisuaika, sen seloste 
	merkitään osakenttään &#8225;m. Jos vaihtoehtoisia julkaisuaikatasoja on useita, 
	käytetään kenttiä 866-868 (Vapaamuotoiset varastotiedot).</p>
	<p>Kun käytetään vain julkaisuaikatasoja (kohteessa ei ole numerointia), niitä 
	ei merkitä osakenttiin &#8225;i-&#8225;m, vaan ne merkitään asianomaisiin osakenttiin &#8225;a-&#8225;h. 
	Jos julkaisuaikatasoa kuvaavaa selostetta ei ole tarkoitettu käytettäväksi 
	näytössä, se merkitään sulkeisiin, esim. <em>(year)</em>.</p>
	<ul>
		<li><strong>&#8225;i</strong> - Ensimmäinen julkaisuaikataso (ET)</li>
		<li><strong>&#8225;j</strong> - Toinen julkaisuaikataso (ET)</li>
		<li><strong>&#8225;k</strong> - Kolmas julkaisuaikataso (ET)</li>
		<li><strong>&#8225;l</strong> - Neljäs julkaisuaikataso (ET)</li>
		<li><strong>&#8225;m</strong> - Vaihtoehtoinen numerointi, julkaisuaikataso (ET)<br/>
</li>
		<li><strong>&#8225;n</strong> - Huomautus julkaisukaavasta (ET)</li>
		<li><strong>&#8225;o</strong> - Oheisaineiston tyyppi (ET) <em>[854]</em><br/>
		Seloste, joka kuvaa oheisaineiston tyyppiä, esim. ostajan opas. 
		Osakenttä &#8225;o seuraa välittömästi sitä selostetta, johon se liittyy. 
		Jos oheisaineiston nimeke on eri kuin sen tyyppi, nimeke 
		tallennetaan kentän 864 osakenttään &#8225;o (Oheisaineiston nimeke).</li>
		<li><strong>&#8225;o</strong> - Hakemiston tyyppi (ET) <em>[855]</em><br/>
		Seloste, joka kuvaa hakemiston tyyppiä, esim. aihehakemisto. Osakenttä &#8225;o seuraa välittömästi sitä 
		selostetta, johon se liittyy. Jos hakemiston nimeke on eri kuin sen 
		tyyppi, nimeke tallennetaan kentän 865 osakenttään &#8225;o (Hakemiston 
		nimeke).</li>
		<li><strong>&#8225;p</strong> - Kappaleiden määrä per painos (ET)</li>
		<li><strong>&#8225;t</strong> - Kappaletiedon määre (ET)<br/>
		Seloste kappalenumerolle, joka on linkitetyn määrämuotoisen varastotietokentän osakentässä &#8225;t.</li>
		<li><strong>&#8225;u</strong> - Kuvailtavan numerointitason sisältämien bibliografisten yksiköiden määrä (T)<br/>
		Osakenttä &#8225;u seuraa välittömästi sitä numerointitason selostetta, johon se viittaa.
		Osakenttää &#8225;u ei käytetä osakenttien &#8225;a tai &#8225;g kanssa.<ul>
			<li><strong>[n]</strong> - Osien määrä<br/>
			Esim. neljä kertaa vuodessa ilmestyvä julkaisu vaatii 4 numeroa, 
			jotta siitä muodostuu yksi volyymi. Koska &#8225;u on vaihtuvamittainen 
			osakenttä, numeroissa ei tarvita etunollia.</li>
			<li><strong>var</strong> - Vaihtelee<br/>
			Käytetään, kun tarkka numero olisi merkityksetön.</li>
			<li><strong>und</strong> - Määrittelemätön<br/>
			Käytetään, kun osien määrää ei tunneta.</li>
		</ul>
		</li>
		<li><strong>&#8225;v</strong> - Numeroinnin jatkuvuus (T)<br/>
		Onko kuvaillun tason numerointi jatkuva, vai alkaako se alusta jokaisen 
		yksikön (volyymi tms.) alussa.<ul>
		<li><strong>c</strong> - Numero kasvaa jatkuvasti</li>
		<li><strong>r</strong> - Numerointi alkaa alusta jokaisen yksikön alussa</li>
	</ul>
		</li>
		<li><strong>&#8225;w</strong> - 
Ilmestymistiheys (ET)<br/>Koodi tai numero, joka ilmaisee kohteen ilmestymistiheyden. Osakenttä &#8225;w 
tallennetaan viimeisen julkaisuaikatason selosteen jälkeen. Tarkemmat 
		julkaisukaavaa koskevat tiedot tallennetaan osakenttään &#8225;y 
		(Säännöllisyys) ja myös osakenttää &#8225;p voidaan käyttää, kun moniosaisille 
		kohteille on tallennettava sekä ilmestymistiheyden koodi että 
		kappaleiden määrä per painos.<ul>
		<li>Koodit:<ul>
		<li><strong>a</strong> - Kerran vuodessa</li>
		<li><strong>b</strong> - Joka toinen kuukausi</li>
		<li><strong>c</strong> - Kaksi kertaa viikossa</li>
		<li><strong>d</strong> - Päivittäin</li>
		<li><strong>e</strong> - Kerran kahdessa viikossa</li>
		<li><strong>f</strong> - Puolivuosittain</li>
		<li><strong>g</strong> - Kerran kahdessa vuodessa</li>
		<li><strong>h</strong> - Kerran kolmessa vuodessa</li>
		<li><strong>i</strong> - Kolme kertaa viikossa</li>
		<li><strong>j</strong> - Kolme kertaa kuukaudessa</li>
		<li><strong>k</strong> - Jatkuva päivitys</li>
		<li><strong>m</strong> - Kerran kuukaudessa</li>
		<li><strong>q</strong> - Neljäsosavuosittain</li>
		<li><strong>s</strong> - Kaksi kertaa kuukaudessa</li>
		<li><strong>t</strong> - Kolme kertaa vuodessa</li>
		<li><strong>w</strong> - Kerran viikossa</li>
		<li><strong>x</strong> - Täysin epäsäännöllinen</li>
	</ul>
		</li>
		<li>Numero<br/>
		Kun mikään yllä mainituista säännöllisen ilmestymistiheyden koodeista ei 
		sovellu, voidaan vuodessa ilmestyvien numeroiden määrä merkitä numerolla. 
		Koska &#8225;w on vaihtuvamittainen osakenttä, numerossa ei tarvita etunollia.</li>
	</ul>
		</li>
		<li><strong>&#8225;x</strong> - Kalenterin vaihtuminen (ET)<br/>
		Yksi tai useampi kaksi- tai nelinumeroinen koodi, joka ilmaisee 
		ajankohdan jolloin ylin julkaisuaikataso vaihtuu.<ul>
		<li>Koodit<br/>
		Kaksinumeroinen koodi ilmaisee vaihtumisajankohdan kuukauden tai 
		vuodenajan. Nelinumeroinen koodi (kuukausi ja päivä) tallennetaan 
		muodossa <em>kkpp</em>. Numerot tasataan vasemmalle ja käyttämättömissä 
		merkkipaikoissa on nolla.<ul>
		<li><u>Kuukausi:</u></li>
		<li>01-12 - Kuukausi</li>
		<li><u>Päivä:</u></li>
		<li>01-31 - Päivä</li>
		<li><u>Vuodenaika:</u></li>
		<li>21 - Kevät</li>
		<li>22 - Kesä</li>
		<li>23 - Syksy</li>
		<li>24 - Talvi</li>
	</ul>
		</li>
	</ul>
		</li>
		<li><strong>&#8225;y</strong> - Säännöllisyys (T)<br/>
		Kuvaa osakentässä &#8225;w (Ilmestymistiheys) koodatun julkaisukaavan 
		säännöllisyyttä. Osakenttä voidaan rakentaa kahdella tavalla käyttämällä 
		joko julkaisuaika- tai numerointikoodeja. Molemmat aloitetaan 
		julkaisukoodilla.<ul>
		<li><em>Julkaisukoodi</em><br/>
		Osakentän ensimmäisen merkkipaikan koodi osoittaa viittaavatko seuraavat 
		koodit kohteen osien julkaisemiseen tai julkaisemattomuuteen, tai joko 
		numerointi- tai julkaisuaikaelementtien yhdistämiseen.<ul>
		<li><strong>c</strong> - Yhdistetty</li>
		<li><strong>o</strong> - Jätetty julkaisematta</li>
		<li><strong>p</strong> - Julkaistu</li>
	</ul>
		</li>
		<li><strong><em>Julkaisuaikakoodi</em></strong><br/>
		Käytettäessä julkaisuaikakoodeja, tiedot kootaan seuraavasti:<br/>
		&lt;Julkaisukoodi&gt;&lt;Julkaisuaikakoodin 
		määritelmä&gt;&lt;Julkaisuaikakoodi&gt;&lt;Julkaisuaikakoodi&gt;...<br/>
		Osakenttä voi sisältää yhden tai useampia julkaisuaikakoodeja, jotka 
		liittyvät ensimmäisessä ja toisessa merkkipaikassa annettuihin 
		julkaisukoodiin ja julkaisuaikakoodin määritelmään. Osakenttää voidaan 
		toistaa ja tallentaa toisenlainen Julkaisukoodi/Julkaisuaikakoodin 
		määritelmä/Julkaisuaikakoodi -jakso, kun halutaan merkitä säännöllinen 
		poikkeus säännöllisessä julkaisukaavassa.</li>
		<li><em>Julkaisuaikakoodin määritelmä</em><br/>
		Osakentän toisessa merkkipaikassa oleva koodi osoittaa ilmaisevatko 
		seuraavat julkaisuaikakoodit päivän nimeä, numeerista kuukausi- tai 
		kuukausi-ja-päivä -koodia, vuodenajan tai vuoden koodia, tai vuoden tai 
		kuukauden viikon koodia. (Jos osakentässä käytetään numerointikoodeja, 
		toisen merkkipaikan koodi on e.)<ul>
		<li><strong>d</strong> - Päivä</li>
		<li><strong>m</strong> - Kuukausi</li>
		<li><strong>s</strong> - Vuodenaika</li>
		<li><strong>w</strong> - Viikko</li>
		<li><strong>y</strong> - Vuosi</li>
	</ul>
		</li>
		<li><em>Julkaisuaikakoodi</em><br/>
		Ilmaisee kohteen osan, jota merkitty säännöllisyystieto koskee. 
		Useammat koodit erotetaan toisistaan pilkulla ja kaksoisnumerot 
		merkitään kauttaviivalla (/). Päiville, viikoille, kuukausille ja/tai 
		vuodenajoille käytetään kaksimerkkistä kirjain- tai numerokoodia. 
		Vuosille käytetään nelinumeroista koodia. Koodit, joissa on vähemmän 
		kuin kaksi merkkiä tasataan oikealle ja käyttämättömässä merkkipaikassa 
		on nolla.<br/>
		Ks. <a href="esimerkit_julkaisuaika.htm">esimerkit julkaisuaikakoodien 
		käytöstä</a>.</li>
		<li><strong><em>Numerointikoodi</em></strong><br/>
		Käytettäessä numerointikoodeja, tiedot kootaan seuraavasti:<br/>
		&lt;Julkaisukoodi&gt;&lt;Numerointikoodin 
		määritelmä&gt;&lt;Numerointikoodi&gt;&lt;Numerointikoodi&gt;...<br/>
		Numerointikoodia käytetään osakentän &#8225;y toisessa ja kolmannessa 
		merkkipaikassa kun halutaan merkitä säännöllisyyskaava kohteelle, jossa 
		järjestys perustuu ainoastaan numerointiin ja/tai kohteille, joissa 
		järjestys pitää määritellä erikseen kaksoisnumeroiden kohdalla.</li>
		<li><em>Numerointikoodin määritelmä</em><br/>
		Ilmaisevatko määritelmää seuraavat koodit numerointia vai julkaisuaikaa. 
		Kun käytetään koodia e, lisätään sen jälkeen myös numero ilmaisemaan 
		numerointitasoa jota säännöllisyys koskee.<ul>
		<li><strong>e1</strong> - Numerointi, ensimmäinen taso</li>
		<li><strong>e2</strong> - Numerointi, toinen taso</li>
	</ul>
		</li>
		<li><em>Numerointikoodi</em><br/>
		Ilmaisee kohteen numerot, joita merkitty säännöllisyystieto koskee. 
		Useammat koodit erotetaan toisistaan pilkulla ja kaksoisnumerot 
		merkitään kauttaviivalla (/).<br/>
		<br/>
		Numerointikoodin yhteydessä esiintyvä jatkuva numerointi (osakenttä &#8225;v, 
		koodi c) osoittaa kaksoisnumerot tiettyjen numeroiden järjestyksessä. 
		Jatkuvan numeroinnin vuoksi todellista numerointia ei voida käyttää 
		osakentässä &#8225;y. Numerointiarvot on esitettävä odotettujen numeroiden 
		määränä, jotta kaksoisnumerot voidaan ennakoida. Automaattisissa 
		järjestelmissä voi olla keinoja ennakoida jatkuvan numeroinnin toinen 
		numerointitaso tilauksen alussa annetun toisen numerointitason 
		lähtöarvon perusteella.<br/>
		<br/>
		Säännöllisyyskoodeja ylläpitää Library of Congress, Network Development and MARC Standards Office. 
		Koodeihin liittyvät kysymykset osoitetaan sinne:
		<a href="mailto:ndmso@loc.gov">ndmso@loc.gov</a>.<br/>
</li>
	</ul>
		</li>
		<li><strong>&#8225;z</strong> - Numerointi (T)<br/>Kuusimerkkinen koodi, joka kertoo julkaisun numerointisuunnitelman. Koodien 
avulla voidaan tallentaa erilaisia numerointisuunnitelmia eri 
numerointitasoille.<ul>
		<li>Merkinnön tyyppi<br/>Ensimmäisessä merkkipaikassa kerrotaan onko numerointi merkitty numeroina, 
kirjaimina vai niiden yhdistelmänä (numero vai kirjain ensin). Koodia c 
(Yhdistelmä) tulee käyttää vain silloin, kun toinen merkinnön elementeistä on 
pysyvä (esim. 1a, 2a, 3a), ei silloin, kun kyseessä on pikemminkin kaksi eri 
numerointitasoa (esim. 1a, 1b, 1c).<ul>
		<li><strong>a</strong> - Numero</li>
		<li><strong>b</strong> - Kirjain</li>
		<li><strong>c</strong> - Yhdistelmä, numero ensin</li>
		<li><strong>d</strong> - Yhdistelmä, kirjain ensin</li>
		<li><strong>e</strong> - Symboli tai erityismerkki</li>
	</ul>
		</li>
		<li>Aakkoslaji<br/>Toisen merkkipaikan koodi on käytössä, kun numerointisuunnitelma 
		merkitään kirjaimin (ensimmäisessä merkkipaikassa on koodi b) tai roomalaisin numeroin.<ul>
		<li><strong>a</strong> - Ei aakkoslajia</li>
		<li><strong>b</strong> - Gemena (pienaakkoset)</li>
		<li><strong>c</strong> - Versaali (suuraakkoset)</li>
		<li><strong>d</strong> - Sekalajinen (käytetty sekä versaalia että gemenaa)</li>
	</ul>
		</li>
		<li>Merkistö- tai tyyppikoodi<br/>Numerointikaavassa käytetty merkistö 
		merkitään nelimerkkisenä koodina
		<a href="http://www.unicode.org/iso15924/">ISO 15924</a> (<em>Codes for 
		the representation of names of scripts</em>) -standardin mukaisesti. 
		Tyyppikoodi on tarkoitettu numeroille, joita ei ole kirjoitettu 
		vaihtoehtoisilla merkistöillä ja siten koodattu merkistökoodeilla. 
		Symboleita varten on käytettävissä koodi sy, jota seuraa käytetty 
		symboli. Esimerkkejä:<ul>
		<li><u>Merkistökoodeja:</u></li>
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
		<li><strong>&#8225;2</strong> - Ilmestymistietojen lyhenteiden lähde (T)<br/>
		Koodi otetaan listalta, ks. <em>
		<a href="http://www.loc.gov/marc/relators/relahome.html">MARC Code Lists 
		for Relators, Sources, and Description Conventions</a></em>.</li>
		<li><strong>&#8225;3</strong> - Aineiston osa, jota tiedot koskevat (ET)<br/>
		Määrittelee volyymi- tai aikavälin, jota kentän tiedot koskevat.</li>
		<li><strong>&#8225;6</strong> - Linkitys (ET) ks. <em><a href="kontrolliosakentat.htm#6">Kontrolliosakentät</a></em></li>
		<li><strong>&#8225;8</strong> - Linkki- ja järjestysnumero (T) <em>ks. 
		<a href="kontrolliosakentat.htm#8">Kontrolliosakentät</a></em></li>
	</ul>
<h3>Tiivistämisen ja laajentamisen vaatimukset</h3>
<p>Varastotietojen pitää täyttää seuraavat ehdot, jotta ne voidaan 
automaattisesti tiivistää tai laajentaa.</p>
<ul>
	<li><em>Nimiö/17 Koodaustaso</em><br/>
	<strong>Tiivistäminen</strong> voidaan tehdä varastotiedoille, joiden koodaustaso on 4 
	tai 5.<br/>
	<strong>Laajentaminen</strong> voidaan tehdä varastotiedoille, joiden koodaustaso on 
	3, 4 tai 5.<br/>
</li>
	<li><em>Ilmestymistietojen ja varastotietojen vastaavuussuhde kentissä 
	853/854 ja 863/864</em><br/>
	<strong>Tiivistäminen ja laajentaminen</strong> edellyttävät, että selosteosakentät 
	(&#8225;a-&#8225;m) on tallennettu ilmestymistietojen kenttiin (853/854) ja niitä 
	vastaavat numerointi- ja julkaisuaikatasot on tallennettu niihin 
	linkitettyihin varastotietojen kenttiin (863/864).<br/>
</li>
	<li><em>Julkaisukaavaosakentät &#8225;u-&#8225;y</em><br/>
	Kun kenttiin 863 tai 864 on merkitty vain korkein numerointitaso 
	(osakentät &#8225;a, &#8225;g, &#8225;i, &#8225;m), tiivistäminen tai laajentaminen ei edellytä 
	julkaisukaavaan liittyviä osakenttiä kentissä 853 tai 854. Kun seuraavia 
	tasoja on merkitty, tiivistäminen tai laajentaminen edellyttää 
	asiaankuuluvat julkaisukaavaan liittyvät tiedot seuraaviin osakenttiin:<ul>
		<li><strong>&#8225;u</strong> - Kuvailtavan numerointitason sisältämien bibliografisten 
		yksiköiden määrä</li>
		<li><strong>&#8225;v</strong> - Numeroinnin jatkuvuus</li>
		<li><strong>&#8225;w</strong> - Ilmestymistiheys</li>
		<li><strong>&#8225;x</strong> - Kalenterin vaihtuminen</li>
		<li><strong>&#8225;y</strong> - Säännöllisyys</li>
	</ul>
	</li>
</ul>
<blockquote>
	<p>Osakenttien &#8225;a-&#8225;m <strong>tiivistäminen</strong> kentissä 863-864 edellyttää 
	tietoja osakentissä &#8225;u ja &#8225;v. Osakentässä &#8225;u ei saa olla koodia var 
	(Vaihtelee) tai und (Määrittelemätön).<br/>
	Osakenttien &#8225;a-&#8225;m <strong>laajentaminen</strong> kentissä 863-864 edellyttää tietoja 
	osakentissä &#8225;u, &#8225;v ja &#8225;w ja mahdollisesti myös osakentissä &#8225;x ja &#8225;y.</p>
</blockquote>
<h3>Järjestysluvut</h3>
<p>Kun halutaan osoittaa että järjestyslukujen pitää näkyä näytössä, selosteen 
eteen voidaan tallentaa plus-merkki (+). Jos selostetta ei ole tallennettu, 
plus-merkki voidaan tallentaa yksinään, jolloin vastaava 863 osakenttä näytetään 
järjestyslukuna.</p>
<p><strong>853 03&#8225;8</strong>1<strong>&#8225;a</strong>(year)<strong>&#8225;b</strong>+qtr.<br/>
<strong>863 40&#8225;8</strong>1.1<strong>&#8225;a</strong>1982<strong>&#8225;b</strong>1</p>
<p><strong>853 03&#8225;8</strong>1<strong>&#8225;a</strong>+<br/>
<strong>863 40&#8225;8</strong>1.1<strong>&#8225;a</strong>1</p>
<p>Huom, edellä kuvattu tekniikka järjestys- ja päälukujen erottamiselle ei ole 
pakollista, eikä erottelua tarvitse tehdä. Järjestelmässä tarvitaan sisäiset 
kielitaulukot, jos järjestysluvut halutaan näyttää oikein. Varastotietojen 
formaatissa ei ole ohjeita taulukoiden toteutukseen.</p>
<p><a href="#alku">Sivun alkuun</a></p>
<hr/>
  </xsl:template>

  <xsl:template name="yleista863">
<h3><a name="yleista"></a>MÄÄRÄMUOTOISET VARASTOTIEDOT--YLEISTÄ TIETOA</h3>
<p>Kentät 863-865 sisältävät omistajaorganisaation tekemän kuvauksen 
kokoelmiinsa sisältyvän bibliografisen kohteen varastotiedoista.</p>
<p>Selosteet, joiden avulla tunnistetaan kohteen numerointi- ja 
julkaisuaikatasot, sekä koodit, jotka määrittelevät varastotietojen 
julkaisukaavan sisältyvät ilmestymistietojen kenttiin (853-855), jotka 
linkitetään niihin liittyviin 863-865 kenttiin osakenttään &#8225;8 (Linkki- ja 
järjestysnumero) tallennetun numeron avulla.</p>
<p>Yleinen kuvaus varastotietokenttien neljästä eri tyypistä ja niiden suhteista 
toisiinsa löytyy osiosta <em><a href="yleista.htm">Varastotiedot--Yleistä tietoa</a></em>.<br/>
Varastotietojen automaattisessa tiivistämisessä tai laajentamisessa tarvittavat tietoelementit on kuvattu osiossa <em><a href="853-855.htm#yleista">Ilmestymistiedot--yleistä tietoa</a></em>.<br/>
Kuvaus tietojen tiivistettävyydestä ja laajennettavuudesta annetaan osiossa <em>
<a href="yleista.htm#tiivistys">Varastotiedot--Yleistä tietoa</a></em>.</p>
<h3>Indikaattorit</h3>
<ul>
	<li>Ensimmäinen - Kentän koodaustaso<br/>Määrittelee ISO 10324 (ANSI/NISO Z39.71) 
	tai ANSI Z39.42 -standardin mukaisen tarkkuustason, jota kentän koodauksessa on noudatettu.<ul>
		<li><strong>#</strong> - Tieto puuttuu</li>
		<li><strong>3</strong> - Taso 3 <em>[863/864]</em><br/>Kenttä sisältää joko bibliografista 
perusyksikköä (863) tai oheisaineistoa (864) koskevat tiivistetyt numerointi- ja 
julkaisuaikatiedot (vain ensimmäisestä tasosta).</li>
		<li><strong>4</strong> - Taso 4<br/>Kenttä sisältää tiivistämättömät numerointi- ja 
julkaisutiedot (sekä ensimmäisestä että sitä seuraavista tasoista).</li>
		<li><strong>5</strong> - Taso 4 lisättynä kappaleen tunnistustiedoilla<br/>Kenttä sisältää 
sekä tiivistämättömät varastotiedot että fyysisen kappaleen (esim. 
		osa/volyymi/nide) tunnistustiedot 
osakentässä &#8225;p (Kappaleen tunnistus).</li>
	</ul>
	</li>
	<li>Toinen - Varastotietojen muoto<br/>Merkitäänkö varastotiedot tiivistetyssä vai tiivistämättömässä muodossa ja 
pitäisikö näytön muodostamiseen käyttää tätä määrämuotoista varastotietojen 
kenttää vai vastaavaa vapaamuotoisten varastotietojen kenttää.<ul>
		<li><strong>#</strong> - Tieto puuttuu</li>
		<li><strong>0</strong> - Tiivistetty <em>[863/864]</em></li>
		<li><strong>1</strong> - Tiivistämätön</li>
		<li><strong>2</strong> - Tiivistetty, näytön muodostamiseen käytettävä vapaamuotoisia 
varastotietoja <em>[863/864]</em></li>
		<li><strong>3</strong> - Tiivistämätön, näytön muodostamiseen käytettävä vapaamuotoisia 
varastotietoja</li>
		<li><strong>4</strong> - Kohdetta/kohteita ei ole julkaistu <em>[863/864]</em></li>
	</ul>
	</li>
</ul>
<h3>Osakenttäkoodit</h3>
<p><strong>&#8225;a-&#8225;h</strong> - Numerointi<br/>
Numeroinnin tasot, jotka joko näkyvät kohteessa tai varastotietojen tallentaja on käyttänyt 
niitä ilmestymistietojen määrittelyssä. Nämä osakentät ovat vastaavuussuhteessa kenttien 
853-855 osakenttiin &#8225;a-&#8225;h (selosteet), joskaan käytettyjen osakenttien ei tarvitse olla 
samat. Täydellistä vastaavuutta ei tarvita, kun numerointitasojen selosteita ei 
haluta käyttää näytöissä. Sen sijaan osakenttien on vastattava toisiaan 
täydellisesti, kun kentän 863 tai 864 tiedot halutaan tiivistää tai laajentaa 
automaattisesti. Tällöin mahdollinen puuttuva numerointi voidaan keksiä ja 
merkitä hakasulkeisiin ([ ]).</p>
<p>Kun kohteeseen soveltuu vaihtoehtoisia numerointeja, ne 
	merkitään osakenttiin &#8225;g ja &#8225;h. Jos vaihtoehtoisia numerointitasoja on 
	enemmän kuin kaksi, käytetään kenttiä 866-868 (Vapaamuotoiset varastotiedot).</p>
<p>Kun käytetään vain julkaisuaikatasoja (kohteessa ei ole numerointia), niitä 
ei merkitä osakenttiin &#8225;i-&#8225;m, vaan ne merkitään asianomaisiin osakenttiin &#8225;a-&#8225;h.</p>
	<ul>
		<li><strong>&#8225;a</strong> - Ensimmäinen numerointitaso (ET)</li>
		<li><strong>&#8225;b</strong> - Toinen numerointitaso (ET)</li>
		<li><strong>&#8225;c</strong> - Kolmas numerointitaso (ET)</li>
		<li><strong>&#8225;d</strong> - Neljäs numerointitaso (ET)</li>
		<li><strong>&#8225;e</strong> - Viides numerointitaso (ET)</li>
		<li><strong>&#8225;f</strong> - Kuudes numerointitaso (ET)</li>
		<li><strong>&#8225;g</strong> - Vaihtoehtoinen numerointi, ensimmäinen numerointitaso (ET)</li>
		<li><strong>&#8225;h</strong> - Vaihtoehtoinen numerointi, toinen numerointitaso (ET)</li>
	</ul>
<p><strong>&#8225;i-&#8225;m</strong> - Julkaisuaika<br/>
Julkaisuaikojen hierarkkiset tasot, jotka joko näkyvät kohteessa tai 
tallentajaorganisaatio on käyttänyt niitä ilmestymistietojen määrittelyssä. Nämä 
osakentät ovat vastaavuussuhteessa kenttien 853-855 osakenttiin &#8225;i-&#8225;m 
(selosteet), joskaan käytettyjen osakenttien ei tarvitse olla samat. Täydellistä 
vastaavuutta ei tarvita, kun julkaisuaikatasojen selosteita ei haluta käyttää 
näytöissä. Sen sijaan osakenttien on vastattava toisiaan täydellisesti, kun 
kentän 863 tai 864 tiedot halutaan tiivistää tai laajentaa automaattisesti. 
Tällöin yleensä puuttuvat julkaisuaikatasojen selosteet voidaan keksiä ja 
merkitä hakasulkeisiin ([ ]).</p>
<p>Kuukaudet ja vuodenajat voidaan merkitä joko luonnollisella kielellä tai 
seuraavilla koodeilla:</p>
<ul>
	<li><u>Kuukausi:</u><ul>
		<li>01-12 - Kuukausi</li>
	</ul>
	</li>
	<li><u>Vuodenaika:</u><ul>
		<li>21 - Kevät</li>
		<li>22 - Kesä</li>
		<li>23 - Syksy</li>
		<li>24 - Talvi</li>
	</ul>
	</li>
</ul>
<p>Kuukausikoodi tasataan oikealle ja käyttämättömässä merkkipaikassa on nolla.</p>
<p>Kun kohteeseen soveltuu vaihtoehtoinen julkaisuaika, se 
	merkitään osakenttään &#8225;m. Jos vaihtoehtoisia julkaisuaikatasoja on useita, 
	käytetään kenttiä 866-868 (Vapaamuotoiset varastotiedot).</p>
<p>Kun käytetään vain julkaisuaikatasoja (kohteessa ei ole numerointia), niitä 
ei merkitä osakenttiin &#8225;i-&#8225;m, vaan ne merkitään asianomaisiin osakenttiin &#8225;a-&#8225;h.</p>
	<ul>
		<li><strong>&#8225;i</strong> - Ensimmäinen julkaisuaikataso (ET)</li>
		<li><strong>&#8225;j</strong> - Toinen julkaisuaikataso (ET)</li>
		<li><strong>&#8225;k</strong> - Kolmas julkaisuaikataso (ET)</li>
		<li><strong>&#8225;l</strong> - Neljäs julkaisuaikataso (ET)</li>
		<li><strong>&#8225;m</strong> - Vaihtoehtoinen numerointi, julkaisuaikataso (ET)<br/>
</li>
		<li><strong>&#8225;n</strong> - Muunnettu gregoriaaninen vuosiluku (ET)<br/>Jos osakentissä &#8225;i-&#8225;m annettu vuosiluku ei ole gregoriaanisen ajanlaskun 
mukainen, tähän osakenttään tallennetaan sama vuosiluku muunnettuna 
gregoriaanisen ajanlaskun mukaiseksi.</li>
		<li><strong>&#8225;o</strong> - Oheisaineiston nimeke (ET) <em>[864]</em><br/>Esim. Ostajan opas. Kun osakenttää &#8225;o käytetään, se seuraa välittömästi sitä 
numerointia, johon se liittyy. Jos oheisaineiston nimeke on sama kuin seloste 
kentän 854 osakentässä &#8225;o (Oheisaineiston tyyppi), nimekettä ei tallenneta 
kenttään 864.</li>
		<li><strong>&#8225;o</strong> - Hakemiston nimeke (ET) <em>[865]</em><br/>Esim. Aihehakemisto. Kun osakenttää &#8225;o käytetään, se seuraa välittömästi sitä 
numerointia, johon se liittyy. Jos hakemiston nimeke on sama kuin seloste kentän 
855 osakentässä &#8225;o (Hakemiston tyyppi), nimekettä ei tallenneta kenttään 865.</li>
		<li><strong>&#8225;p</strong> - Kappaleen tunnistus (ET)<br/>Kappaleen (esim. 
		osa/volyymi/nide) tunnistustiedot, esim. viivakoodi- tai hankintanumero. 
Tunnistustietoja voi edeltää joko versaali B tai versaali U merkitsemässä onko 
		kappaleet sidottu (B=bound) vai sitomattomia (U=unbound). Osakenttään &#8225;p 
		voidaan merkitä myös kaksi kauttaviivaa (//) merkitsemään sitä, että 
		varastotiedot ovat kappalekohtaisia.<br/>
		Kun kappaletiedot koskevat koko varastotietojen merkintöä, ne 
		tallennetaan kentän 852 (Sijainti) osakenttään &#8225;p (Kappaleen tunnistus). 
		Kun kappaleen tiedot koskevat numerointia ja julkaisuaikaa, ne merkitään 
		kenttiin 863-865. Kun kappaleen tiedot ovat päteviä ainoastaan 
		kappaletasolla, ne tallennetaan kappaletietojen kenttien (876-878) 
		osakenttään &#8225;p.</li>
		<li><strong>&#8225;q</strong> - Kappaleen fyysinen kunto (ET)<br/>
		Kun kappaleen fyysistä kuntoa kuvaava tieto koskee koko varastotietojen 
		merkintöä, se tallennetaan kentän 852 (Sijainti) osakenttään &#8225;q 
		(Kappaleen fyysinen kunto). Säilyttämistoimenpiteisiin vaikuttavat 
		fyysistä kuntoa koskevat tiedot tallennetaan kenttään 583 (Huomautus 
		toimenpiteistä).</li>
		<li><strong>&#8225;s</strong> - Artikkelin tekijänoikeusmaksun koodi (T)<br/>
		Ks. bibliografisen formaatin kenttä
		<a href="../bib/01X-04X.htm#018">018</a>.</li>
		<li><strong>&#8225;t</strong> - Kappaleen numero (ET)<br/>
		Yksittäisen kappaleen numero, tai numeroväli kappaleille, joilla on sama 
		sijainti ja luokitus.</li>
		<li><strong>&#8225;v</strong> - Julkaisuvuosi (T) <em>[865]</em></li>
		<li><strong>&#8225;w</strong> - Puutemerkinnön tyyppi (ET)<br/>Osoittaa varastotiedoissa 
		olevan aukon syyn.<ul>
		<li><strong>g</strong> - Osia puuttuu<br/>Olemassa olevia osia puuttuu. Käytetään myös kun aukon syy on epävarma 
		tai tuntematon.</li>
		<li><strong>n</strong> - Osia ei ole julkaistu<br/>Puuttuvaa(ia) osaa(ia) ei ole julkaistu lainkaan tai ilmestymistiedot 
		hyppäävät puuttuva(ie)n osa(ie)n yli.</li>
	</ul>
		</li>
		<li><strong>&#8225;x</strong> - Sisäinen huomautus (T)</li>
		<li><strong>&#8225;z</strong> - Julkinen huomautus (T)</li>
		<li><strong>&#8225;6</strong> - Linkitys (ET) ks. <em><a href="kontrolliosakentat.htm#6">Kontrolliosakentät</a></em></li>
		<li><strong>&#8225;8</strong> - Linkki- ja järjestysnumero (T) <em>ks. 
		<a href="kontrolliosakentat.htm#8">Kontrolliosakentät</a></em></li>
	</ul>
<p><a href="#alku">Sivun alkuun</a></p>
<hr/>
  </xsl:template>

  <xsl:template name="yleista866">
<h3><a name="yleista"></a>VAPAAMUOTOISET VARASTOTIEDOT--YLEISTÄ TIETOA</h3>
<p>Kentät 866-868 sisältävät vapaamuotoisia varastotietoja, joissa voi olla 
mukana sekä selosteita että numerointi- ja julkaisuaikatietoja. Näitä kenttiä 
käytetään yleensä yksiosaisten monografioiden varastotietojen merkitsemiseen, 
tai moniosaisten monografioiden tai kausijulkaisujen kohdalla silloin, kun 
ilmestymistietojen (853-855) ja määrämuotoisten varastotietojen kentät (863-865) 
eivät sovellu niiden varastotietojen kuvailemiseen. Kenttiä 866-868 voidaan 
käyttää määrämuotoisten varastotietokenttien tai ilmestymistietojen kenttien 
lisäksi, kun niistä kaikista tai osasta niistä halutaan muodostaa vaihtoehtoisia 
näyttöjä.</p>
<p>Yleinen kuvaus varastotietojen neljästä eri kenttäryhmästä, niiden suhteista 
toisiinsa ja niiden toistettavuudesta löytyy osiosta <em><a href="yleista.htm">
Varastotiedot--yleistä tietoa</a></em>.<br/>
Ohjeet siitä, miten tallennetaan 866-868 
kenttiin liittyviä kappalekohtaisia tietoja, löytyy osiosta <em>
<a href="876-878.htm#yleista">Kappalekohtaiset tiedot--yleistä tietoa</a></em>.</p>
<h4>Indikaattorit</h4>
<ul>
	<li>Ensimmäinen - Kentän koodaustaso<br/>Määrittelee kenttään merkittyjen 
	numerointi- ja julkaisuaikatietojen tarkkuustason.<ul>
		<li><strong>#</strong> - Tieto puuttuu</li>
		<li><strong>3</strong> - Taso 3<br/>Kenttä sisältää tiivistetyt numerointi- ja 
julkaisuaikatiedot (vain ensimmäisestä tasosta).</li>
		<li><strong>4</strong> - Taso 4<br/>Kenttä sisältää tiivistämättömät numerointi- ja 
julkaisutiedot (sekä ensimmäisestä että sitä seuraavista tasoista).</li>
		<li><strong>5</strong> - Taso 4 lisättynä kappaleen tunnistustiedoilla<br/>Kenttä sisältää 
sekä tiivistämättömät varastotiedot että fyysisen kappaleen tunnistusnumeron 
osakentässä &#8225;a (Tiedot tekstinä).</li>
	</ul>
	</li>
	<li>Toinen - Merkintätavan tyyppi<br/>
	Onko osakentän &#8225;a varastotiedot tallennettu jonkin standardoidun vai 
	standardoimattoman merkintätavan mukaan.<ul>
		<li><font color="#FF0000"><strong># - </strong>Määrittelemätön/ei koodattu - 
		suomalainen koodi</font></li>
		<li><strong>0</strong> - Standardoimaton</li>
		<li><strong>1</strong> - ISO 10324 (ANSI/NISO Z39.71)</li>
		<li><strong>2</strong> - ANSI Z39.42</li>
		<li><strong>7</strong> - Merkintätapa määritellään osakentässä &#8225;2</li>
	</ul>
	</li>
</ul>
<h4>Osakenttäkoodit</h4>
<ul>
	<li><strong>&#8225;a</strong> - Tiedot tekstinä (ET)<br/>
	Varastotiedot tekstimuodossa, joko kenttien 853-855 ja 863-865 sijasta tai 
	niiden lisäksi.</li>
	<li><strong>&#8225;x</strong> - Sisäinen huomautus (T)</li>
	<li><strong>&#8225;z</strong> - Julkinen huomautus (T)</li>
	<li><strong>&#8225;2</strong> - Merkintätavan lähde (ET)</li>
	<li><strong>&#8225;6</strong> - Linkitys (ET) ks. <em><a href="kontrolliosakentat.htm#6">Kontrolliosakentät</a></em></li>
	<li><strong>&#8225;8</strong> - Linkki- ja järjestysnumero (T) <em>ks. 
	<a href="kontrolliosakentat.htm#8">Kontrolliosakentät</a></em></li>
</ul>
<p><a href="#alku">Sivun alkuun</a></p>
<hr/>
  </xsl:template>

  <xsl:template name="yleista876">
<h3><a name="yleista"></a>KAPPALETIEDOT--YLEISTÄ TIETOA</h3>
<p>Kentät 876-878 sisältävät kappaletason tietoja varastotietueessa 
tarkoitetusta kohteesta. Kentät sisältävät monia erilaisia tietoelementtejä, 
jota voivat olla käyttökelpoisia mm. hankinnassa tai lainauksessa.</p>
<h3>Kappaletietojen linkittäminen kohteeseen, jota varastotiedot koskevat</h3>
<h4>Kohteessa, jota varastotiedot koskevat, on yksi fyysinen osa:</h4>
<blockquote>
	<p><em>Yksi kappale, yksi 852 kenttä</em><br/>
	Kappaletietojen kentissä ei tarvita linkitysosakenttiä, koska kaikki tiedot 
	liittyvät yhteen varastotietojen kohteeseen. (Varastotiedot on tallennettu 
	tasolla 1 tai 2 nimiön merkkipaikassa 17.)</p>
	<p><em>Useita kappaleita, yksi tai useampia 852 kenttiä</em><br/>
	Osakenttää &#8225;3 käytetään linkittämään kappaletiedot niihin liittyvän 
	kappaleen 852 kenttään/kenttiin. (Varastotiedot on tallennettu tasolla 1 tai 
	2 nimiön merkkipaikassa 17.)</p>
</blockquote>
<h4>Kohteessa, jota varastotiedot koskevat, on useita fyysisiä osia:</h4>
<blockquote>
	<p><em>Vapaamuotoiset varastotiedot kentissä 866-868</em><br/>
	Osakenttää &#8225;3 käytetään linkittämään kappaletiedot niihin liittyvän osan 
	tietoihin kentissä 866-868. (Varastotiedot on tallennettu tasolla 3 tai 4 
	nimiön merkkipaikassa 17.)</p>
	<p><em>Määrämuotoiset varastotiedot kentissä 863-865</em><br/>
	Osakenttää &#8225;8 käytetään linkittämään kappaletiedot niihin liittyvän osan 
	tietoihin kentissä 863-865. Jokainen osa (volyymi tai volyymit) johon 
	sisällytetään kappaletason tietoja, vaatii erillisen 863-865 kentän. 
	(Varastotiedot on tallennettu tasolla 3 tai 4 nimiön merkkipaikassa 17.)</p>
</blockquote>
<h4>Bibliografiseen tietueeseen sisällytetyt varastotiedot:</h4>
<p>Kun varastotiedot sisällytetään 
bibliografiseen MARC-tietueeseen, useita 876-878 kenttiä voidaan käyttää vain 
silloin, kun varastotiedot eivät sisällä muita kenttiä, jotka pitäisi linkittää 
johonkin kentistä 876-878. Kun linkitystä tarvitaan, vain yksi 876-878 kenttä ja 
siihen liittyvät varastotietojen kentät voidaan sisällyttää bibliografiseen 
tietueeseen. Muista 876-878 kentistä ja niihin liittyvistä kentistä täytyy tehdä 
erilliset varastotietueet.</p>
<p>Kuitenkin, bibliografisessa tietueessa voi olla useita 852 kenttiä ja niihin 
liittyviä 876-878 kenttiä, joissa määritellään joko kappaleen numero osakentässä 
&#8225;t tai aineiston osa, jota tiedot koskevat osakentässä &#8225;3.</p>
<h4>Indikaattorit</h4>
<ul>
	<li>Ensimmäinen - Määrittelemätön<ul>
		<li><strong>#</strong> - Määrittelemätön</li>
	</ul>
	</li>
	<li>Toinen - Määrittelemätön<ul>
		<li><strong>#</strong> - Määrittelemätön</li>
	</ul>
	</li>
</ul>
<h4>Osakenttäkoodit</h4>
<ul>
	<li><strong>&#8225;a</strong> - Kohteen sisäinen numero (ET)<br/>Uniikki identifikaationumero 
	kohteelle.</li>
	<li><strong>&#8225;b</strong> - Virheellinen tai peruttu kohteen sisäinen numero. (T)</li>
	<li><strong>&#8225;c</strong> - Kustannus (T)<br/>Hinta tai kohteen korvaamisen kustannus. 
	Kustannuksen laatu voidaan merkitä sulkeisiin, esim. normaali, alennettu.</li>
	<li><strong>&#8225;d</strong> - Hankinta-aika (T)<br/>Kohteen hankintapäivä ISO 8601 (<em>Representations of Dates 
	and Times</em>) -standardin mukaisessa muodossa <em>vvvvkkpp</em>. Jos 
	päiväykseen liittyy kustannus, osakenttä &#8225;d seuraa sitä osakenttää &#8225;c, johon 
	se liittyy.</li>
	<li><strong>&#8225;e</strong> - Hankintapaikka (T)</li>
	<li><strong>&#8225;h</strong> - Käyttörajoitukset (T)<br/>Tietoja mistä tahansa kappaleen 
	käyttöä koskevista rajoituksista. Tätä osakenttää käytetään tiedoille, jotka 
	ovat liian kappalekohtaisia voidakseen sopia bibliografisen tietueen 
	kenttään 506 (Huomautus käyttörajoituksista).</li>
	<li><strong>&#8225;j</strong> - Kappaleen tila (T)<br/>
	Tietoa kappaleen tilasta, esim. kadonnut tai poistettu.</li>
	<li><strong>&#8225;l</strong> - Väliaikainen sijainti (T)<br/>
	Pysyvään, kentässä 852 merkittyyn sijaintiin liittyvää tietoa tilapäisestä 
	sijainnista.</li>
	<li><strong>&#8225;p</strong> - Kappaleen tunnistus (T)<br/>
	Kappaleen (esim. osa/volyymi/nide) tunnistustiedot, esim. viivakoodi- tai 
	hankintanumero.</li>
	<li><strong>&#8225;r</strong> - Virheellinen tai peruttu kappaleen tunnistus (T)</li>
	<li><strong>&#8225;t</strong> - Kappaleen numero (ET)</li>
	<li><strong>&#8225;x</strong> - Sisäinen huomautus (T)</li>
	<li><strong>&#8225;z</strong> - Julkinen huomautus (T)</li>
	<li><strong>&#8225;3</strong> - Aineiston osa, jota tiedot koskevat (ET)</li>
	<li><strong>&#8225;6</strong> - Linkitys (ET) ks. <em><a href="kontrolliosakentat.htm#6">Kontrolliosakentät</a></em></li>
	<li><strong>&#8225;8</strong> - Linkki- ja järjestysnumero (T) <em>ks. 
	<a href="kontrolliosakentat.htm#8">Kontrolliosakentät</a></em></li>
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
    <xsl:value-of select="translate($str, 'abcdefghijklmnopqrstuvwxyzåäö', 'ABCDEFGHIJKLMNOPQRSTUVWXYZÅÄÖ')"/>
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
