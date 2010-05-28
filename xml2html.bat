java -jar saxon\saxon8.jar -t 000.xml     marc21bib.xsl >000.htm
@if errorlevel 1 goto error
java -jar saxon\saxon8.jar -t 001-006.xml marc21bib.xsl >001-006.htm
@if errorlevel 1 goto error
java -jar saxon\saxon8.jar -t 007.xml     marc21bib.xsl >007.htm
@if errorlevel 1 goto error
java -jar saxon\saxon8.jar -t 008.xml     marc21bib.xsl >008.htm
@if errorlevel 1 goto error
java -jar saxon\saxon8.jar -t 01X-04X.xml marc21bib.xsl >01X-04X.htm
@if errorlevel 1 goto error
java -jar saxon\saxon8.jar -t 05X-08X.xml marc21bib.xsl >05X-08X.htm
@if errorlevel 1 goto error
java -jar saxon\saxon8.jar -t 1XX.xml     marc21bib.xsl >1XX.htm
@if errorlevel 1 goto error
java -jar saxon\saxon8.jar -t 20X-24X.xml marc21bib.xsl >20X-24X.htm
@if errorlevel 1 goto error
java -jar saxon\saxon8.jar -t 250-270.xml marc21bib.xsl >250-270.htm
@if errorlevel 1 goto error
java -jar saxon\saxon8.jar -t 3XX.xml     marc21bib.xsl >3XX.htm
@if errorlevel 1 goto error
java -jar saxon\saxon8.jar -t 4XX.xml     marc21bib.xsl >4XX.htm
@if errorlevel 1 goto error
java -jar saxon\saxon8.jar -t 50X-53X.xml marc21bib.xsl >50X-53X.htm
@if errorlevel 1 goto error
java -jar saxon\saxon8.jar -t 53X-58X.xml marc21bib.xsl >53X-58X.htm
@if errorlevel 1 goto error
java -jar saxon\saxon8.jar -t 6XX.xml     marc21bib.xsl >6XX.htm
@if errorlevel 1 goto error
java -jar saxon\saxon8.jar -t 70X-75X.xml marc21bib.xsl >70X-75X.htm
@if errorlevel 1 goto error
java -jar saxon\saxon8.jar -t 76X-78X.xml marc21bib.xsl >76X-78X.htm
@if errorlevel 1 goto error
java -jar saxon\saxon8.jar -t 80X-830.xml marc21bib.xsl >80X-830.htm
@if errorlevel 1 goto error
java -jar saxon\saxon8.jar -t 841-88X.xml marc21bib.xsl >841-88X.htm
@if errorlevel 1 goto error
java -jar saxon\saxon8.jar -t 9XX.xml     marc21bib.xsl >9XX.htm
@if errorlevel 1 goto error

@goto end

:error
@echo Conversion failed. See the error above. 
@pause
@goto end

:end
