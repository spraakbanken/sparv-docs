<!--##Körning av eget material på koala-->
Syftet med det här dokumentet är att förklara hur man kör eget material genom
importkedjan om man har tillgång till Språkbankens Subversion-repositorium och
ett användarkonto på servern koala.

Det är möjligt att köra eget material genom Språkbankens korpusimportkedja, och
att få det annoterat med alla de annoteringar som används för korpusarna i Korp.
Resultatet får du i antingen ett tabbseparerat format eller XML.

Följande krav ställs på ditt textmaterial:

* Filerna måste vara i UTF-8.
* Formatet måste vara XML-liknande, med åtminstone en start- och sluttagg som
omsluter texten. Det räcker med något så simpelt som `<text> ... </text>`.
* Varje enskild fil får inte vara för stor. Är de över 20 MB bör de delas upp
i mindre filer.

Se även [här](/en/tools/sparv/pipeline/import-format)
för mer information om indataformatet.

###Tillvägagångssätt

Logga in på koala, och börja med att sätta följande miljövariabel:

        export SPARV_MAKEFILES=/export/res/lb/korpus/sparv-pipeline/makefiles

Förslagsvis skapar du sen en katalog under din hemkatalog, i vilken alla
arbetsfiler kommer ligga. Navigera till denna katalog, och hämta sedan hem följande
exempel-Makefile ur GitHub:

        wget -O Makefile https://raw.githubusercontent.com/spraakbanken/sparv-pipeline/master/makefiles/Makefile.example

Därefter skapar du en underkatalog i vilken du lägger de XML-filer som utgör
ditt textmaterial.

Det sista du måste göra är att redigera filen Makefile för att anpassa den efter ditt
material. I oredigerat tillstånd utgår den från att XML-filerna ligger i en
katalog med namnet "original", och att all text i dessa filer är omsluten av
`<text> ... </text>`. Detta ändras lätt genom att ändra värdena för "original\_dir"
respektive "xml\_elements" i makefilen.
För en beskrivning av alla inställningsmöjligheter som finns kan du hämta hem
följande version av makefilen, innehållande kommentarer till varje rad:

        wget https://raw.githubusercontent.com/spraakbanken/sparv-pipeline/master/makefiles/Makefile.template

När du redigerat din Makefile är det färdigt för att köras. För att exportera
till XML-format kör du kommandot

        make export

vilket i slutändan leder till att du har det färdiga materialet i katalogen "export" (som skapas automatiskt).
Vill du hellre använda det tabbseparerade formatet så kör du i stället

        make vrt

och dessa vrt-filer hamnar då i katalogen "annotations" tillsammans med alla
andra arbetsfiler.

Om du lägger till eller tar bort källfiler efter en körning och vill köra om,
så måste du uppdatera registret över filer genom att köra följande:

        make add
