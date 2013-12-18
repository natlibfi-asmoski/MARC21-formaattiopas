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
P�ivitetty viimeksi 18.12.2013.<br />
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
		<li>850 on bibliografisen tietueen kentt�, joka sis�lt�� minimitason varasto- ja sijaintitiedot.</li>
		<li>852 sis�lt�� tarkempia sijaintitietoja.</li>
		<li>856 sis�lt�� tietoja elektronisen aineiston sijainnista.</li>
		<li>880, 886 ja 887 ovat erityisk�ytt��n tarkoitettuja bibliografisen tiedon kentti�.</li>
	</ul>
</blockquote>
<p>Yll�mainitut kent�t on kuvattu t�ss� dokumentissa. Kent�t 841-845, 853-855 ja
863-878 on vain listattu alla, ja niiden tarkempi kuvaus l�ytyy MARC 21
varastotietojen formaatista.</p>
      </xsl:if>
    <ul>
      <xsl:for-each select="datafield">
	    <xsl:choose>
        <xsl:when test="@tag='760'">
	        <li><a href="#yleista">TIETUELINKIT JA VAKION�YTT�TEKSTIT--YLEIST� TIETOA</a></li>
        </xsl:when>
        <xsl:when test="@tag='850'">
        	<li>841 - VARASTOTIEDOT KOODEINA (ET)
        		ks. <i><a href="../hold/5XX-84X.htm#841">Varastotietojen formaatti</a></i></li>
        	<li>842 - ULKOASU TEKSTIN� (ET)
        		ks. <i><a href="../hold/5XX-84X.htm#842">Varastotietojen formaatti</a></i></li>
        	<li>843 - HUOMAUTUS J�LJENTEEST� (T)
        		ks. <i><a href="../hold/5XX-84X.htm#843">Varastotietojen formaatti</a></i></li>
        	<li>844 - YKSIK�N NIMI (ET)
        		ks. <i><a href="../hold/5XX-84X.htm#844">Varastotietojen formaatti</a></i></li>
        	<li>845 - HUOMAUTUS K�YT�N JA KOPIOINNIN EHDOISTA (T)
        		ks. <i><a href="../hold/5XX-84X.htm#845">Varastotietojen formaatti</a></i></li>
        </xsl:when>
        <xsl:when test="@tag='856'">
        	<li>853 - ILMESTYMISTIEDOT--BIBLIOGRAFINEN PERUSYKSIKK� (T)
        		ks. <i><a href="../hold/853-855.htm#853">Varastotietojen formaatti</a></i></li>
        	<li>854 - ILMESTYMISTIEDOT--OHEISAINEISTO YMS. (T)
        		ks. <i><a href="../hold/853-855.htm#854">Varastotietojen formaatti</a></i></li>
        	<li>855 - ILMESTYMISTIEDOT--HAKEMISTO YMS. (T)
        		ks. <i><a href="../hold/853-855.htm#855">Varastotietojen formaatti</a></i></li>
        </xsl:when>
        <xsl:when test="@tag='880'">
        	<li>863 - M��R�MUOTOISET VARASTOTIEDOT--BIBLIOGRAFINEN PERUSYKSIKK� (T)
        		ks. <i><a href="../hold/863-865.htm#863">Varastotietojen formaatti</a></i></li>
        	<li>864 - M��R�MUOTOISET VARASTOTIEDOT--OHEISAINEISTO YMS. (T)
        		ks. <i><a href="../hold/863-865.htm#864">Varastotietojen formaatti</a></i></li>
        	<li>865 - M��R�MUOTOISET VARASTOTIEDOT--HAKEMISTO YMS. (T)
        		ks. <i><a href="../hold/863-865.htm#865">Varastotietojen formaatti</a></i></li>
        	<li>866 - VAPAAMUOTOISET VARASTOTIEDOT--BIBLIOGRAFINEN PERUSYKSIKK� (T)
        		ks. <i><a href="../hold/866-868.htm#866">Varastotietojen formaatti</a></i></li>
        	<li>867 - VAPAAMUOTOISET VARASTOTIEDOT--OHEISAINEISTO YMS. (T)
        		ks. <i><a href="../hold/866-868.htm#867">Varastotietojen formaatti</a></i></li>
        	<li>868 - VAPAAMUOTOISET VARASTOTIEDOT--HAKEMISTO YMS. (T)
        		ks. <i><a href="../hold/866-868.htm#868">Varastotietojen formaatti</a></i></li>
        	<li>876 - KAPPALETIEDOT--BIBLIOGRAFINEN PERUSYKSIKK� (T)
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

  <xsl:template name="yleista">
<h3><a name="yleista"></a>TIETUELINKIT JA VAKION�YTT�TEKSTIT--YLEIST� TIETOA</h3>
<p>MARC-formaatissa k�ytetty tietueiden linkitystekniikka kuvataan alla.</p>
<p><strong>Linkkikent�t (kent�t 760-787)</strong></p>
<blockquote>
	<p>N�m� kent�t sis�lt�v�t liittyv�n kohteen kuvailua tai sen
	kontrollinumeron (001) tai molemmat. Linkkikenttiin sis�ltyy vain
	v�himm�ism��r� liittyv�n kohteen kuvailua, ja t�ydellisemp��n kuvailuun
	voidaan muodostaa linkki osakentt��n &#8225;w tallennetun liittyv�n kohteen
	kontrollinumeron avulla.</p>
	<p>Lis�ksi, kooditiedot osakent�ss� &#8225;7 mahdollistavat jonkintasoisen
	tiedonhaun my�s ilman viittausta liittyv��n tietueeseen. Linkkikenttien
	ensimm�isen indikaattorin arvo m��rittelee muodostetaanko kent�st�
	vakion�ytt�teksti.</p>
</blockquote>
<p><strong>Huomautus linkitysten monitahoisuudesta (kentt� 580)</strong></p>
<blockquote>
	<p>Linkkikent�t on suunniteltu siten, ett� niiden avulla on mahdollista
	muodostaa kuvailun kohteen tietueeseen vakion�ytt�teksti liittyv�st� kohteesta. Kun
	suhde on liian monitahoinen ilmaistavaksi vakion�ytt�tekstin ja linkkikent�n
	sis�lt�mien tietojen avulla, tieto tallennetaan kentt��n 580 (Huomautus
	linkitysten monitahoisuudesta). Kun huomautuskentt�� k�ytet��n jonkin
	tarkoitukseen sopivan linkkikent�n 760-780 kanssa, t�ll�in linkkikent�st� ei
	muodosteta n�ytt�teksti�.</p>
</blockquote>
<p><strong>Linkitys (nimi�/19)</strong></p>
<blockquote>
	<p>T�m� koodi ilmaisee, sis�lt��k� linkkikentt� tarpeeksi tietoa, jotta
	liittyv�� kohdetta koskeva ymm�rrett�v� n�ytt�teksti voidaan muodostaa, vai onko
	linkkikentt��n tallennettu vain liittyv�n kohteen tietueen kontrollinumero. Jos
	tietueesta l�ytyy vain kontrollinumero, j�rjestelm�n pit�� noutaa
	n�ytt��n tarvittavat tiedot liittyv�n kohteen tietueesta.</p>
	<p>Seuraavat osakent�t tai osakentt�yhdistelm�t ovat riitt�vi� n�yt�n
	muodostamiseen:</p>
	<ul>
		<li>Osakentt� &#8225;a + &#8225;t (P��kirjauksen otsikko + Nimeke)</li>
		<li>Osakentt� &#8225;a + &#8225;s (P��kirjauksen otsikko + Yhten�istetty nimeke)</li>
		<li>Osakentt� &#8225;t (Nimeke)</li>
		<li>Osakentt� &#8225;u (ISRN-tunnus, International Standard Technical Report Number)</li>
		<li>Osakentt� &#8225;r (Raporttinumero)</li>
	</ul>
</blockquote>
<p><strong>Lis�kirjauskent�t (kent�t 700-730)</strong></p>
<blockquote>
	<p>Kun luettelointis��nt�jen mukaan linkkikent�ss� k�ytetylle nimekkeelle
	tarvitaan lis�kirjaus, se tallennetaan sopivaan lis�kirjauskentt��n 700-730.
	Linkkikentti� ei voi k�ytt�� lis�kirjausten sijaan. Niin ik��n lis�kirjausta
	ei voida k�ytt�� linkkikentt�n�, koska sen avulla ei voida muodostaa
	n�ytt�teksti� tai linkki� liittyv��n tietueeseen.</p>
</blockquote>
<p><strong>Osakohteet / Kokonaisuuden osat</strong></p>
<blockquote>
	<p>Kentt�� 773 (Linkkikentt� - emokohde) k�ytet��n linkitt�m��n osakohde
	tai kokonaisuuden osa liittyv��n kohteeseen eli emokohteeseen. Esimerkiksi lehtiartikkelia kuvailevassa
	tietueessa kentt� 773 sis�lt�� kyseisen lehden tiedot. Osakentt��n &#8225;g
	tallennetaan artikkelin tarkka sijainti lehdess�. Emokohdetta (esim.
	julkaisua tai kokoelmaa) kuvaileva tietue voi sis�lt�� tietoja osakohteista
	tai kokonaisuuden osista toistetuissa kentiss� 774 (Linkkikentt� - osakohde). Tiedot jokaisesta
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
