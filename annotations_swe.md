
För texter som är skrivna i nusvenska kan Sparv generera följande typer av annotationer:

* Ordklasstaggning:
  * pos: ordklasstagg (av engelskans 'part of speech'), se http://spraakbanken.gu.se/korp/markup/msdtags.html
  * msd: morfosyntaktisk tagg, se http://spraakbanken.gu.se/korp/markup/msdtags.html

* SALDO-baserade analyser:
  * baseform: grundform
  * lemgram: lemgram, en formenhet som identifierar böjningstabellen
  * sense: identifierar en betydelse i SALDO samt dess sannolikhet
  * (saldo: identifierar en betydelse i SALDO - *kommer att tas bort snart*)

* Sammansättningsanalys (också baserad på SALDO):
  * complemgram: sammansatt lemgram
  * compwf: sammansatt ordform
  * (prefix: förled vid sammansättningar - *kommer att tas bort snart*)
  * (suffix: efterled vid sammansättningar - *kommer att tas bort snart*)

* Dependensanalys:
  * ref: ordets position i meningen
  * dephead: dependenshuvud, ref för det ord som detta ord modifierar eller är beroende av
  * deprel: dependensrelation, den relation detta ord har till sitt dependenshuvud, se http://stp.ling.uu.se/~nivre/swedish_treebank/dep.html

* Namnigenkänning:
  * ne.ex: namnentitet (namnuttryck, numerisk uttryck eller tidsuttryck)
  * ne.type: namnentitetstyp
  * ne.subtype: namnentitetsundertyp

* Läsbarhetsindex:
  * text.lix: LIX, läsbarhetsindex
  * text.ovix: OVIX, ordvariationsindex
  * text.nk: Nominalkvot


Äldre svenska texter eller texter som är skrivna på andra språk kan i vissa fall
märkas upp med en delmängd av ovanstående annotationstyper.
