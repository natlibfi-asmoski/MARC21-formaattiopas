<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

  <xsl:output method="html"/>
  <xsl:template match="/">
<html>

<head>
<meta http-equiv="Content-Language" content="fi" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>MARC 21: Auktoriteettitiedot</title>
</head>

<body>
<a name="alku"></a>

<center>
<table border="2" width="600" bordercolor="#000000" id="table1" bgcolor="#996633">
	<tr>
		<td>
		<p align="center">Kansalliskirjasto</p>
		<h1 align="center">MARC 21 -formaatti:<br />
		AUKTORITEETTITIEDOT</h1>
		</td>
	</tr>
</table>
</center>
      <xsl:apply-templates/>
<p><a href="index.htm">Auktoriteettitiedot-etusivulle</a> | <a href="../index.htm">MARC 21 -etusivulle</a></p>
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
<p><a href="index.htm">Auktoriteettitiedot-etusivulle</a> |
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
    <p><a href="index.htm">Auktoriteettitiedot-etusivulle</a> |
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
    <p><a href="index.htm">Auktoriteettitiedot-etusivulle</a> |
    <a href="../index.htm">MARC 21 -etusivulle</a></p>
    <hr/>

    <p><xsl:apply-templates select="description"/></p>
    <xsl:choose>
    <xsl:when test="datafield[@tag='100']">
      <ul>
        <xsl:for-each select="datafield">
	      <xsl:choose>
          <xsl:when test="@tag='100'">
	          <li><a href="#yleista">OTSIKKOMUODOT--YLEISTÄ TIETOA</a></li>
          </xsl:when>
        </xsl:choose>
        <xsl:if test="not (@tag='046' or substring(@tag, 1, 1)='3' )">
          <li><a href="#{@tag}"><xsl:value-of select="@tag"/> - <xsl:call-template name="capitalize"><xsl:with-param name="str" select="name"/></xsl:call-template></a><xsl:choose><xsl:when test="@repeatable='Y'"> (T)</xsl:when><xsl:when test="@repeatable='N'"> (ET)</xsl:when></xsl:choose></li>
        </xsl:if>
        </xsl:for-each>
      </ul>
      <p>Kentissä 046 ja 3XX on lisätietoa kenttien 100-185 otsikkomuodoista.</p>
      <ul>
        <li><a href="#046">046 - ERIKOISKOODATUT AJANKOHDAT</a> (T)</li>
        <li><a href="#336">336 - SISÄLTÖTYYPPI</a> (T)</li>
        <li><a href="#348">348 - NUOTTIAINEISTON MUOTO</a> (T)</li>
        <li><a href="#368">368 - HENKILÖN TAI YHTEISÖN OMINAISUUKSIA</a> (T)</li>
        <li><a href="#370">370 - PAIKANNIMI</a> (T)</li>
        <li><a href="#371">371 - OSOITE</a> (T)</li>
        <li><a href="#372">372 - TOIMINTA-ALA</a> (T)</li>
        <li><a href="#373">373 - YHTEYS RYHMÄÄN</a> (T)</li>
        <li><a href="#374">374 - AMMATTI</a> (T)</li>
        <li><a href="#375">375 - SUKUPUOLI</a>(T)</li>
        <li><a href="#376">376 - TIETOA SUVUSTA</a> (T)</li>
        <li><a href="#377">377 - KIELI</a> (T)</li>
        <li><a href="#378">378 - HENKILÖNNIMEN TÄYDELLISEMPI MUOTO</a> (T)</li>
        <li><a href="#380">380 - TEOKSEN MUOTO</a> (T)</li>
        <li><a href="#381">381 - TEOKSEN TAI EKSPRESSION MUUT ERITYISPIIRTEET</a> (T)</li>
        <li><a href="#382">382 - ESITYSKOKOONPANO</a> (T)</li> 
        <li><a href="#383">383 - MUSIIKKITEOKSEN NUMEROINTIMERKINTÖ</a> (T)</li>
        <li><a href="#384">384 - SÄVELLAJI</a> (T)</li>
        <li><a href="#385">385 - KOHDERYHMÄN OMINAISUUDET</a> (T)</li>
        <li><a href="#386">386 - TEKIJÄN OMINAISUUDET</a> (T)</li>
	<li><a href="#388">388 - LUOMISAIKA</a> (T)</li>
      </ul>
    </xsl:when>
    <xsl:otherwise>
      <ul>
        <xsl:for-each select="datafield">
	      <xsl:choose>
          <xsl:when test="@tag='700'">
            <li><a href="#yleista">LINKKIKENTÄT--YLEISTÄ TIETOA</a></li>
          </xsl:when>
        </xsl:choose>
        <li><a href="#{@tag}"><xsl:value-of select="@tag"/> - <xsl:call-template name="capitalize"><xsl:with-param name="str" select="name"/></xsl:call-template></a><xsl:choose><xsl:when test="@repeatable='Y'"> (T)</xsl:when><xsl:when test="@repeatable='N'"> (ET)</xsl:when></xsl:choose></li>
      </xsl:for-each>
    </ul>
    </xsl:otherwise>
    </xsl:choose>
    <xsl:apply-templates select="terminology"/>
    <hr/>
    <xsl:apply-templates select="datafield"/>
  </xsl:template>

  <xsl:template match="datafield">
    <xsl:choose><xsl:when test="@tag='100'">
      <xsl:call-template name="yleista1xx"/>
    </xsl:when></xsl:choose>
    <xsl:choose><xsl:when test="@tag='700'">
      <xsl:call-template name="yleista7xx"/>
    </xsl:when></xsl:choose>
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

  <xsl:template name="yleista1xx">
<h3><a name="yleista"></a>OTSIKKOMUODOT--YLEISTÄ TIETOA</h3>
<p>Auktoriteettitietojen formaatissa erotetaan kahdenlaisia otsikkomuotoja:</p>
<blockquote>
	<p><strong>Vahvistettu otsikkomuoto</strong><br/>Käytetään bibliografisten tietueiden pääkirjauksena (1XX), lisäkirjauksena (700-730), 
sarjalisäkirjauksena (440 tai 800-830) tai ensimmäisenä elementtinä 
asiasanakentissä (600-651, 654-657). Auktoriteettitietueissa vahvistettuja otsikkomuotoja käytetään otsikkomuotojen kentissä 100-155 ja niihin 
	viittaavissa kentissä 500-555. Edellinen koskee vahvistettujen otsikkomuotojen tietueita (008/09, Tietueen laatu, koodi <strong>a</strong> tai <strong>f</strong>) ja 
lisämääreiden tietueita (008/09, Tietueen laatu, koodi <strong>d</strong>).</p>
	<p><strong>Vahvistamaton otsikkomuoto</strong><br/>
	Vahvistamatonta otsikkomuotoa ei saa käyttää muissa MARC-tietueissa pää-, lisä-, 
	sarjalisäkirjauskenttien tai asiasanakenttien ensimmäisenä elementtinä. 
	Vahvistamaton otsikkomuoto voi olla vahvistetun otsikkomuodon variantti 
	tai sen epätäydellinen osa, tai sen ainoa tarkoitus voi liittyä 
	auktoriteettitiedoston järjestelyyn. Vahvistamatonta otsikkomuotoa ei käytetä 
	bibliografisissa tietueissa, mutta vahvistettujen otsikkomuotojen 
	tietueissa sitä voidaan käyttää 4XX-viittauskentässä. 
	1XX-kenttä sisältää vahvistamattoman otsikkomuodon seuraavissa 
	tietuelajeissa: viittaus, lisämääre, viittaus ja lisämääre, alanmukaisen 
	ryhmän otsikko.</p>
</blockquote>
<p>Otsikkomuodot voivat olla tyypeiltään seuraavanlaisia:</p>
<blockquote>
	<ul>
		<li><strong>Nimi</strong><br/>Otsikkomuoto on henkilön- tai yhteisönnimi, kokouksen tai virallistahon 
	nimi.</li>
		<li><strong>Tekijä/nimeke</strong><br/>Otsikkomuoto koostuu kahdesta osasta, 
		tekijän nimestä ja teoksen nimekkeestä. Tekijäosassa voi olla henkilön- 
		tai yhteisönnimi, kokouksen tai virallistahon nimi. Nimekeosassa voi 
		olla yhtenäistetty tai tavallinen nimeke, teoksen nimiösivun nimeke tai 
		sarjan nimeke.</li>
		<li><strong>Yhtenäistetty nimeke</strong><br/>Otsikkomuoto käsittää yhtenäistetyn tai tavallisen nimekkeen, 
	nimiösivun nimekkeen tai sarjan nimekkeen, jota ei ole liitetty 
	tekijä/nimeke-yhdistelmään.</li>
		<li><strong>Aihetta ilmaiseva termi</strong></li>
		<li><strong>Aikaa ilmaiseva termi</strong></li>
		<li><strong>Lajityyppiä/muotoa ilmaiseva termi</strong></li>
		<li><strong>Lisämääre</strong><br/>Otsikkomuoto yleisestä (aihetta tai kieltä 
		ilmaisevasta), maantieteellisestä, aikaa tai muotoa ilmaisevasta 
		asialisämääretermistä. Lisämääreketju sisältää useamman kuin yhden 
		asialisämääretermin (osakentät &#8225;v, &#8225;x, &#8225;y ja &#8225;z).</li>
		<li><strong>Asiasanaketju</strong><br/>Nimi, tekijä/nimeke, yhtenäistetty nimeke, aihetta tai 
	lajityyppiä/muotoa ilmaiseva termi, joka sisältää yhden tai useampia yleisiä, 
		maantieteellisiä, aikaa tai muotoa ilmaisevia asialisämääretermejä (osakentät &#8225;v, &#8225;x, &#8225;y 
	tai &#8225;z).</li>
		<li><strong>Alanmukaisen ryhmän otsikko</strong><br/>Otsikkomuoto, jota voidaan käyttää asiasanaston systemaattisessa osassa 
	otsikkona ilmaisemassa termikategorioiden jakoperusteita. Kaksoisväliviivaa 
	(--), joka edeltää asialisämääreitä ei tallenneta MARC-tietueeseen, vaan se voidaan muodostaa näyttöön 
	osakenttien &#8225;v, &#8225;x, &#8225;y tai &#8225;z perusteella.</li>
	</ul>
</blockquote>
<h3>Otsikkomuotojen käyttö</h3>
<p>Vain 1XX-kentän vahvistettua otsikkomuotoa 
voidaan käyttää bibliografisissa tietueissa hakuelementtinä. Nimiä, 
tekijä/nimekkeitä ja yhtenäistettyjä nimekkeitä voidaan käyttää <strong>pää- tai 
lisäkirjauksina</strong> (008/14, koodi <strong>a</strong>); nimiä, tekijä/nimekkeitä ja 
yhtenäistettyjä nimekkeitä, aihetta ja lajityyppiä/muotoa ilmaisevia termejä 
sekä asiasanaketjuja voidaan käyttää <strong>asiasanoina</strong> (008/15, koodi
<strong>a</strong>); tekijä/nimekkeitä ja yhtenäistettyjä nimekkeitä voidaan käyttää <strong>
sarjalisäkirjauksina</strong> (008/16, koodi <strong>a</strong>). Lisämääreiden otsikkomuotoja voidaan käyttää vain asiasanaketjuissa.</p>
<h3>Nimi- ja asiasana-auktoriteetit</h3>
<p>Otsikkomuoto voidaan määritellä soveltuvaksi joko nimi- tai 
asiasana-auktoriteetin rakenteeseen.</p>
<p>Otsikkomuodot, jotka on laadittu luettelointisääntöjen käytäntöjen mukaisesti 
(008/10) ovat soveltuvia <strong>nimiauktoriteeteiksi</strong>. Näitä ovat nimien, 
tekijä/nimekkeiden ja yhtenäistettyjen nimekkeiden otsikkomuodot 
vahvistettujen otsikkomuotojen tietueissa sekä vahvistettujen otsikkomuotojen ja lisämääreiden tietueissa, ja näiden vahvistamattomat 
otsikkomuodot 
viittaustietueissa. Tiettyjä 
huomautus- ja viittauskenttiä voidaan käyttää vain nimiauktoriteeteissa.</p>
<p>Otsikkomuodot, jotka on laadittu jonkin asiasanaston käytäntöjen mukaisesti (008/11) 
ovat soveltuvia <strong>asiasanoiksi</strong>. Näitä ovat nimien, 
tekijä/nimekkeiden, yhtenäistettyjen nimekkeiden, aihetta, aikaa tai 
lajityyppiä/muotoa ilmaisevien termien (sekä näistä laadittujen asiasanaketjujen) otsikkomuodot vahvistettujen otsikkomuotojen tietueissa 
sekä vahvistettujen otsikkomuotojen ja lisämääreiden tietueissa. Näiden 
vahvistamattomia otsikkomuotoja käytetään viittaustietueissa sekä viittaus ja lisämääre 
-tietueissa. Vahvistamattomia otsikkomuotoja käytetään myös 
alanmukaisen ryhmän otsikkotietueissa. Tiettyjä huomautus- ja viittauskenttiä 
voidaan käyttää vain asiasana-auktoriteeteissa.</p>
<p><a href="#alku">Sivun alkuun</a></p>
<hr/>
  </xsl:template>

  <xsl:template name="yleista7xx">
<h3><a name="yleista"></a>LINKKIKENTÄT--YLEISTÄ TIETOA</h3>
<p>Vahvistettujen otsikkomuotojen tai otsikkomuodon ja lisämääreen 
tietueisiin voidaan lisätä linkkikenttiä nimille, tekijä/nimekkeille, yhtenäistetyille 
nimekkeille, aihetta tai muotoa ilmaiseville termeille, tai asiasanaketjuille sekä vahvistettujen otsikkomuotojen tietueisiin 
ohjeelliselle asialisämääreelle. Linkkikenttä linkittää edellä mainittuja niihin liittyviin otsikkomuotoihin esim. seuraavanlaisissa tapauksissa:</p>
<ul>
	<li>Vastaavat nimet monikielisessä asiasanastossa<ul>
		<li>Esimerkki: LAC:n englanninkielinen otsikkomuoto <em>Francis, of Assisi, Saint, 1182-1226</em> 
		ja LAC:n ranskankielinen otsikkomuoto <em>François, d'Assise, saint, 1182-1226</em></li>
	</ul>
	</li>
	<li>Vastaavat aihetta ilmaisevat termit eri auktoriteettijärjestelmissä<ul>
		<li>Esimerkki: LCSH:n otsikkomuodot <em>Medical referral</em> ja <em>Medical consultation</em>, 
		ja MeSH:n otsikkomuoto <em>Referral and Consultation</em></li>
	</ul>
	</li>
	<li>Aihetta ilmaisevan termin otsikkomuoto (kenttä 150) ja sama tai 
	samankaltainen termi asialisämääreenä (kenttä 78X)<ul>
		<li>Esimerkki: vahvistettu termi <em>History</em> ja asialisämääre
		<em>History</em></li>
		<li>Esimerkki: vahvistettu termi <em>Twentieth century</em> ja asialisämääre <em>20th century</em></li>
	</ul>
	</li>
	<li>Maantieteellisen nimen otsikkomuoto (kenttä 151) ja saman nimen 
	epäsuora muoto, jota käytetään maantieteellisenä asialisämääreenä (kenttä 781)<ul>
		<li>Esimerkki: vahvistettu otsikkomuoto <em>Rome (N.Y.)</em> ja 
		asialisämääre <em>New York (State) -- Rome</em>.</li>
	</ul>
	</li>
	<li>Lajityyppiä/muotoa ilmaisevan termin otsikkomuoto (kenttä 
155) ja sama tai samankaltainen termi, jota käytetään asiasanan muotoa 
	ilmaisevana asialisämääreenä (kenttä 785)<ul>
		<li>Esimerkki: vahvistettu otsikkomuoto <em>Periodicals</em> ja 
		asialisämääre <em>Periodicals</em>.</li>
	</ul>
	</li>
</ul>
<p>Kentät 700-755 sisältävät vahvistettuja otsikkomuotoja ja kentät 780-785 
vahvistettuja lisämääreiden otsikkomuotoja. Toisen indikaattorin tai osakentän &#8225;2 avulla 
ilmaistaan auktoriteettijärjestelmä, johon 7XX-kenttään merkitty otsikkomuoto kuuluu. Kun 7XX-muodosta on tehty erillinen auktoriteettitietue, 
sen kontrollinumero kentästä 035 tallennetaan 
7XX-kentän osakenttään &#8225;0 (Tietueen kontrollinumero).</p>
<p>Kenttään 788 tallennetaan vapaamuotoinen kuvaus eri otsikkomuotojen suhteesta, kun 
suhdetta ei voida kuvata 700-785 linkkikenttien avulla kyllin hyvin.</p>
<p>Ohjeet toisen indikaattorin, osakentän &#8225;2 (Asiasanan tai termin lähde) ja 
osakentän &#8225;w (Kontrollitiedot) käytöstä löytyvät tästä osiosta. Kenttien 700-785 
muita indikaattoreita ja osakenttiä koskevat ohjeet löytyvät kunkin kentän 
kohdalta.</p>
<h4>Indikaattorit</h4>
<ul>
	<li>Ensimmäinen<br/>
	Jokaisen 7XX-kentän ensimmäisen indikaattorin määritelmä on sama kuin 
	vastaavassa <a href="1XX.htm">1XX-kentässä</a>, joten selityksen voi tarkistaa sieltä.</li>
	<li>Toinen - Asiasanasto<br/>
	Asiasanasto tai auktoriteettitiedosto, josta asiasana on peräisin.<ul>
		<li><strong>0</strong> - Library of Congress Subject Headings (LCSH) / LC name authority file</li>
		<li><strong>1</strong> - LC subject headings for children's literature</li>
		<li><strong>2</strong> - Medical Subject Headings (MeSH) / NLM name authority file</li>
		<li><strong>3</strong> - National Agricultural Library subject authority file (NAL)</li>
		<li><strong>4</strong> - Asiasanastoa ei ole määritelty<br/>
		Asiasana on peräisin kontrolloidusta asiasanastosta tai 
		auktoriteettitiedostosta, mutta mikään muista indikaattoriarvoista tai 
		osakentän &#8225;2 koodeista ei ole sille soveltuva.</li>
		<li><strong>5</strong> - Canadian Subject Headings / LAC name authority file</li>
		<li><strong>6</strong> - Répertoire de vedettes-matière</li>
		<li><strong>7</strong> - Asiasanasto määritelty osakentässä &#8225;2</li>
	</ul>
	</li>
</ul>
<h4>Erikoisosakentät</h4>
<p>7XX-kenttien osakentät ovat pääosin samat kuin vastaavassa <a href="1XX.htm">1XX-kentässä</a>, 
joten selityksen voi tarkistaa sieltä. 7XX-kenttien osakenttien &#8225;w ja &#8225;2 
kuvaukset löytyvät tästä osiosta.</p>
<ul>
	<li><strong>&#8225;i</strong> - Tieto suhteesta (T)<br/>
	Osakenttä, johon tallennetaan tekstimuodossa kentässä 7XX olevan ...
	</li>
	<li><strong>&#8225;w</strong> - Kontrollitiedot (ET)<br/>
	Kaksi kiinteätä merkkipaikkaa (merkitään &#8225;w/0 ja &#8225;w/1), jotka kontrolloivat 
	linkkinäytön muodostumista tai kertovat 700-785 kenttien otsikkomuodon 
	monitahoisuudesta. Osakenttää &#8225;w käytetään vain, jos näyttöä ei haluta 
	muodostaa tai 
	jos otsikkomuodon korvaamista pitäisi harkita uudelleen.<ul>
		<li>/<strong>0</strong> - Linkkinäyttö<br/>
		Yksimerkkinen kirjainkoodi, joka kontrolloi linkin näyttämistä kentistä 
		700-785.<ul>
			<li><strong>a</strong> - Linkkiä ei näytetä<br/>
			Käytetään järjestelmäriippuvaisista syistä, kun koodeja <strong>b</strong> tai
			<strong>c</strong> ei voida käyttää. Tietueita vaihdettaessa koodi <strong>a</strong> 
			muunnetaan koodiksi <strong>n</strong> tai täyttömerkiksi (<strong>|</strong>).</li>
			<li><strong>b</strong> - Linkkiä ei näytetä, käytetään kenttää 788</li>
			<li><strong>c</strong> - Linkkiä ei näytetä, ei käytetä 7XX-kenttiä</li>
			<li><strong>n</strong> - Soveltumaton<br/>
			Käytetään, kun 7XX-kentän linkin näyttämiselle ei ole rajoituksia. 
			Merkkipaikkaa &#8225;w/0 ei tarvitse täyttää, jos koodi <strong>n</strong> soveltuu.</li>
		</ul>
		</li>
		<li>/<strong>1</strong> - Korvaamisen monitahoisuus<br/>
		Yksimerkkinen kirjainkoodi, joka osoittaa onko kenttien 700-785 
		otsikkomuodot mahdollista korvata automaattisesti.<ul>
			<li><strong>a</strong> - Otsikkomuodon korvaaminen ei vaadi uudelleenharkintaa</li>
			<li><strong>b</strong> - Otsikkomuodon korvaaminen vaatii uudelleenharkintaa</li>
			<li><strong>n</strong> - Soveltumaton<br/>
			Merkkipaikkaa &#8225;w/1 ei tarvitse täyttää, jos koodi <strong>n</strong> soveltuu.</li>
		</ul>
		</li>
	</ul>
	</li>
	<li><strong>&#8225;2</strong> - Asiasanan tai termin lähde (ET)<br/>
	MARC-koodi, joka identifioi käytetyn asiasanaston, kun toisen indikaattorin 
	arvo on 7. Koodi otetaan listalta, ks. <em>
	<a href="http://www.loc.gov/marc/relators/relasour.html">MARC Code Lists for Relators, Sources, Description Conventions: PART IV: Term, Name, Title Sources</a></em>.</li>
	<li><strong>&#8225;4</strong> - Koodi suhteelle (T)<br/>
	Koodatussa muodossa kentässä 7XX olevan ... Koodi otetaan listalta, ks. <em> ISO 25964-2: Thesauri and interoperability with other vocabularies - Part 2: Interoperability with other vocabularies,</em> Section 4, Table 1.
	</li>
</ul>
<h4>Esimerkkejä</h4>
<p><strong>785 #7&#8225;v</strong>atlases<strong>&#8225;0</strong>[record control number]<strong>&#8225;2</strong>att</p>
<p><strong>750 #0&#8225;8</strong>1<strong>&#8225;w</strong>b<strong>&#8225;a</strong>Medical referral</p>
<p><strong>700 11&#8225;w</strong>a<strong>&#8225;a</strong>Dostoyevsky, Fyodor,<strong>&#8225;d</strong>1821-1881.<strong>&#8225;t</strong>Crime and punishment</p>
<p><strong>710 27&#8225;w</strong>a<strong>&#8225;a</strong>Last Poets<strong>&#8225;2</strong>[source code]</p>
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
