
## Annotationer i Sparv

För texter som är skrivna i nusvenska kan Sparv generera följande typer av annotationer:

* Ordklasstaggning:
    * `pos`: ordklasstagg (av engelskans 'part of speech'), se http://spraakbanken.gu.se/korp/markup/msdtags.html
    * `msd`: morfosyntaktisk tagg, se http://spraakbanken.gu.se/korp/markup/msdtags.html

    Verktyg: [Hunpos](http://code.google.com/p/hunpos/),
    Modell: egen modell tränad på [SUC 3.0](https://spraakbanken.gu.se/swe/resurs/suc3)


* SALDO-baserade analyser:
    * `baseform`: grundform
    * `lemgram`: lemgram, en formenhet som identifierar böjningstabellen
    * `sense`: identifierar en betydelse i SALDO samt dess sannolikhet
    * (`saldo`: identifierar en betydelse i SALDO - *kommer att tas bort snart*)
    * `sentiment`: attitydvärde


* Sammansättningsanalys (också baserad på SALDO):
    * `complemgram`: sammansatt lemgram
    * `compwf`: sammansatt ordform
    * (`prefix`: förled vid sammansättningar - *kommer att tas bort snart*)
    * (`suffix`: efterled vid sammansättningar - *kommer att tas bort snart*)


* Dependensanalys:
    * `ref`: ordets position i meningen
    * `dephead`: dependenshuvud, ref för det ord som detta ord modifierar eller är beroende av
    * `deprel`: dependensrelation, den relation detta ord har till sitt dependenshuvud, se http://stp.ling.uu.se/~nivre/swedish_treebank/dep.html

    Verktyg: [MaltParser](http://www.maltparser.org/download.html),
    Modell: swemalt, tränad på Svensk trädbank


* Namnigenkänning:
    * `ne.ex`: namnentitet (namnuttryck, numerisk uttryck eller tidsuttryck)
    * `ne.type`: namnentitetstyp
    * `ne.subtype`: namnentitetsundertyp

    Verktyg: [hfst-SweNER](http://www.ling.helsinki.fi/users/janiemi/finclarin/ner/hfst-swener-0.9.3.tgz)

    Referenser: [HFST-SweNER – A New NER Resource for Swedish](http://www.lrec-conf.org/proceedings/lrec2014/pdf/391_Paper.pdf), [Reducing the effect of name explosion](http://demo.spraakdata.gu.se/svedk/pbl/kokkinakisBNER.pdf)


* Läsbarhetsindex:
    * `text.lix`: LIX, läsbarhetsindex
    * `text.ovix`: OVIX, ordvariationsindex
    * `text.nk`: Nominalkvot


* Lexikala klasser:
    * `blingbring`: lexikala klasser från Blingbring-resursen (på ordnivå)
    * `swefn`: ramar fråm swedish FrameNet (på ordnivå)
    * `text.blingbring`: lexikala klasser från Blingbring-resursen (på dokumentnivå)
    * `text.swefn`: ramar fråm swedish FrameNet (på dokumentnivå)


Äldre svenska texter eller texter som är skrivna på andra språk kan i vissa fall
märkas upp med en delmängd av ovanstående annotationstyper.

Annotationen `msd` för icke-svenska språk är baserad på olika taggmängder,
beroende på språket och på vilket verktyg som har använts för annotationen. Attributet
innehåller information om ordklass och i många fall även morfosyntaktisk information.
Annotationen `pos` innehåller enbart orklassinformation och använder sig av
taggmängden ["universal POS tags"](http://universaldependencies.org/u/pos/).
