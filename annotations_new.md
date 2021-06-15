

# Analyser för modern svenska (nusvenska)
Dessa analyser är tillgängliga i Sparv och kan användas för korpusar i modern svenska. Av olika anledningar används inte
alla analyser för korpusarna i Korp. 

- Meningssegmentering
    - **beskrivning**: Texter delas upp i meningar.
    - **modell**: [punkt-nltk-svenska.pickle](https://github.com/spraakbanken/sparv-models/blob/master/segment/punkt-nltk-svenska.pickle?raw=true)
    - **metod**: Modellen är byggd med [NLTK's
      PunktTrainer](https://www.nltk.org/api/nltk.tokenize.html?highlight=punkttrainer#nltk.tokenize.punkt.PunktTrainer)
      och tränad på [StorSUC](https://spraakbanken.gu.se/resurser/storsuc). Segmenteringen sker med NLTK's
      [PunktSentenceTokenizer](https://www.nltk.org/api/nltk.tokenize.html?highlight=punktsentencetokenizer#nltk.tokenize.punkt.PunktSentenceTokenizer).
    - **annotationer**:
        - `segment.sentence`: meningssegment

- Tokenisering
    - **beskrivning**: Meningar delas upp i tokens.
    - **modell**:
        - [konfigurationsfil bettertokenizer.sv](https://raw.githubusercontent.com/spraakbanken/sparv-models/master/segment/bettertokenizer.sv)
        - ordlista `bettertokenizer.sv.saldo-tokens` byggd på [SALDOs morfologi](https://spraakbanken.gu.se/resurser/saldo) (byggs automatiskt av Sparv)
    - **metod**: Specialbyggd tokeniserare som bygger på reguljära uttryck och listor med ord innehållande
      specialtecken och vanliga förkortningar. Sparvs version är anpassad för svenska, men den går även att konfigurera
      för andra språk.
    - **annotationer**:
        - `segment.sentence`: tokensegment

- Ordklasstaggning med Stanza
    - **beskrivning**: Meningar analyseras för att berika varje token med ordklasser och morfosyntaktisk information.
    - **verktyg**: [Stanza](https://stanfordnlp.github.io/stanza/)
    - **modell**: https://spraakbanken.gu.se/resurser/stanza_morph
    - **taggmängd**:
        - [SUCs MSD-taggar](https://spraakbanken.gu.se/korp/markup/msdtags.html)
        - [Universal features](https://universaldependencies.org/u/feat/index.html)
    - **annotationer**:
        - `<token>:stanza.pos`: ordklasstagg
        - `<token>:stanza.msd`: morfosyntaktisk tagg
        - `<token>:stanza.ufeats`: universella morfologiska särdrag (features)

- Universella ordklasser
    - **beskrivning**: SUC-ordklasser översätts till universella ordklasser.
      Används ej som standard eftersom översättningen inte är helt pålitlig.
    - **modell**: Metod saknar modell. En översättningstabell används.
    - **taggmängd**: [Universal POS tags](https://universaldependencies.org/u/pos/index.html)
    - **annotationer**:
        - `<token>:misc.upos`: universella ordklasstaggar

- Ordklasstaggning med Hunpos
    - **beskrivning**: Meningar analyseras för att berika varje token med ordklasser och morfosyntaktisk information.
      Används ej längre som standard eftersom Stanzas ordklasstaggning ger bättre resultat.
    - **verktyg**: [Hunpos](http://code.google.com/p/hunpos/)
    - **modell**: [suc3_suc-tags_default-setting_utf8.model](https://github.com/spraakbanken/sparv-models/blob/master/hunpos/suc3_suc-tags_default-setting_utf8.model?raw=true)
    - **metod**: Modellen är tränad på [SUC 3.0](https://spraakbanken.gu.se/resurser/suc3).
    - **taggmängd**: [SUCs MSD-taggar](https://spraakbanken.gu.se/korp/markup/msdtags.html)
    - **annotationer**:
        - `<token>:hunpos.pos`: ordklasstagg
        - `<token>:hunpos.msd`: morfosyntaktisk tagg

- Dependensparsning med Stanza
    - **beskrivning**: Meningar analyseras för att berika tokens med dependensinformation.
    - **verktyg**: [Stanza](https://stanfordnlp.github.io/stanza/)
    - **modell**: https://spraakbanken.gu.se/resurser/stanza_synt
    - **taggmängd**: [Mamba-Dep](http://stp.ling.uu.se/~nivre/swedish_treebank/dep.html)
    - **annotationer**:
        - `<token>:stanza.ref`: ordets position i meningen
        - `<token>:stanza.dephead_ref`: dependenshuvud, ref för det ord som detta ord modifierar eller är beroende av
        - `<token>:stanza.deprel`: dependensrelation, den relation detta ord har till sitt dependenshuvud

- Dependensparsning med MaltParser
    - **beskrivning**:
      Används ej längre som standard eftersom Stanzas dependensanalys ger bättre resultat.
    - **verktyg**: [MaltParser](http://www.maltparser.org/download.html)
    - **modell**: [swemalt](http://www.maltparser.org/mco/swedish_parser/swemalt.html)
    - **metod**: Modellen är tränad på [Svensk trädbank](https://spraakbanken.gu.se/resurser/sv-treebank).
    - **taggmängd**: [Mamba-Dep](http://stp.ling.uu.se/~nivre/swedish_treebank/dep.html)
    - **annotationer**:
        - `<token>:malt.ref`: ordets position i meningen
        - `<token>:malt.dephead_ref`: dependenshuvud, ref för det ord som detta ord modifierar eller är beroende av
        - `<token>:malt.deprel`: dependensrelation, den relation detta ord har till sitt dependenshuvud

- Frasstrukturparsning
    - **beskrivning**: Mamba-Dep dependenser framtagna av dependensanalysen konverteras till frasstrukturer.
      Används ej i Korp på grund av inkompatibilitet med Corpus Workbench.
    - **modell**: Metod saknar modell
    - **annotationer**:
        - `phrase_structure.phrase`: frassegment
        - `phrase_structure.phrase:phrase_structure.name`: namnet av frassegmentet
        - `phrase_structure.phrase:phrase_structure.func`: funktionen av frassegmentet

- SALDO-baserade analyser
    - **beskrivning**: Tokens och deras ordklasser slås upp i SALDO-lexikonet för att få fram ytterligare egenskaper.
    - **modell**: [SALDOs morfologi](https://spraakbanken.gu.se/resurser/saldo)
    - **taggmängd**: [SALDO taggar](https://spraakbanken.gu.se/resurser/saldo/taggmangd) för lemgram
    - **annotationer**:
        - `<token>:saldo.baseform`: grundform
        - `<token>:saldo.lemgram`: lemgram, en formenhet som identifierar böjningstabellen
        - `<token>:saldo.sense`: identifierar en betydelse i SALDO

- Grundformanalys från Stanza
    - **beskrivning**: Meningar analyseras för att berika tokens med dependensinformation.
      Används ej i Korp. Grundformer annoteras istället med SALDO.
    - **verktyg**: [Stanza](https://stanfordnlp.github.io/stanza/)
    - **modell**: https://spraakbanken.gu.se/resurser/stanza_synt
    - **annotationer**:
        - `<token>:stanza.baseform`: grundform

- Betydelsedesambiguering
    - **beskrivning**: SALDO-ID:n från `sense`-attributet utökas med sannolikheter
    - **verktyg**: [Sparv wsd](https://github.com/spraakbanken/sparv-wsd)
    - **dokumentation**: [Running the Koala word sense disambiguators](https://github.com/spraakbanken/sparv-wsd/blob/master/README.pdf)
    - **modell**:
        - [ALL_512_128_w10_A2_140403_ctx1.bin](https://github.com/spraakbanken/sparv-wsd/blob/master/models/scouse/ALL_512_128_w10_A2_140403_ctx1.bin)
        - [lem_cbow0_s512_w10_NEW2_ctx.bin](https://github.com/spraakbanken/sparv-wsd/blob/master/models/scouse/lem_cbow0_s512_w10_NEW2_ctx.bin)
    - **annotationer**:
        - `<token>:wsd.sense`: identifierar en betydelse i SALDO samt dess sannolikhet

- Sammansättningsanalys
    - **beskrivning**: Tokens och deras ordklasser slås upp i SALDO-lexikonet för att få fram information om
      sammansättningar. Se även [FAQ](https://spraakbanken.gu.se/faq#q24).
      Grundformer utökas i det här analyssteget.
    - **modell**:
        - [SALDOs morfologi](https://spraakbanken.gu.se/resurser/saldo)
        - [NST uttalslexikon för
      svenska](https://www.nb.no/sprakbanken/en/resource-catalogue/oai-nb-no-sbr-22/)
      - [frekvensstatistik från Korp](https://svn.spraakdata.gu.se/sb-arkiv/pub/frekvens/stats_all.txt)
    - **annotationer**:
        - `<token>:saldo.complemgram`: sammansatta lemgram samt deras jämförelsetal 
        - `<token>:saldo.compwf`: sammansatta ordformer
        - `<token>:saldo.baseform2`: grundform

- Sentimentanalys
    - **beskrivning**: Tokens och deras SALDO-ID:n slås upp i SenSALDO för att berika dessa med attitydvärden. 
    - **modell**: [SenSALDO](https://spraakbanken.gu.se/resurser/sensaldo)
    - **annotationer**:
        - `<token>:sensaldo.sentiment_label`: attityd
        - `<token>:sensaldo.sentiment_score`: attitydvärde

- Namnigenkänning
    - **beskrivning**: Meningar analyseras och berikas med namnentiteter.
    - **verktyg**: [hfst-SweNER](http://www.ling.helsinki.fi/users/janiemi/finclarin/ner/hfst-swener-0.9.3.tgz)
    - **modell**: inbyggd i verktyget
    - **referenser**:
        - [HFST-SweNER – A New NER Resource for Swedish](http://www.lrec-conf.org/proceedings/lrec2014/pdf/391_Paper.pdf)
        - [Reducing the effect of name explosion](http://demo.spraakdata.gu.se/svedk/pbl/kokkinakisBNER.pdf)
    - **annotationer**:
        - `swener.ne`: namnsegment
        - `swener.ne:swener.name`: texten i hela namnsegmentet
        - `swener.ne:swener.ex`: namnentitet (namnuttryck, numerisk uttryck eller tidsuttryck)
        - `swener.ne:swener.type`: namnentitetstyp
        - `swener.ne:swener.subtype`: namnentitetsundertyp

- Läsbarhetsindex
    - **beskrivning**: Dokument analyseras för att berika dessa med läsbarhetsvärden.
    - **modell**: Metod saknar modell
    - **annotationer**:
        - `<text>:readability.lix`: LIX, läsbarhetsindex
        - `<text>:readability.ovix`: OVIX, ordvariationsindex
        - `<text>:readability.nk`: Nominalkvot

- Lexikala klasser
    - **beskrivning**: Tokens slås upp i Blingbring och SweFN för att berika dessa med information om deras lexikala
      klasser. Sedan berikas hela dokumentet med information om lexikala klasser baserad på vilka klasser dess tokens
      tillhör.
    - **modell**:
        - [Blingbring](https://spraakbanken.gu.se/resurser/blingbring)
        - [Svenskt frasnät (SweFN)](https://spraakbanken.gu.se/resurser/swefn)
    - **annotationer**:
        - `<token>:lexical_classes.blingbring`: lexikala klasser från Blingbring-resursen per token
        - `<token>:lexical_classes.swefn`: ramar från Svenskt frasnät (SweFN) per token
        - `<text>:lexical_classes.blingbring`: lexikala klasser från Blingbring-resursen per dokument
        - `<text>:lexical_classes.swefn`: ramar från Svenskt frasnät (SweFN) per dokument

- Geouppmärkning
    - **beskrivning**: Meningar (och stycken om sådana finns) berikas med orter (och geokoordinater) som förekommer inom
      dessa. Detta är baserat på orter som har blivit uppmärkta av namntaggaren. Geokoordinaterna slås upp i en databas.
    - **modell**: [GeoNames](https://www.geonames.org/)
    - **annotationer**:
        - `<sentence>:geo.geo_context`: orter och deras koordinator som förekommer i meningen
        - `<paragraph>:geo.geo_context`: orter och deras koordinator som förekommer i stycket


# Analyser för 1800-talssvenska
Alla analyser för modern svenska är tillgängliga för 1800-talssvenska. Utöver denna finns följande analyser som är specialanpassade för 1800-talssvenska:

- Ordklasstaggning med Hunpos (anpassad för 1800-talssvenska)
    - **beskrivning**: Meningar analyseras för att berika varje token med ordklasser och morfosyntaktisk information.
    - **verktyg**: [Hunpos](http://code.google.com/p/hunpos/)
    - **modell**:
        - [suc3_suc-tags_default-setting_utf8.model](https://github.com/spraakbanken/sparv-models/blob/master/hunpos/suc3_suc-tags_default-setting_utf8.model?raw=true)
        - ordlista och tillhörande MSD-information genererad från [Dalins
          morfologi](https://spraakbanken.gu.se/resurser/dalinm) och [Swedbergs
          morfologi](https://spraakbanken.gu.se/resurser/swedbergm)
    - **metod**: Modellen är tränad på [SUC 3.0](https://spraakbanken.gu.se/resurser/suc3).
    - **taggmängd**: [SUCs MSD-taggar](https://spraakbanken.gu.se/korp/markup/msdtags.html)
    - **annotationer**:
        - `<token>:hunpos.pos`: ordklasstagg
        - `<token>:hunpos.msd`: morfosyntaktisk tagg

- Lexikon-baserade analyser
    - **beskrivning**: Tokens och deras ordklasser slås upp i olika lexikon för att få fram ytterligare egenskaper.
    - **modell**:
        - [SALDOs morfologi](https://spraakbanken.gu.se/resurser/saldo)
        - [Dalins morfologi](https://spraakbanken.gu.se/resurser/dalinm)
        - [Swedbergs morfologi](https://spraakbanken.gu.se/resurser/swedbergm)
        - [Diakronisk pivot](https://spraakbanken.gu.se/resurser/diapivot)
    - **taggmängd**: [SALDO taggar](https://spraakbanken.gu.se/resurser/saldo/taggmangd) (för lemgram)
    - **annotationer**:
        - `<token>:hist.baseform`: grundform
        - `<token>:hist.combined_lemgrams`: lemgram, en formenhet som identifierar böjningstabellen
        - `<token>:hist.sense`: identifierar en betydelse i SALDO

 
# Standardanalyser för fornsvenska
Alla analyser för modern svenska är tillgängliga för fornsvenska, men vi rekommenderar inte att använda dessa då
stavningen ofta avviker för mycket för att ge bra resultat. På Språkbanken Text använder vi följande analyser för
fornsvenska texter:

- Meningssegmentering och tokenisering (på samma sätt som vi gör för modern svenska)

- Stavningsvarianter
    - **beskrivning**: Tokens slås upp i en modell för att få fram stavningsvarianter.
    - **modell**: [modell för fornsvenska
      stavningsvarianter](https://media.githubusercontent.com/media/spraakbanken/sparv-models/master/hist/fsv-spelling-variants.txt)
    - **annotationer**:
        - `<token>:hist.spelling_variants`: möjliga stavningsvarianter av tokenet

- Lexikon-baserade analyser
    - **beskrivning**: Tokens och deras ordklasser slås upp i olika lexikon för att få fram ytterligare egenskaper.
    - **modell**:
        - [Fornsvensk morfologi ur Söderwall och Schlyter](https://spraakbanken.gu.se/resurser/fsvm)
        - [SALDOs morfologi](https://spraakbanken.gu.se/resurser/saldo)
        - [Diakronisk pivot](https://spraakbanken.gu.se/resurser/diapivot)
    - **taggmängd**: [SALDO taggar](https://spraakbanken.gu.se/resurser/saldo/taggmangd) för lemgram
    - **annotationer**:
        - `<token>:hist.baseform`: grundform
        - `<token>:hist.combined_lemgrams`: lemgram, en formenhet som identifierar böjningstabellen

- Homografmängd
    - **beskrivning**: En mängd av möjliga ordklasstaggar extraheras från lemgram-annotationen
    - **modell**: Metod saknar modell
    - **taggmängd**: [Ordklasserna ur SUCs MSD-taggar](https://spraakbanken.gu.se/korp/markup/msdtags.html)
    - **annotationer**:
        - `<token>:hist.homograph_set`: möjliga ordklasstaggar för tokenet


# Analyser för andra språk än svenska
Sparv stödjer analyser för diverse andra språk. En lista över vilka språk som stöds och vilka analysverktyg som är
tillgängliga finns
[här](https://spraakbanken.gu.se/sparv/#/user-manual/installation-and-setup?id=software-for-analysing-other-languages-than-swedish).

- Analyser från TreeTagger
    - **beskrivning**: Tokeniserade meningar analyseras för att berika varje token med ytterligare information.
    - **verktyg**: [TreeTagger](https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/)
    - **modell**: Olika parameter-filer beroende på språk. Se [TreeTaggers
          webbsida](https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/) för mer info.
    - **taggmängd**:
        - Olika ordklasstaggmängder beroende på språk. Se [TreeTaggers
          webbsida](https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/) för mer info.
        - [Universal POS tags](https://universaldependencies.org/u/pos/index.html)
    - **annotationer**:
        - `<token>:treetagger.baseform`: grundform
        - `<token>:treetagger.pos`: ordklasstagg, kan innehålla morfosyntaktisk information
        - `<token>:treetagger.upos`: universella ordklasstaggar, översätta från `pos`

- Analyser från FreeLing
    - **beskrivning**: Hela dokument analyseras med FreeLing för att meningssegmenteras, tokeniseras och berikas med
      annan information. FreeLing använder inte samma licens som övriga Sparv och kräver ett
      [Sparv-plugin](https://github.com/spraakbanken/sparv-freeling).
    - **verktyg**: [FreeLing](https://github.com/TALP-UPC/FreeLing)
    - **modell**: Modeller för olika språk är inbyggda i verktyget.
    - **taggmängd**:
        - Olika ordklasstaggmängder beroende på språk (ofta
          [EAGLES](http://www.ilc.cnr.it/EAGLES96/annotate/node9.html)). Se [FreeLings
          dokumentation](https://freeling-user-manual.readthedocs.io/en/v4.2/tagsets/) för mer info.
        - [Universal POS tags](https://universaldependencies.org/u/pos/index.html)
    - **annotationer**:
        - `freeling.sentence`: meningssegment från FreeLing
        - `freeling.token`: tokensegment från FreeLing
        - `freeling.token:freeling.baseform`: grundform
        - `freeling.token:freeling.pos`: ordklasstagg, innehåller ofta även morfosyntaktisk information
        - `freeling.token:freeling.upos`: universella ordklasstaggar
        - `freeling.token:freeling.ne_type`: namnentitetstyp (inte tillgänglig för alla språk)

- Analyser från Stanford Parser (för engelska)
    - **beskrivning**: Hela dokument analyseras med Stanford Parser för att meningssegmenteras, tokeniseras och berikas
      med annan information.
    - **verktyg**: [Stanford Parser](https://nlp.stanford.edu/software/lex-parser.shtml)
    - **modell**: inbyggd i verktyget
    - **taggmängd**:
        - [Penn Treebank tagset](https://www.sketchengine.eu/penn-treebank-tagset/)
        - [Universal POS tags](https://universaldependencies.org/u/pos/index.html)
    - **annotationer**:
        - `stanford.sentence`: meningssegment från Stanford Parser
        - `stanford.token`: tokensegment från Stanford Parser
        - `stanford.token:stanford.baseform`: grundform
        - `stanford.token:stanford.pos`: ordklasstagg, innehåller ofta även morfosyntaktisk information
        - `stanford.token:stanford.upos`: universella ordklasstaggar
        - `stanford.token:stanford.ne_type`: namnentitetstyp
        - `stanford.token:stanford.ref`: ordets position i meningen
        - `stanford.token:stanford.dephead_ref`: dependenshuvud, ref för det ord som detta ord modifierar eller är beroende av
        - `stanford.token:stanford.deprel`: dependensrelation, den relation detta ord har till sitt dependenshuvud

- Analyser från Stanza (för engelska)
    - **beskrivning**: Hela dokument analyseras med Stanford Parser för att meningssegmenteras, tokeniseras och berikas
      med annan information.
    - **verktyg**: [Stanza](https://stanfordnlp.github.io/stanza/)
    - **modell**: inbyggd i verktyget
    - **taggmängd**:
        - [Universal POS tags](https://universaldependencies.org/u/pos/index.html)
        - [Universal features](https://universaldependencies.org/u/feat/index.html)
    - **annotationer**:
        - `stanza.sentence`: meningssegment från Stanza
        - `stanza.ne`: namnsegment från Stanza
        - `stanza.ne:stanza.ne_type`: namnentitetstyp
        - `stanza.token`: tokensegment från Stanza
        - `<token>:stanza.baseform`: grundform
        - `<token>:stanza.pos`: ordklasstagg
        - `<token>:stanza.upos`: universella ordklasstaggar
        - `<token>:stanza.ufeats`: universella morfologiska särdrag (features)
        - `<token>:stanza.ref`: ordets position i meningen
        - `<token>:stanza.dephead_ref`: dependenshuvud, ref för det ord som detta ord modifierar eller är beroende av
        - `<token>:stanza.deprel`: dependensrelation, den relation detta ord har till sitt dependenshuvud
