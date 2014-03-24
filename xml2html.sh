#!/bin/bash

function error {
    echo "Conversion failed. See the error above."
    exit
}

# Bibliographic

java -jar saxon/saxon8.jar -t bib/000.xml     bib/marc21bib.xsl > bib/000.htm
if [ $? -ne 0 ]; then error; fi

java -jar saxon/saxon8.jar -t bib/001-006.xml bib/marc21bib.xsl > bib/001-006.htm
if [ $? -ne 0 ]; then error; fi

java -jar saxon/saxon8.jar -t bib/007.xml     bib/marc21bib.xsl > bib/007.htm
if [ $? -ne 0 ]; then error; fi

java -jar saxon/saxon8.jar -t bib/008.xml     bib/marc21bib.xsl > bib/008.htm
if [ $? -ne 0 ]; then error; fi

java -jar saxon/saxon8.jar -t bib/01X-04X.xml bib/marc21bib.xsl > bib/01X-04X.htm
if [ $? -ne 0 ]; then error; fi

java -jar saxon/saxon8.jar -t bib/05X-08X.xml bib/marc21bib.xsl > bib/05X-08X.htm
if [ $? -ne 0 ]; then error; fi

java -jar saxon/saxon8.jar -t bib/1XX.xml     bib/marc21bib.xsl > bib/1XX.htm
if [ $? -ne 0 ]; then error; fi

java -jar saxon/saxon8.jar -t bib/20X-24X.xml bib/marc21bib.xsl > bib/20X-24X.htm
if [ $? -ne 0 ]; then error; fi

java -jar saxon/saxon8.jar -t bib/250-270.xml bib/marc21bib.xsl > bib/250-270.htm
if [ $? -ne 0 ]; then error; fi

java -jar saxon/saxon8.jar -t bib/3XX.xml     bib/marc21bib.xsl > bib/3XX.htm
if [ $? -ne 0 ]; then error; fi

java -jar saxon/saxon8.jar -t bib/4XX.xml     bib/marc21bib.xsl > bib/4XX.htm
if [ $? -ne 0 ]; then error; fi

java -jar saxon/saxon8.jar -t bib/50X-53X.xml bib/marc21bib.xsl > bib/50X-53X.htm
if [ $? -ne 0 ]; then error; fi

java -jar saxon/saxon8.jar -t bib/53X-58X.xml bib/marc21bib.xsl > bib/53X-58X.htm
if [ $? -ne 0 ]; then error; fi

java -jar saxon/saxon8.jar -t bib/6XX.xml     bib/marc21bib.xsl > bib/6XX.htm
if [ $? -ne 0 ]; then error; fi

java -jar saxon/saxon8.jar -t bib/70X-75X.xml bib/marc21bib.xsl > bib/70X-75X.htm
if [ $? -ne 0 ]; then error; fi

java -jar saxon/saxon8.jar -t bib/76X-78X.xml bib/marc21bib.xsl > bib/76X-78X.htm
if [ $? -ne 0 ]; then error; fi

java -jar saxon/saxon8.jar -t bib/80X-830.xml bib/marc21bib.xsl > bib/80X-830.htm
if [ $? -ne 0 ]; then error; fi

java -jar saxon/saxon8.jar -t bib/841-88X.xml bib/marc21bib.xsl > bib/841-88X.htm
if [ $? -ne 0 ]; then error; fi

java -jar saxon/saxon8.jar -t bib/9XX.xml     bib/marc21bib.xsl > bib/9XX.htm
if [ $? -ne 0 ]; then error; fi

# Authority

java -jar saxon/saxon8.jar -t aukt/000.xml     aukt/marc21auth.xsl > aukt/000.htm
if [ $? -ne 0 ]; then error; fi

java -jar saxon/saxon8.jar -t aukt/00X.xml     aukt/marc21auth.xsl > aukt/00X.htm
if [ $? -ne 0 ]; then error; fi

java -jar saxon/saxon8.jar -t aukt/01X-09X.xml aukt/marc21auth.xsl > aukt/01X-09X.htm
if [ $? -ne 0 ]; then error; fi

java -jar saxon/saxon8.jar -t aukt/1XX.xml     aukt/marc21auth.xsl > aukt/1XX.htm
if [ $? -ne 0 ]; then error; fi

java -jar saxon/saxon8.jar -t aukt/2XX-3XX.xml aukt/marc21auth.xsl > aukt/2XX-3XX.htm
if [ $? -ne 0 ]; then error; fi

java -jar saxon/saxon8.jar -t aukt/4XX.xml     aukt/marc21auth.xsl > aukt/4XX.htm
if [ $? -ne 0 ]; then error; fi

java -jar saxon/saxon8.jar -t aukt/5XX.xml     aukt/marc21auth.xsl > aukt/5XX.htm
if [ $? -ne 0 ]; then error; fi

java -jar saxon/saxon8.jar -t aukt/64X.xml     aukt/marc21auth.xsl > aukt/64X.htm
if [ $? -ne 0 ]; then error; fi

java -jar saxon/saxon8.jar -t aukt/663-666.xml aukt/marc21auth.xsl > aukt/663-666.htm
if [ $? -ne 0 ]; then error; fi

java -jar saxon/saxon8.jar -t aukt/667-68X.xml aukt/marc21auth.xsl > aukt/667-68X.htm
if [ $? -ne 0 ]; then error; fi

java -jar saxon/saxon8.jar -t aukt/7XX.xml     aukt/marc21auth.xsl > aukt/7XX.htm
if [ $? -ne 0 ]; then error; fi

java -jar saxon/saxon8.jar -t aukt/8XX.xml     aukt/marc21auth.xsl > aukt/8XX.htm
if [ $? -ne 0 ]; then error; fi

# Holdings

java -jar saxon/saxon8.jar -t hold/000.xml     hold/marc21hold.xsl > hold/000.htm
if [ $? -ne 0 ]; then error; fi

java -jar saxon/saxon8.jar -t hold/001-008.xml hold/marc21hold.xsl > hold/001-008.htm
if [ $? -ne 0 ]; then error; fi

java -jar saxon/saxon8.jar -t hold/0XX.xml     hold/marc21hold.xsl > hold/0XX.htm
if [ $? -ne 0 ]; then error; fi

java -jar saxon/saxon8.jar -t hold/5XX-84X.xml hold/marc21hold.xsl > hold/5XX-84X.htm
if [ $? -ne 0 ]; then error; fi

java -jar saxon/saxon8.jar -t hold/852-856.xml hold/marc21hold.xsl > hold/852-856.htm
if [ $? -ne 0 ]; then error; fi

java -jar saxon/saxon8.jar -t hold/853-855.xml hold/marc21hold.xsl > hold/853-855.htm
if [ $? -ne 0 ]; then error; fi

java -jar saxon/saxon8.jar -t hold/863-865.xml hold/marc21hold.xsl > hold/863-865.htm
if [ $? -ne 0 ]; then error; fi

java -jar saxon/saxon8.jar -t hold/866-868.xml hold/marc21hold.xsl > hold/866-868.htm
if [ $? -ne 0 ]; then error; fi

java -jar saxon/saxon8.jar -t hold/876-878.xml hold/marc21hold.xsl > hold/876-878.htm
if [ $? -ne 0 ]; then error; fi

java -jar saxon/saxon8.jar -t hold/88X.xml     hold/marc21hold.xsl > hold/88X.htm
if [ $? -ne 0 ]; then error; fi
