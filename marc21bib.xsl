<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

  <xsl:output method="html"/>
  <xsl:template match="/">
<html>

<head>
<meta http-equiv="Content-Language" content="fi" />
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>MARC 21: Bibliografiset tiedot</title>
</head>

<body>
<a name="alku"></a>

<center>
<table border="2" width="600" bordercolor="#000000" id="table1" bgcolor="#66CCFF">
	<tr>
		<td>
		<p align="center">Kansalliskirjasto</p>
		<h1 align="center">MARC 21 -formaatti:<br />
		BIBLIOGRAFISET TIEDOT</h1>
		</td>
	</tr>
</table>
</center>
<p align="center">
<i><span style="background-color: #FFFF00">
Päivitetty viimeksi 28.10.2013.<br />
Ks. <a href="../ohje.htm">Ohjeita formaattien kommentointiin</a>.</span></i></p>
      <xsl:apply-templates/>
<p><a href="index.htm">Bibliografiset tiedot -etusivulle</a> | <a href="../index.htm">MARC 21 -etusivulle</a></p>
<hr/>
<p>&#160;</p>
</body>
</html>
  </xsl:template>


  <xsl:template match="leader-directory">
<h2 align="left"><xsl:value-of select="title"/></h2>
<p><a href="index.htm">Bibliografiset tiedot -etusivulle</a> |
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
    <xsl:if test="parent != 'subfield'">
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
    <p><a href="index.htm">Bibliografiset tiedot -etusivulle</a> |
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
    <p><a href="index.htm">Bibliografiset tiedot -etusivulle</a> |
    <a href="../index.htm">MARC 21 -etusivulle</a></p>
    <hr/>

    <p><xsl:apply-templates select="description"/></p>
	    <xsl:if test="datafield[@tag='850']">
<blockquote>
	<ul>
		<li>850 on bibliografisen tietueen kenttä, joka sisältää minimitason varasto- ja sijaintitiedot.</li>
		<li>852 sisältää tarkempia sijaintitietoja.</li>
		<li>856 sisältää tietoja elektronisen aineiston sijainnista.</li>
		<li>880, 886 ja 887 ovat erityiskäyttöön tarkoitettuja bibliografisen tiedon kenttiä.</li>
	</ul>
</blockquote>
<p>Yllämainitut kentät on kuvattu tässä dokumentissa. Kentät 841-845, 853-855 ja
863-878 on vain listattu alla, ja niiden tarkempi kuvaus löytyy MARC 21
varastotietojen formaatista.</p>
      </xsl:if>
    <ul>
      <xsl:for-each select="datafield">
	    <xsl:choose>
        <xsl:when test="@tag='760'">
	        <li><a href="#yleista">TIETUELINKIT JA VAKIONÄYTTÖTEKSTIT--YLEISTÄ TIETOA</a></li>
        </xsl:when>
        <xsl:when test="@tag='850'">
        	<li>841 - VARASTOTIEDOT KOODEINA (ET)
        		ks. <i><a href="../hold/5XX-84X.htm#841">Varastotietojen formaatti</a></i></li>
        	<li>842 - ULKOASU TEKSTINÄ (ET)
        		ks. <i><a href="../hold/5XX-84X.htm#842">Varastotietojen formaatti</a></i></li>
        	<li>843 - HUOMAUTUS JÄLJENTEESTÄ (T)
        		ks. <i><a href="../hold/5XX-84X.htm#843">Varastotietojen formaatti</a></i></li>
        	<li>844 - YKSIKÖN NIMI (ET)
        		ks. <i><a href="../hold/5XX-84X.htm#844">Varastotietojen formaatti</a></i></li>
        	<li>845 - HUOMAUTUS KÄYTÖN JA KOPIOINNIN EHDOISTA (T)
        		ks. <i><a href="../hold/5XX-84X.htm#845">Varastotietojen formaatti</a></i></li>
        </xsl:when>
        <xsl:when test="@tag='856'">
        	<li>853 - ILMESTYMISTIEDOT--BIBLIOGRAFINEN PERUSYKSIKKÖ (T)
        		ks. <i><a href="../hold/853-855.htm#853">Varastotietojen formaatti</a></i></li>
        	<li>854 - ILMESTYMISTIEDOT--OHEISAINEISTO YMS. (T)
        		ks. <i><a href="../hold/853-855.htm#854">Varastotietojen formaatti</a></i></li>
        	<li>855 - ILMESTYMISTIEDOT--HAKEMISTO YMS. (T)
        		ks. <i><a href="../hold/853-855.htm#855">Varastotietojen formaatti</a></i></li>
        </xsl:when>
        <xsl:when test="@tag='880'">
        	<li>863 - MÄÄRÄMUOTOISET VARASTOTIEDOT--BIBLIOGRAFINEN PERUSYKSIKKÖ (T)
        		ks. <i><a href="../hold/863-865.htm#863">Varastotietojen formaatti</a></i></li>
        	<li>864 - MÄÄRÄMUOTOISET VARASTOTIEDOT--OHEISAINEISTO YMS. (T)
        		ks. <i><a href="../hold/863-865.htm#864">Varastotietojen formaatti</a></i></li>
        	<li>865 - MÄÄRÄMUOTOISET VARASTOTIEDOT--HAKEMISTO YMS. (T)
        		ks. <i><a href="../hold/863-865.htm#865">Varastotietojen formaatti</a></i></li>
        	<li>866 - VAPAAMUOTOISET VARASTOTIEDOT--BIBLIOGRAFINEN PERUSYKSIKKÖ (T)
        		ks. <i><a href="../hold/866-868.htm#866">Varastotietojen formaatti</a></i></li>
        	<li>867 - VAPAAMUOTOISET VARASTOTIEDOT--OHEISAINEISTO YMS. (T)
        		ks. <i><a href="../hold/866-868.htm#867">Varastotietojen formaatti</a></i></li>
        	<li>868 - VAPAAMUOTOISET VARASTOTIEDOT--HAKEMISTO YMS. (T)
        		ks. <i><a href="../hold/866-868.htm#868">Varastotietojen formaatti</a></i></li>
        	<li>876 - KAPPALETIEDOT--BIBLIOGRAFINEN PERUSYKSIKKÖ (T)
        		ks. <i><a href="../hold/876-878.htm#876">Varastotietojen formaatti</a></i></li>
        	<li>877 - KAPPALETIEDOT--OHEISAINEISTO YMS. (T)
        		ks. <i><a href="../hold/876-878.htm#877">Varastotietojen formaatti</a></i></li>
        	<li>878 - KAPPALETIEDOT--HAKEMISTO YMS. (T)
        		ks. <i><a href="../hold/876-878.htm#878">Varastotietojen formaatti</a></i></li>
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
    <xsl:choose><xsl:when test="@tag='760'">
      <xsl:call-template name="yleista"/>
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

  <xsl:template name="yleista">
<h3><a name="yleista"></a>TIETUELINKIT JA VAKIONÄYTTÖTEKSTIT--YLEISTÄ TIETOA</h3>
<p>MARC-formaatissa käytetty tietueiden linkitystekniikka kuvataan alla.</p>
<p><strong>Linkkikentät (kentät 760-787)</strong></p>
<blockquote>
	<p>Nämä kentät sisältävät liittyvän kohteen kuvailua tai sen
	kontrollinumeron (001) tai molemmat. Linkkikenttiin sisältyy vain
	vähimmäismäärä liittyvän kohteen kuvailua, ja täydellisempään kuvailuun
	voidaan muodostaa linkki osakenttään &#8225;w tallennetun liittyvän kohteen
	kontrollinumeron avulla.</p>
	<p>Lisäksi, kooditiedot osakentässä &#8225;7 mahdollistavat jonkintasoisen
	tiedonhaun myös ilman viittausta liittyvään tietueeseen. Linkkikenttien
	ensimmäisen indikaattorin arvo määrittelee muodostetaanko kentästä
	vakionäyttöteksti.</p>
</blockquote>
<p><strong>Huomautus linkitysten monitahoisuudesta (kenttä 580)</strong></p>
<blockquote>
	<p>Linkkikentät on suunniteltu siten, että niiden avulla on mahdollista
	muodostaa kuvailun kohteen tietueeseen vakionäyttöteksti liittyvästä kohteesta. Kun
	suhde on liian monitahoinen ilmaistavaksi vakionäyttötekstin ja linkkikentän
	sisältämien tietojen avulla, tieto tallennetaan kenttään 580 (Huomautus
	linkitysten monitahoisuudesta). Kun huomautuskenttää käytetään jonkin
	tarkoitukseen sopivan linkkikentän 760-780 kanssa, tällöin linkkikentästä ei
	muodosteta näyttötekstiä.</p>
</blockquote>
<p><strong>Linkitys (nimiö/19)</strong></p>
<blockquote>
	<p>Tämä koodi ilmaisee, sisältääkö linkkikenttä tarpeeksi tietoa, jotta
	liittyvää kohdetta koskeva ymmärrettävä näyttöteksti voidaan muodostaa, vai onko
	linkkikenttään tallennettu vain liittyvän kohteen tietueen kontrollinumero. Jos
	tietueesta löytyy vain kontrollinumero, järjestelmän pitää noutaa
	näyttöön tarvittavat tiedot liittyvän kohteen tietueesta.</p>
	<p>Seuraavat osakentät tai osakenttäyhdistelmät ovat riittäviä näytön
	muodostamiseen:</p>
	<ul>
		<li>Osakenttä &#8225;a + &#8225;t (Pääkirjauksen otsikko + Nimeke)</li>
		<li>Osakenttä &#8225;a + &#8225;s (Pääkirjauksen otsikko + Yhtenäistetty nimeke)</li>
		<li>Osakenttä &#8225;t (Nimeke)</li>
		<li>Osakenttä &#8225;u (ISRN-tunnus, International Standard Technical Report Number)</li>
		<li>Osakenttä &#8225;r (Raporttinumero)</li>
	</ul>
</blockquote>
<p><strong>Lisäkirjauskentät (kentät 700-730)</strong></p>
<blockquote>
	<p>Kun luettelointisääntöjen mukaan linkkikentässä käytetylle nimekkeelle
	tarvitaan lisäkirjaus, se tallennetaan sopivaan lisäkirjauskenttään 700-730.
	Linkkikenttiä ei voi käyttää lisäkirjausten sijaan. Niin ikään lisäkirjausta
	ei voida käyttää linkkikenttänä, koska sen avulla ei voida muodostaa
	näyttötekstiä tai linkkiä liittyvään tietueeseen.</p>
</blockquote>
<p><strong>Osakohteet / Kokonaisuuden osat</strong></p>
<blockquote>
	<p>Kenttää 773 (Linkkikenttä - emokohde) käytetään linkittämään osakohde
	tai kokonaisuuden osa liittyvään kohteeseen eli emokohteeseen. Esimerkiksi lehtiartikkelia kuvailevassa
	tietueessa kenttä 773 sisältää kyseisen lehden tiedot. Osakenttään &#8225;g
	tallennetaan artikkelin tarkka sijainti lehdessä. Emokohdetta (esim.
	julkaisua tai kokoelmaa) kuvaileva tietue voi sisältää tietoja osakohteista
	tai kokonaisuuden osista toistetuissa kentissä 774 (Linkkikenttä - osakohde). Tiedot jokaisesta
	osasta tallennetaan erillisiin 774-kenttiin.</p>
</blockquote>
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
