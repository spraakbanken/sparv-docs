

# Analyser för modern svenska (nusvenska)
Dessa analyser är tillgängliga i Sparv och kan användas för korpusar i modern svenska. Av olika anledningar används inte
alla analyser för korpusarna i Korp. 

- Meningssegmentering
    - **beskrivning**: Texter delas upp i meningar.
    - **modell**: byggt med [NLTK's
      PunktTrainer](https://www.nltk.org/api/nltk.tokenize.html?highlight=punkttrainer#nltk.tokenize.punkt.PunktTrainer)
      tränad på [StorSUC](https://spraakbanken.gu.se/resurser/storsuc)

- Tokenisering
    - **beskrivning**: Meningar delas upp i tokens.
    - **verktyg och modell**: Specialbyggd tokeniserare som bygger på reguljära uttryck och listor med ord innehållande
      specialtecken och vanliga förkortningar. Sparvs version är anpassad för svenska, men den går även att konfigurera
      för andra språk.

- Ordklasstaggning med Stanza
    - **beskrivning**: Meningar analyseras för att berika varje token med ordklasser och morfosyntaktisk information.
    - **verktyg**: [Stanza](https://stanfordnlp.github.io/stanza/)
    - **modell**: https://spraakbanken.gu.se/resurser/stanza_morph
    - **taggmängd**:
        - [SUCs MSD-taggar](https://spraakbanken.gu.se/korp/markup/msdtags.html)
        - [Universal features](https://universaldependencies.org/u/feat/index.html)
    - **annotationer på token-nivå**:
        - `pos`: ordklasstagg (av engelskans 'part of speech')
        - `msd`: morfosyntaktisk tagg
        - `feats`: universella morfologiska särdrag (features)

- Universella ordklasser
    - **beskrivning**: SUC-ordklasser översätts till universella ordklasser.
      Används ej som standard eftersom översättningen inte är helt pålitlig.
    - **taggmängd**: [Universal POS tags](https://universaldependencies.org/u/pos/index.html)
    - **annotationer på token-nivå**:
        - `upos`: universella ordklasstaggar

- Ordklasstaggning med Hunpos
    - **beskrivning**: Meningar analyseras för att berika varje token med ordklasser och morfosyntaktisk information.
      Används ej längre som standard eftersom Stanzas ordklasstaggning ger bättre resultat.
    - **verktyg**: [Hunpos](http://code.google.com/p/hunpos/)
    - **modell**: egen modell tränad på [SUC 3.0](https://spraakbanken.gu.se/resurser/suc3)
    - **taggmängd**: [SUCs MSD-taggar](https://spraakbanken.gu.se/korp/markup/msdtags.html)
    - **annotationer på tokennivå**:
        - `pos`: ordklasstagg (av engelskans 'part of speech')
        - `msd`: morfosyntaktisk tagg

- Dependensparsning med Stanza
    - **beskrivning**: Meningar analyseras för att berika tokens med dependensinformation.
    - **verktyg**: [Stanza](https://stanfordnlp.github.io/stanza/)
    - **modell**: https://spraakbanken.gu.se/resurser/stanza_synt
    - **taggmängd**: [Mamba-Dep](http://stp.ling.uu.se/~nivre/swedish_treebank/dep.html)
    - **annotationer på token-nivå**:
        - `ref`: ordets position i meningen
        - `dephead`: dependenshuvud, ref för det ord som detta ord modifierar eller är beroende av
        - `deprel`: dependensrelation, den relation detta ord har till sitt dependenshuvud

- Dependensparsning med MaltParser
    - **beskrivning**:
      Används ej längre som standard eftersom Stanzas dependensanalys ger bättre resultat.
    - **verktyg**: [MaltParser](http://www.maltparser.org/download.html)
    - **modell**: [swemalt](http://www.maltparser.org/mco/swedish_parser/swemalt.html), tränad på Svensk trädbank
    - **taggmängd**: [Mamba-Dep](http://stp.ling.uu.se/~nivre/swedish_treebank/dep.html)
    - **annotationer på token-nivå**:
        - `ref`: ordets position i meningen
        - `dephead`: dependenshuvud, ref för det ord som detta ord modifierar eller är beroende av
        - `deprel`: dependensrelation, den relation detta ord har till sitt dependenshuvud

- Frasstrukturparsning
    - **beskrivning**: Mamba-Dep dependenser framtagna av dependensanalysen konverteras till frasstrukturer.
      Används ej i Korp på grund av inkompatibilitet med Corpus Workbench.
    - **annotationer**:
        - `phrase`: frassegment
        - `phrase.name`: frasnamn
        - `phrase.func`: frasfunktioner

- SALDO-baserade analyser
    - **beskrivning**: Tokens och deras ordklasser slås upp i SALDO-lexikonet för att få fram ytterligare egenskaper.
    - **modell**: [SALDOs morfologi](https://spraakbanken.gu.se/resurser/saldo)
    - **taggmängd**: [SALDO taggar](https://spraakbanken.gu.se/resurser/saldo/taggmangd) för lemgram
    - **annotationer på token-nivå**:
        - `baseform`: grundform
        - `lemgram`: lemgram, en formenhet som identifierar böjningstabellen
        - `sense`: identifierar en betydelse i SALDO

- Grundformanalys från Stanza
    - **beskrivning**: Meningar analyseras för att berika tokens med dependensinformation.
      Används ej i Korp. Grundformer annoteras istället med SALDO.
    - **verktyg**: [Stanza](https://stanfordnlp.github.io/stanza/)
    - **modell**: https://spraakbanken.gu.se/resurser/stanza_synt
    - **annotationer på tokennivå**:
        - `baseform`: grundform

- Betydelsedesambiguering
    - **beskrivning**: SALDO-ID:n från `sense`-attributet utökas med sannolikheter
    - **verktyg**: [Sparv wsd](https://github.com/spraakbanken/sparv-wsd)
    - **annotationer på token-nivå**:
        - `sense`: identifierar en betydelse i SALDO samt dess sannolikhet

- Sammansättningsanalys
    - **beskrivning**: Tokens och deras ordklasser slås upp i SALDO-lexikonet för att få fram information om
      sammansättningar.  
      Grundformer utökas i det här analyssteget.
    - **modeller**: [SALDOs morfologi](https://spraakbanken.gu.se/resurser/saldo), [NST uttalslexikon för
      svenska](https://www.nb.no/sprakbanken/en/resource-catalogue/oai-nb-no-sbr-22/) samt statistik från Korp
    - se även [FAQ](https://spraakbanken.gu.se/faq#q24)
    - **annotationer på token-nivå**:
        - `complemgram`: sammansatta lemgram samt deras jämförelsetal 
        - `compwf`: sammansatta ordformer
        - `baseform`: grundform

- Sentimentanalys
    - **beskrivning**: Tokens och deras SALDO-ID:n slås upp i SenSALDO för att berika dessa med attitydvärden. 
    - **modell**: [SenSALDO](https://spraakbanken.gu.se/resurser/sensaldo)
    - **annotationer på token-nivå**:
        - `sentiment_label`: attityd
        - `sentiment_score`: attitydvärde

- Namnigenkänning
    - **beskrivning**: Meningar analyseras och berikas med namnentiteter.
    - **verktyg**: [hfst-SweNER](http://www.ling.helsinki.fi/users/janiemi/finclarin/ner/hfst-swener-0.9.3.tgz)
    - **referenser**:
        - [HFST-SweNER – A New NER Resource for Swedish](http://www.lrec-conf.org/proceedings/lrec2014/pdf/391_Paper.pdf)
        - [Reducing the effect of name explosion](http://demo.spraakdata.gu.se/svedk/pbl/kokkinakisBNER.pdf)
    - **annotationer**:
        - `ne`: namnsegment (spann-annotation)
        - `ne.name`: texten i hela namnsegmentet
        - `ne.ex`: namnentitet (namnuttryck, numerisk uttryck eller tidsuttryck)
        - `ne.type`: namnentitetstyp
        - `ne.subtype`: namnentitetsundertyp

- Läsbarhetsindex
    - **beskrivning**: Dokument analyseras för att berika dessa med läsbarhetsvärden.
    - **annotationer på dokumentnivå**:
        - `lix`: LIX, läsbarhetsindex
        - `ovix`: OVIX, ordvariationsindex
        - `nk`: Nominalkvot

- Lexikala klasser
    - **beskrivning**: Tokens slås upp i Blingbring och SweFN för att berika dessa med information om deras lexikala
      klasser. Sedan berikas hela dokumentet med information om lexikala klasser baserad på vilka klasser dess tokens
      tillhör.
    - **modeller**:
        - [Blingbring](https://spraakbanken.gu.se/resurser/blingbring)
        - [Svenskt frasnät (SweFN)](https://spraakbanken.gu.se/resurser/swefn)
    - **annotationer på token-nivå**:
        - `blingbring`: lexikala klasser från Blingbring-resursen
        - `swefn`: ramar från Svenskt frasnät (SweFN)
    - **annotationer på dokumentnivå**:
        - `blingbring`: lexikala klasser från Blingbring-resursen
        - `swefn`: ramar från Svenskt frasnät (SweFN)

- Geouppmärkning
    - **beskrivning**: Meningar (och stycken om sådana finns) berikas med orter (och geokoordinater) som förekommer inom
      dessa. Detta är baserat på orter som har blivit uppmärkta av namntaggaren. Geokoordinaterna slås upp i en databas.
    - **modell**: [GeoNames](https://www.geonames.org/)
    - **annotationer på meningsnivå**:
        - `geo`: orter och deras koordinator som förekommer i meningen
    - **annotationer på styckesnivå**:
        - `geo`: orter och deras koordinator som förekommer i stycket


# Analyser för 1800-talssvenska
Alla analyser för modern svenska är tillgängliga för 1800-talssvenska. Utöver denna finns följande analyser som är specialanpassade för 1800-talssvenska:

- Ordklasstaggning med Hunpos (anpassad för 1800-talssvenska)
    - **beskrivning**: Meningar analyseras för att berika varje token med ordklasser och morfosyntaktisk information.
    - **verktyg**: [Hunpos](http://code.google.com/p/hunpos/)
    - **modell**:
        - egen modell tränad på [SUC 3.0](https://spraakbanken.gu.se/resurser/suc3)
        - ordlista och tillhörande MSD-information genererad från [Dalins
          morfologi](https://spraakbanken.gu.se/resurser/dalinm) och [Swedbergs
          morfologi](https://spraakbanken.gu.se/resurser/swedbergm)
    - **taggmängd**: [SUCs MSD-taggar](https://spraakbanken.gu.se/korp/markup/msdtags.html)
    - **annotationer på tokennivå**:
        - `pos`: ordklasstagg (av engelskans 'part of speech')
        - `msd`: morfosyntaktisk tagg

- Lexikon-baserade analyser
    - **beskrivning**: Tokens och deras ordklasser slås upp i olika lexikon för att få fram ytterligare egenskaper.
    - **modeller**:
        - [SALDOs morfologi](https://spraakbanken.gu.se/resurser/saldo)
        - [Dalins morfologi](https://spraakbanken.gu.se/resurser/dalinm)
        - [Swedbergs morfologi](https://spraakbanken.gu.se/resurser/swedbergm)
        - [Diakronisk pivot](https://spraakbanken.gu.se/resurser/diapivot)
    - **taggmängd**: [SALDO taggar](https://spraakbanken.gu.se/resurser/saldo/taggmangd) för lemgram
    - **annotationer på token-nivå**:
        - `baseform`: grundform
        - `lemgram`: lemgram, en formenhet som identifierar böjningstabellen
        - `sense`: identifierar en betydelse i SALDO

 
# Standardanalyser för fornsvenska
Alla analyser för modern svenska är tillgängliga för fornsvenska, men vi rekommenderar inte att använda dessa då
stavningen ofta avviker för mycket för att ge bra resultat. På Språkbanken Text använder vi följande analyser för
fornsvenska texter:

- Meningssegmentering och tokenisering (på samma sätt som vi gör för modern svenska)

- Stavningsvarianter
    - **beskrivning**: Tokens slås upp i en modell för att få fram stavningsvarianter.
    - **modell**: [Modell för fornsvenska
      stavningsvarianter](https://media.githubusercontent.com/media/spraakbanken/sparv-models/master/hist/fsv-spelling-variants.txt)
    - **annotationer på tokennivå**:
        - `spelling_variants`: möjliga stavningsvarianter av tokenet

- Lexikon-baserade analyser
    - **beskrivning**: Tokens och deras ordklasser slås upp i olika lexikon för att få fram ytterligare egenskaper.
    - **modeller**:
        - [Fornsvensk morfologi ur Söderwall och Schlyter](https://spraakbanken.gu.se/resurser/fsvm)
        - [SALDOs morfologi](https://spraakbanken.gu.se/resurser/saldo)
        - [Diakronisk pivot](https://spraakbanken.gu.se/resurser/diapivot)
    - **taggmängd**: [SALDO taggar](https://spraakbanken.gu.se/resurser/saldo/taggmangd) för lemgram
    - **annotationer på token-nivå**:
        - `baseform`: grundform
        - `lemgram`: lemgram, en formenhet som identifierar böjningstabellen

- Homografmängd
    - **beskrivning**: En mängd av möjliga ordklasstaggar extraheras från lemgram-annotationen
    - **taggmängd**: [Ordklasserna ur SUCs MSD-taggar](https://spraakbanken.gu.se/korp/markup/msdtags.html)


# Analyser för andra språk än svenska
Sparv stödjer analyser för diverse andra språk. En lista över vilka språk som stöds och vilka analysverktyg som är
tillgängliga finns
[här](https://spraakbanken.gu.se/sparv/#/user-manual/installation-and-setup?id=software-for-analysing-other-languages-than-swedish).

- Analyser från TreeTagger
    - **beskrivning**: Tokeniserade meningar analyseras för att berika varje token med ytterligare information.
    - **verktyg**: [TreeTagger](https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/)
    - **taggmängd**:
        - Olika ordklasstaggmängder beroende på språk. Se [TreeTaggers
          webbsida](https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/) för mer info.
        - [Universal POS tags](https://universaldependencies.org/u/pos/index.html)
    - **annotationer på token-nivå**:
        - `baseform`: grundform
        - `pos`: ordklasstagg, kan innehålla morfosyntaktisk information
        - `upos`: universella ordklasstaggar, översätta från `pos`

- Analyser från FreeLing
    - **beskrivning**: Hela dokument analyseras med FreeLing för att meningssegmenteras, tokeniseras och berikas med
      annan information. FreeLing använder inte samma licens som övriga Sparv och kräver ett
      [Sparv-plugin](https://github.com/spraakbanken/sparv-freeling).
    - **verktyg**: [FreeLing](https://github.com/TALP-UPC/FreeLing)
    - **taggmängd**:
        - Olika ordklasstaggmängder beroende på språk (ofta
          [EAGLES](http://www.ilc.cnr.it/EAGLES96/annotate/node9.html)). Se [FreeLings
          dokumentation](https://freeling-user-manual.readthedocs.io/en/v4.2/tagsets/) för mer info.
        - [Universal POS tags](https://universaldependencies.org/u/pos/index.html)
    - **annotationer på token-nivå**:
        - `baseform`: grundform
        - `pos`: ordklasstagg, innehåller ofta även morfosyntaktisk information
        - `upos`: universella ordklasstaggar
        - `ne_type`: namnentitetstyp (inte tillgänglig för alla språk)

- Analyser från Stanford Parser (för engelska)
    - **beskrivning**: Hela dokument analyseras med Stanford Parser för att meningssegmenteras, tokeniseras och berikas
      med annan information.
    - **verktyg**: [Stanford Parser](https://nlp.stanford.edu/software/lex-parser.shtml)
    - **taggmängd**:
        - [Penn Treebank tagset](https://www.sketchengine.eu/penn-treebank-tagset/)
        - [Universal POS tags](https://universaldependencies.org/u/pos/index.html)
    - **annotationer på token-nivå**:
        - `baseform`: grundform
        - `pos`: ordklasstagg, innehåller ofta även morfosyntaktisk information
        - `upos`: universella ordklasstaggar
        - `ne_type`: namnentitetstyp
        - `ref`: ordets position i meningen
        - `dephead`: dependenshuvud, ref för det ord som detta ord modifierar eller är beroende av
        - `deprel`: dependensrelation, den relation detta ord har till sitt dependenshuvud

- Analyser från Stanza (för engelska)
    - **beskrivning**: Hela dokument analyseras med Stanford Parser för att meningssegmenteras, tokeniseras och berikas
      med annan information.
    - **verktyg**: [Stanza](https://stanfordnlp.github.io/stanza/)
    - **taggmängd**:
        - [Universal POS tags](https://universaldependencies.org/u/pos/index.html)
        - [Universal features](https://universaldependencies.org/u/feat/index.html)
    - **annotationer på token-nivå**:
        - `baseform`: grundform
        - `pos`: ordklasstagg
        - `upos`: universella ordklasstaggar
        - `feats`: universella morfologiska särdrag (features)
        - `ref`: ordets position i meningen
        - `dephead`: dependenshuvud, ref för det ord som detta ord modifierar eller är beroende av
        - `deprel`: dependensrelation, den relation detta ord har till sitt dependenshuvud
    - **namn-annotationer**:
        - `ne`: namnsegment (spann-annotation)
        - `ne.type`: namnentitetstyp
