<!--##Korpusimportkedjan-->

Syftet med detta dokument är att förklara hur korpusimportkedjan är uppbyggd för den som är intresserad
av att förbättra eller tillföra ny funktionalitet. Om du jobbar på Språkbanken borde du hämta källfilerna
från Subversion. Kolla den interna wikin för mer information.

### Hämta hem och installera importkedjan

Nedladdningslänken och installationsinstruktioner till importkedjan hittar du
[på distributionssidan](https://spraakbanken.gu.se/swe/forskning/infrastruktur/sparv/distribution/importkedja).

För att köra importkedjan går man till väga på samma sätt som när man kör den
på en av våra servrar, vilket finns beskrivet [här](https://spraakbanken.gu.se/swe/forskning/infrastruktur/korp/korpusimport).

Formatet på indatan finns beskrivet [här](https://spraakbanken.gu.se/swe/forskning/infrastruktur/sparv/indataformat).

### Katalogstruktur

        annotate/
            bin/       Binärfiler
            makefiles/ Makefiler
            models/    Språkliga modeller
            python/    Pythonscript
            tests/     Tester

### Importkedjans uppbyggnad

Annoteringskedjan består av en mängd Python-script, som ligger under katalogen `python`. I regel är det ett script per
typ av uppgift, till exempel ett script för ordklasstaggning, ett för olika sorters segmentering, och så vidare.
Vissa av dessa script anropar externa verktyg, som till exempel Hunpos eller MaltParser.

Följande är en lista över de script som finns, och en kort förklaring av deras funktion. Vidare dokumentation finns
vanligtvis i docstringen till respektive funktion.

* *align.py*  
  Sammanlänkning av parallellkorpusar.
* *annotate.py*  
  Blandade småannoteringar.
* *compound.py*  
  Sammansättningsanalys med hjälp av SALDO.
* *crf.py*  
  Meningssegmentering med CRF.
* *cwb.py*  
  Skapar det slutgiltiga VRT-formatet och kodar Corpus Workbench-filer.
* *dateformat.py*  
  Datumformatering.
* *diapivot.py*
* *fileid.py*  
  Skapar IDn för varje fil i korpusen.
* *hist.py*  
  Diverse funktioner för annotering av historiska korpusar.
* *hunpos_morphtable.py*  
  Skapar en morphtable-fil för användning med Hunpos, baserad på SALDO.
* *hunpos.py*  
  Ordklasstaggning med hjälp av Hunpos.
* *info.py*  
  Skapar info-fil som används av CWB.
* *install.py*  
  Installerar korpusar på annan maskin.
* *lemgram_index.py*  
  Skapar ett lemgramindex som används av Korp.
* *lemgrampos.py*  
* *lmflexicon.py*  
  Parsar LMF-lexikon.
* *malt.py*  
  Syntaktisk parsning med hjälp av MaltParsern.
* *number.py*  
  Diverse numrering.
* *parent.py*  
* *relations.py*  
  Skapar ordbildsdata.
* *saldo.py*  
  SALDO-annotering.
* *segment.py*  
  All segmentering (stycke, mening, ord).
* *sent_align.py*  
  Meningslänkning av parallellkorpusar.
* *suc2hunpos.py*  
  Skapar träningsmaterial baserat på SUC3 för Hunpos.
* *timespan.py*  
  Hanterar tidsspann.
* *word_align.py*  
  Ordlänkning av parallellkorpusar med hjälp av fast_align och cdec.
* *xmlparser.py*  
  Parsar XML och genererar filer i importkedjans arbetsformat.

Det första som sker vid körning av kedjan är att indatan i XML-format parsas av xmlparser.py. Denna genererar
för varje indatafil följande (vanligtvis i katalogen `annotations`):

* En .TEXT-fil innehållande källans text samt en stor mängd ankarpunkter.
* En fil per strukturellt attribut som fångats in, där varje rad består av dels en referens till
  två ankarpunkter vilka anger attributets spann, dels attributets värde.

Utdatan från nästan samtliga script är i det sistnämnda formatet ovan, med referenser till ankarpunkter
och data för angivet spann. Ordklasstaggarscriptet ger till exempel ifrån sig en fil bestående av
ett ankarspann per ord, och ordklassen som värde.

### Annotationer

Nedan är en lista över de vanligaste annotationerna, och hur de blir till:

* *word*  
  Själva strängen som utgör ordet. Denna annotation skapas av *xmlparser.py*.
* *msd*  
  Morfosyntaktisk beskrivning. Skapas av *hunpos.py* med *word* som indata.
* *pos*  
  En förenklad MSD som endast behåller första ledet. Skapas av *annotate.py* med *msd* som indata.
* *baseform*, *lemgram*, *sense*  
  Grundform, lemgram och SALDO-id. Skapas av *saldo.py*, med *word*, *msd* och *ref* som indata. Använder en SALDO-modell som skapats av *saldo.py*.
* *ref*  
  En numrering av varje token inom varje mening. Skapas av *annotate.py*.
* *dephead*, *deprel*  
  Dependenshuvud och dependensrelation. Skapas av *malt.py*, med *word*, *msd* och *pos* som indata. Använder MALT-parsern med en modell för svenska.


### Att skapa ett nytt script

Denna del kommer att beskriva hur man går tillväga för att skapa ett nytt script och
göra det till en del av importkedjan.

Hur dataformatet för in- och utdata ser ut behöver man i regel inte bry sig om, eftersom det
finns färdiga metoder för att läsa och skriva dessa.

Nedan är ett minimalt exempel på ett script som skulle kunna vara en del av importkedjan:

        # -*- coding: utf-8 -*-
        import sb.util as util

        def changecase(word, out, case):
            # Läs in annotationen "word"
            words = util.read_annotation(word)

            # Transformera varje ord till versaler eller gemener
            for w in words:
                if case == "upper":
                    words[w] = words[w].upper()
                elif case == "lower":
                    words[w] = words[w].lower()

            # Skriv resultatet till angiven annotation
            util.write_annotation(out, words)

        if __name__ == '__main__':
            util.run.main(changecase=changecase)

Varje script börjar i regel med att importera `util`, som innehåller funktioner för att
läsa och skriva annotationer i det dataformat som kedjan använder.

Därefter definieras en eller flera funktioner, som man sen ska kunna använda sig
av i kedjan. I regel tar de som argument en eller flera sökvägar till befintliga annotationsfiler
som indata, en sökväg till den annotationsfil som ska skapas som resultat av körningen,
samt eventuellt ytterligare argument som påverkar det funktionen utför.

För att läsa in befintlig annotation används funktionen `util.read_annotation()`,
som ger ett dictionaryobjekt tillbaka, med ankarspann som nyckel och annotationens
värden som värde.
En funktion avslutas vanligtvis genom att anropa `util.write_annotation()`, som
tar en sökväg och en dictionary som argument, och sparar ner datan från dictionaryn
till angiven sökväg.

Allra sist i scriptet lägger man ett stycke kod (det som i exemplet ovan inleds av `if __name__ == '__main__':`),
som gör det möjligt att anropa alla funktioner i scriptet direkt från kommandoraden. Detta är nödvändigt för att
importkedjan ska kunna använda sig av scripten. Som argument till funktionen `util.run.main` listar man
alla funktioner i det aktuella scriptet som ska vara nåbara från kommandoraden. Funktionerna anges på formen
`alias=funktionsnamn`, där alias är det som används som flagga i kommandoraden. Den första funktionen kan
sättas som default genom att utelämna alias.


### Makefile

Körningen av importkedjans alla script samordnas med hjälp av ett par makefiler. Dels två makefiler innehållande
regler för alla olika annotationer (`Makefile.config`, `Makefile.rules`), dels en korpusspecifik makefil för varje
korpus (`Makefile`), som innehåller information om just den korpusens indataformat och annotationer.
De två generella makefilerna importeras av de korpusspecifika.

För dokumentation av de korpusspecifika makefilerna hänvisas till `Makefile.template` som finns bland makefilerna
i distributionen av importkedjan.

`Makefile.rules` är den fil som innehåller regler för de olika annotationerna, medan `Makefile.config` innehåller
variabler som kan sättas, samt allmänna regler för körning av korpusimportkedjan.

En regel i Makefile.rules kan se ut som följer:

        %.token.uppercase: %.token.word
            $(python) -m sb.case --changecase --out $@ --word $(1) --case upper

Ovanstående är regeln för att skapa annotationen *uppercase* från Python-exemplet ovan. Som källa tar den den annotationen *word*, och
den anropar funktionen *changecase* i scriptet *case.py*, med argumenten *out*, *word* och *case*.

För att lägga till en ny typ av annotation, så räcker det i regel med att lägga till en regel likt den ovan i `Makefile.rules`,
samt lägga till annotation i listan över annotationer i korpusens makefil.
