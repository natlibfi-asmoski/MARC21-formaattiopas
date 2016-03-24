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
P�ivitetty viimeksi <xsl:value-of select="."/>.<br/>
Ks. <a href="../ohje.htm">Ohjeita formaattien kommentointiin</a>.</span></i></p>
  </xsl:template>

  <xsl:template match="leader-directory">
<h2 align="left"><xsl:value-of select="title"/></h2>
<p><a href="index.htm">Auktoriteettitiedot-etusivulle</a> |
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
	          <li><a href="#yleista">OTSIKKOMUODOT--YLEIST� TIETOA</a></li>
          </xsl:when>
        </xsl:choose>
        <xsl:if test="not (@tag='046' or substring(@tag, 1, 1)='3' )">
          <li><a href="#{@tag}"><xsl:value-of select="@tag"/> - <xsl:call-template name="capitalize"><xsl:with-param name="str" select="name"/></xsl:call-template></a><xsl:choose><xsl:when test="@repeatable='Y'"> (T)</xsl:when><xsl:when test="@repeatable='N'"> (ET)</xsl:when></xsl:choose></li>
        </xsl:if>
        </xsl:for-each>
      </ul>
      <p>Kentiss� 046 ja 3XX on lis�tietoa kenttien 100-185 otsikkomuodoista.</p>
      <ul>
        <li><a href="#046">046 - ERIKOISKOODATUT AJANKOHDAT</a> (T)</li>
        <li><a href="#336">336 - SIS�LT�TYYPPI</a> (T)</li>
        <li><a href="#348">348 - NUOTTIAINEISTON MUOTO</a> (T)</li>
        <li><a href="#368">368 - HENKIL�N TAI YHTEIS�N OMINAISUUKSIA</a> (T)</li>
        <li><a href="#370">370 - PAIKANNIMI</a> (T)</li>
        <li><a href="#371">371 - OSOITE</a> (T)</li>
        <li><a href="#372">372 - TOIMINTA-ALA</a> (T)</li>
        <li><a href="#373">373 - YHTEYS RYHM��N</a> (T)</li>
        <li><a href="#374">374 - AMMATTI</a> (T)</li>
        <li><a href="#375">375 - SUKUPUOLI</a>(T)</li>
        <li><a href="#376">376 - TIETOA SUVUSTA</a> (T)</li>
        <li><a href="#377">377 - KIELI</a> (T)</li>
        <li><a href="#378">378 - HENKIL�NNIMEN T�YDELLISEMPI MUOTO</a> (T)</li>
        <li><a href="#380">380 - TEOKSEN MUOTO</a> (T)</li>
        <li><a href="#381">381 - TEOKSEN TAI EKSPRESSION MUUT ERITYISPIIRTEET</a> (T)</li>
        <li><a href="#382">382 - ESITYSKOKOONPANO</a> (T)</li> 
        <li><a href="#383">383 - MUSIIKKITEOKSEN NUMEROINTIMERKINT�</a> (T)</li>
        <li><a href="#384">384 - S�VELLAJI</a> (T)</li>
        <li><a href="#385">385 - KOHDERYHM�N OMINAISUUDET</a> (T)</li>
        <li><a href="#386">386 - TEKIJ�N OMINAISUUDET</a> (T)</li>
	<li><a href="#388">388 - LUOMISAIKA</a> (T)</li>
      </ul>
    </xsl:when>
    <xsl:otherwise>
      <ul>
        <xsl:for-each select="datafield">
	      <xsl:choose>
          <xsl:when test="@tag='700'">
            <li><a href="#yleista">LINKKIKENT�T--YLEIST� TIETOA</a></li>
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

  <xsl:template name="yleista1xx">
<h3><a name="yleista"></a>OTSIKKOMUODOT--YLEIST� TIETOA</h3>
<p>Auktoriteettitietojen formaatissa erotetaan kahdenlaisia otsikkomuotoja:</p>
<blockquote>
	<p><strong>Vahvistettu otsikkomuoto</strong><br/>K�ytet��n bibliografisten tietueiden p��kirjauksena (1XX), lis�kirjauksena (700-730), 
sarjalis�kirjauksena (440 tai 800-830) tai ensimm�isen� elementtin� 
asiasanakentiss� (600-651, 654-657). Auktoriteettitietueissa vahvistettuja otsikkomuotoja k�ytet��n otsikkomuotojen kentiss� 100-155 ja niihin 
	viittaavissa kentiss� 500-555. Edellinen koskee vahvistettujen otsikkomuotojen tietueita (008/09, Tietueen laatu, koodi <strong>a</strong> tai <strong>f</strong>) ja 
lis�m��reiden tietueita (008/09, Tietueen laatu, koodi <strong>d</strong>).</p>
	<p><strong>Vahvistamaton otsikkomuoto</strong><br/>
	Vahvistamatonta otsikkomuotoa ei saa k�ytt�� muissa MARC-tietueissa p��-, lis�-, 
	sarjalis�kirjauskenttien tai asiasanakenttien ensimm�isen� elementtin�. 
	Vahvistamaton otsikkomuoto voi olla vahvistetun otsikkomuodon variantti 
	tai sen ep�t�ydellinen osa, tai sen ainoa tarkoitus voi liitty� 
	auktoriteettitiedoston j�rjestelyyn. Vahvistamatonta otsikkomuotoa ei k�ytet� 
	bibliografisissa tietueissa, mutta vahvistettujen otsikkomuotojen 
	tietueissa sit� voidaan k�ytt�� 4XX-viittauskent�ss�. 
	1XX-kentt� sis�lt�� vahvistamattoman otsikkomuodon seuraavissa 
	tietuelajeissa: viittaus, lis�m��re, viittaus ja lis�m��re, alanmukaisen 
	ryhm�n otsikko.</p>
</blockquote>
<p>Otsikkomuodot voivat olla tyypeilt��n seuraavanlaisia:</p>
<blockquote>
	<ul>
		<li><strong>Nimi</strong><br/>Otsikkomuoto on henkil�n- tai yhteis�nnimi, kokouksen tai virallistahon 
	nimi.</li>
		<li><strong>Tekij�/nimeke</strong><br/>Otsikkomuoto koostuu kahdesta osasta, 
		tekij�n nimest� ja teoksen nimekkeest�. Tekij�osassa voi olla henkil�n- 
		tai yhteis�nnimi, kokouksen tai virallistahon nimi. Nimekeosassa voi 
		olla yhten�istetty tai tavallinen nimeke, teoksen nimi�sivun nimeke tai 
		sarjan nimeke.</li>
		<li><strong>Yhten�istetty nimeke</strong><br/>Otsikkomuoto k�sitt�� yhten�istetyn tai tavallisen nimekkeen, 
	nimi�sivun nimekkeen tai sarjan nimekkeen, jota ei ole liitetty 
	tekij�/nimeke-yhdistelm��n.</li>
		<li><strong>Aihetta ilmaiseva termi</strong></li>
		<li><strong>Aikaa ilmaiseva termi</strong></li>
		<li><strong>Lajityyppi�/muotoa ilmaiseva termi</strong></li>
		<li><strong>Lis�m��re</strong><br/>Otsikkomuoto yleisest� (aihetta tai kielt� 
		ilmaisevasta), maantieteellisest�, aikaa tai muotoa ilmaisevasta 
		asialis�m��retermist�. Lis�m��reketju sis�lt�� useamman kuin yhden 
		asialis�m��retermin (osakent�t &#8225;v, &#8225;x, &#8225;y ja &#8225;z).</li>
		<li><strong>Asiasanaketju</strong><br/>Nimi, tekij�/nimeke, yhten�istetty nimeke, aihetta tai 
	lajityyppi�/muotoa ilmaiseva termi, joka sis�lt�� yhden tai useampia yleisi�, 
		maantieteellisi�, aikaa tai muotoa ilmaisevia asialis�m��retermej� (osakent�t &#8225;v, &#8225;x, &#8225;y 
	tai &#8225;z).</li>
		<li><strong>Alanmukaisen ryhm�n otsikko</strong><br/>Otsikkomuoto, jota voidaan k�ytt�� asiasanaston systemaattisessa osassa 
	otsikkona ilmaisemassa termikategorioiden jakoperusteita. Kaksoisv�liviivaa 
	(--), joka edelt�� asialis�m��reit� ei tallenneta MARC-tietueeseen, vaan se voidaan muodostaa n�ytt��n 
	osakenttien &#8225;v, &#8225;x, &#8225;y tai &#8225;z perusteella.</li>
	</ul>
</blockquote>
<h3>Otsikkomuotojen k�ytt�</h3>
<p>Vain 1XX-kent�n vahvistettua otsikkomuotoa 
voidaan k�ytt�� bibliografisissa tietueissa hakuelementtin�. Nimi�, 
tekij�/nimekkeit� ja yhten�istettyj� nimekkeit� voidaan k�ytt�� <strong>p��- tai 
lis�kirjauksina</strong> (008/14, koodi <strong>a</strong>); nimi�, tekij�/nimekkeit� ja 
yhten�istettyj� nimekkeit�, aihetta ja lajityyppi�/muotoa ilmaisevia termej� 
sek� asiasanaketjuja voidaan k�ytt�� <strong>asiasanoina</strong> (008/15, koodi
<strong>a</strong>); tekij�/nimekkeit� ja yhten�istettyj� nimekkeit� voidaan k�ytt�� <strong>
sarjalis�kirjauksina</strong> (008/16, koodi <strong>a</strong>). Lis�m��reiden otsikkomuotoja voidaan k�ytt�� vain asiasanaketjuissa.</p>
<h3>Nimi- ja asiasana-auktoriteetit</h3>
<p>Otsikkomuoto voidaan m��ritell� soveltuvaksi joko nimi- tai 
asiasana-auktoriteetin rakenteeseen.</p>
<p>Otsikkomuodot, jotka on laadittu luettelointis��nt�jen k�yt�nt�jen mukaisesti 
(008/10) ovat soveltuvia <strong>nimiauktoriteeteiksi</strong>. N�it� ovat nimien, 
tekij�/nimekkeiden ja yhten�istettyjen nimekkeiden otsikkomuodot 
vahvistettujen otsikkomuotojen tietueissa sek� vahvistettujen otsikkomuotojen ja lis�m��reiden tietueissa, ja n�iden vahvistamattomat 
otsikkomuodot 
viittaustietueissa. Tiettyj� 
huomautus- ja viittauskentti� voidaan k�ytt�� vain nimiauktoriteeteissa.</p>
<p>Otsikkomuodot, jotka on laadittu jonkin asiasanaston k�yt�nt�jen mukaisesti (008/11) 
ovat soveltuvia <strong>asiasanoiksi</strong>. N�it� ovat nimien, 
tekij�/nimekkeiden, yhten�istettyjen nimekkeiden, aihetta, aikaa tai 
lajityyppi�/muotoa ilmaisevien termien (sek� n�ist� laadittujen asiasanaketjujen) otsikkomuodot vahvistettujen otsikkomuotojen tietueissa 
sek� vahvistettujen otsikkomuotojen ja lis�m��reiden tietueissa. N�iden 
vahvistamattomia otsikkomuotoja k�ytet��n viittaustietueissa sek� viittaus ja lis�m��re 
-tietueissa. Vahvistamattomia otsikkomuotoja k�ytet��n my�s 
alanmukaisen ryhm�n otsikkotietueissa. Tiettyj� huomautus- ja viittauskentti� 
voidaan k�ytt�� vain asiasana-auktoriteeteissa.</p>
<p><a href="#alku">Sivun alkuun</a></p>
<hr/>
  </xsl:template>

  <xsl:template name="yleista7xx">
<h3><a name="yleista"></a>LINKKIKENT�T--YLEIST� TIETOA</h3>
<p>Vahvistettujen otsikkomuotojen tai otsikkomuodon ja lis�m��reen 
tietueisiin voidaan lis�t� linkkikentti� nimille, tekij�/nimekkeille, yhten�istetyille 
nimekkeille, aihetta tai muotoa ilmaiseville termeille, tai asiasanaketjuille sek� vahvistettujen otsikkomuotojen tietueisiin 
ohjeelliselle asialis�m��reelle. Linkkikentt� linkitt�� edell� mainittuja niihin liittyviin otsikkomuotoihin esim. seuraavanlaisissa tapauksissa:</p>
<ul>
	<li>Vastaavat nimet monikielisess� asiasanastossa<ul>
		<li>Esimerkki: LAC:n englanninkielinen otsikkomuoto <em>Francis, of Assisi, Saint, 1182-1226</em> 
		ja LAC:n ranskankielinen otsikkomuoto <em>Fran�ois, d'Assise, saint, 1182-1226</em></li>
	</ul>
	</li>
	<li>Vastaavat aihetta ilmaisevat termit eri auktoriteettij�rjestelmiss�<ul>
		<li>Esimerkki: LCSH:n otsikkomuodot <em>Medical referral</em> ja <em>Medical consultation</em>, 
		ja MeSH:n otsikkomuoto <em>Referral and Consultation</em></li>
	</ul>
	</li>
	<li>Aihetta ilmaisevan termin otsikkomuoto (kentt� 150) ja sama tai 
	samankaltainen termi asialis�m��reen� (kentt� 78X)<ul>
		<li>Esimerkki: vahvistettu termi <em>History</em> ja asialis�m��re
		<em>History</em></li>
		<li>Esimerkki: vahvistettu termi <em>Twentieth century</em> ja asialis�m��re <em>20th century</em></li>
	</ul>
	</li>
	<li>Maantieteellisen nimen otsikkomuoto (kentt� 151) ja saman nimen 
	ep�suora muoto, jota k�ytet��n maantieteellisen� asialis�m��reen� (kentt� 781)<ul>
		<li>Esimerkki: vahvistettu otsikkomuoto <em>Rome (N.Y.)</em> ja 
		asialis�m��re <em>New York (State) -- Rome</em>.</li>
	</ul>
	</li>
	<li>Lajityyppi�/muotoa ilmaisevan termin otsikkomuoto (kentt� 
155) ja sama tai samankaltainen termi, jota k�ytet��n asiasanan muotoa 
	ilmaisevana asialis�m��reen� (kentt� 785)<ul>
		<li>Esimerkki: vahvistettu otsikkomuoto <em>Periodicals</em> ja 
		asialis�m��re <em>Periodicals</em>.</li>
	</ul>
	</li>
</ul>
<p>Kent�t 700-755 sis�lt�v�t vahvistettuja otsikkomuotoja ja kent�t 780-785 
vahvistettuja lis�m��reiden otsikkomuotoja. Toisen indikaattorin tai osakent�n &#8225;2 avulla 
ilmaistaan auktoriteettij�rjestelm�, johon 7XX-kentt��n merkitty otsikkomuoto kuuluu. Kun 7XX-muodosta on tehty erillinen auktoriteettitietue, 
sen kontrollinumero kent�st� 035 tallennetaan 
7XX-kent�n osakentt��n &#8225;0 (Tietueen kontrollinumero).</p>
<p>Kentt��n 788 tallennetaan vapaamuotoinen kuvaus eri otsikkomuotojen suhteesta, kun 
suhdetta ei voida kuvata 700-785 linkkikenttien avulla kyllin hyvin.</p>
<p>Ohjeet toisen indikaattorin, osakent�n &#8225;2 (Asiasanan tai termin l�hde) ja 
osakent�n &#8225;w (Kontrollitiedot) k�yt�st� l�ytyv�t t�st� osiosta. Kenttien 700-785 
muita indikaattoreita ja osakentti� koskevat ohjeet l�ytyv�t kunkin kent�n 
kohdalta.</p>
<h4>Indikaattorit</h4>
<ul>
	<li>Ensimm�inen<br/>
	Jokaisen 7XX-kent�n ensimm�isen indikaattorin m��ritelm� on sama kuin 
	vastaavassa <a href="1XX.htm">1XX-kent�ss�</a>, joten selityksen voi tarkistaa sielt�.</li>
	<li>Toinen - Asiasanasto<br/>
	Asiasanasto tai auktoriteettitiedosto, josta asiasana on per�isin.<ul>
		<li><strong>0</strong> - Library of Congress Subject Headings (LCSH) / LC name authority file</li>
		<li><strong>1</strong> - LC subject headings for children's literature</li>
		<li><strong>2</strong> - Medical Subject Headings (MeSH) / NLM name authority file</li>
		<li><strong>3</strong> - National Agricultural Library subject authority file (NAL)</li>
		<li><strong>4</strong> - Asiasanastoa ei ole m��ritelty<br/>
		Asiasana on per�isin kontrolloidusta asiasanastosta tai 
		auktoriteettitiedostosta, mutta mik��n muista indikaattoriarvoista tai 
		osakent�n &#8225;2 koodeista ei ole sille soveltuva.</li>
		<li><strong>5</strong> - Canadian Subject Headings / LAC name authority file</li>
		<li><strong>6</strong> - R�pertoire de vedettes-mati�re</li>
		<li><strong>7</strong> - Asiasanasto m��ritelty osakent�ss� &#8225;2</li>
	</ul>
	</li>
</ul>
<h4>Erikoisosakent�t</h4>
<p>7XX-kenttien osakent�t ovat p��osin samat kuin vastaavassa <a href="1XX.htm">1XX-kent�ss�</a>, 
joten selityksen voi tarkistaa sielt�. 7XX-kenttien osakenttien &#8225;w ja &#8225;2 
kuvaukset l�ytyv�t t�st� osiosta.</p>
<ul>
	<li><strong>&#8225;i</strong> - Tieto suhteesta (T)<br/>
	Osakentt�, johon tallennetaan tekstimuodossa kent�ss� 7XX olevan ...
	</li>
	<li><strong>&#8225;w</strong> - Kontrollitiedot (ET)<br/>
	Kaksi kiinte�t� merkkipaikkaa (merkit��n &#8225;w/0 ja &#8225;w/1), jotka kontrolloivat 
	linkkin�yt�n muodostumista tai kertovat 700-785 kenttien otsikkomuodon 
	monitahoisuudesta. Osakentt�� &#8225;w k�ytet��n vain, jos n�ytt�� ei haluta 
	muodostaa tai 
	jos otsikkomuodon korvaamista pit�isi harkita uudelleen.<ul>
		<li>/<strong>0</strong> - Linkkin�ytt�<br/>
		Yksimerkkinen kirjainkoodi, joka kontrolloi linkin n�ytt�mist� kentist� 
		700-785.<ul>
			<li><strong>a</strong> - Linkki� ei n�ytet�<br/>
			K�ytet��n j�rjestelm�riippuvaisista syist�, kun koodeja <strong>b</strong> tai
			<strong>c</strong> ei voida k�ytt��. Tietueita vaihdettaessa koodi <strong>a</strong> 
			muunnetaan koodiksi <strong>n</strong> tai t�ytt�merkiksi (<strong>|</strong>).</li>
			<li><strong>b</strong> - Linkki� ei n�ytet�, k�ytet��n kentt�� 788</li>
			<li><strong>c</strong> - Linkki� ei n�ytet�, ei k�ytet� 7XX-kentti�</li>
			<li><strong>n</strong> - Soveltumaton<br/>
			K�ytet��n, kun 7XX-kent�n linkin n�ytt�miselle ei ole rajoituksia. 
			Merkkipaikkaa &#8225;w/0 ei tarvitse t�ytt��, jos koodi <strong>n</strong> soveltuu.</li>
		</ul>
		</li>
		<li>/<strong>1</strong> - Korvaamisen monitahoisuus<br/>
		Yksimerkkinen kirjainkoodi, joka osoittaa onko kenttien 700-785 
		otsikkomuodot mahdollista korvata automaattisesti.<ul>
			<li><strong>a</strong> - Otsikkomuodon korvaaminen ei vaadi uudelleenharkintaa</li>
			<li><strong>b</strong> - Otsikkomuodon korvaaminen vaatii uudelleenharkintaa</li>
			<li><strong>n</strong> - Soveltumaton<br/>
			Merkkipaikkaa &#8225;w/1 ei tarvitse t�ytt��, jos koodi <strong>n</strong> soveltuu.</li>
		</ul>
		</li>
	</ul>
	</li>
	<li><strong>&#8225;2</strong> - Asiasanan tai termin l�hde (ET)<br/>
	MARC-koodi, joka identifioi k�ytetyn asiasanaston, kun toisen indikaattorin 
	arvo on 7. Koodi otetaan listalta, ks. <em>
	<a href="http://www.loc.gov/marc/relators/relasour.html">MARC Code Lists for Relators, Sources, Description Conventions: PART IV: Term, Name, Title Sources</a></em>.</li>
	<li><strong>&#8225;4</strong> - Koodi suhteelle (T)<br/>
	Koodatussa muodossa kent�ss� 7XX olevan ... Koodi otetaan listalta, ks. <em> ISO 25964-2: Thesauri and interoperability with other vocabularies - Part 2: Interoperability with other vocabularies,</em> Section 4, Table 1.
	</li>
</ul>
<h4>Esimerkkej�</h4>
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
