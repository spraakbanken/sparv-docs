Annoteringslabbet har ett API som ligger på adressen:

> `http://spraakbanken.gu.se/ws/korp/annotate`


## Anrop för att annotera text
Frågor till nättjänsten kan göras med ett enkelt GET-anrop:

> `http://spraakbanken.gu.se/ws/korp/annotate?text=En+exempelmening+till+nättjänsten`

Svaret kommer i form av ett XML-objekt. För detta anropet blir svaret:

    <result>
    <build hash='4a09b377f4590c81af7e19a9afe1d7f0a6149873'/>
    <corpus>
    <paragraph>
    <sentence id="8f7-84d">
    <w pos="DT" msd="DT.UTR.SIN.IND" lemma="|en|" lex="|en..al.1|" saldo="|den..1|en..2|" prefix="|" suffix="|" ref="1" dephead="2" deprel="DT">En</w>
    <w pos="NN" msd="NN.UTR.SIN.IND.NOM" lemma="|" lex="|" saldo="|" prefix="|exempel..nn.1|" suffix="|mening..nn.1|" ref="2" dephead="" deprel="ROOT">exempelmening</w>
    <w pos="PP" msd="PP" lemma="|till|" lex="|till..pp.1|" saldo="|till..1|" prefix="|" suffix="|" ref="3" dephead="2" deprel="ET">till</w>
    <w pos="NN" msd="NN.UTR.SIN.DEF.NOM" lemma="|" lex="|" saldo="|" prefix="|nät..nn.1|nätt..av.1|" suffix="|tjänst..nn.2|tjänst..nn.1|" ref="4" dephead="3" deprel="PA">nättjänsten</w>
    </sentence>
    </paragraph>
    </corpus>
    </result>

För större texter stöds också POST-anrop som skickas till samma address. Ett exempel med curl:

> `curl -X POST --data-binary text="En exempelmening till nättjänsten" http://spraakbanken.gu.se/ws/korp/annotate`

Svaret blir samma som för ovanstående GET-anropet.


## Inställningar
Nättjänsten har stöd för bland annat att byta ord-, mening- och
styckessegmenterare och vilka attribut som ska genereras. Dessa
ges som ett JSON-objekt till `settings`-variabeln. Detta objekt
måste uppfylla JSON-schemat som fås av detta anrop:

> `http://spraakbanken.gu.se/ws/korp/annotate/schema`

Eftersom schemat innehåller `default`-värden för alla inställningar
är detta argument valfritt, och alla inställningar behövs inte anges.

Ett anrop där bara dependensinformationen genereras ser ut så här:

> `http://spraakbanken.gu.se/ws/korp/annotate?text=Det+trodde+jag+aldrig.&settings={"positional_attributes":{"dependency_attributes":["ref","dephead","deprel"],"lexical_attributes":[],"compound_attributes":[]}}`

På [framändan](http://spraakbanken.gu.se/korp/annoteringslabbet) så finns en
knapp `Visa Formulärets JSON` under `Visa avancerade inställningar`
som visar formulärets JSON-objekt som skickas med i `settings`-variabeln.

Makefilen som genereras för ett visst inställningsobjekt kan också fås. Ett
anrop ser ut så här:

> `http://spraakbanken.gu.se/ws/korp/annotate/makefile?settings={"positional_attributes":{"dependency_attributes":["ref","dephead","deprel"],"lexical_attributes":[],"compound_attributes":[]}}`

## Återuppta byggen
Längst upp i svarets XML finns ett hash-nummer i `build`-taggens
`hash`-attribut. Detta kan användas för att återuppta byggen. För att visa
första exemplet ovan används detta anrop:

> `http://spraakbanken.gu.se/ws/korp/annotate/join?hash=4a09b377f4590c81af7e19a9afe1d7f0a6149873`

Svaret innehåller förutom det annoterade resultatet också orginaltexten och
vilka inställningar som användes (grundinställningarna). Hela svaret ser ut så
här:

    <result>
    <settings>{
      "lang": "sv",
      "extra_tags": [],
      "paragraph_segmenter": "blanklines",
      "sentence_segmenter": "punkt_sentence",
      "positional_attributes": {
        "dependency_attributes": [
          "ref",
          "dephead",
          "deprel"
          ],
        "lexical_attributes": [
          "pos",
          "msd",
          "lemma",
          "lex",
          "saldo"
          ],
        "compound_attributes": [
          "prefix",
          "suffix"
          ]
      },
      "corpus": "untitled",
      "root": {
          "attributes": [],
          "tag": "text"
      },
      "word_segmenter": "better_word"
    }</settings>
    <original>En exempelmening till nättjänsten</original>
    <build hash="4a09b377f4590c81af7e19a9afe1d7f0a6149873"/>
    <corpus>
    <paragraph>
    <sentence id="8f7-84d">
    <w pos="DT" msd="DT.UTR.SIN.IND" lemma="|en|" lex="|en..al.1|" saldo="|den..1|en..2|" prefix="|" suffix="|" ref="1" dephead="2" deprel="DT">En</w>
    <w pos="NN" msd="NN.UTR.SIN.IND.NOM" lemma="|" lex="|" saldo="|" prefix="|exempel..nn.1|" suffix="|mening..nn.1|" ref="2" dephead="" deprel="ROOT">exempelmening</w>
    <w pos="PP" msd="PP" lemma="|till|" lex="|till..pp.1|" saldo="|till..1|" prefix="|" suffix="|" ref="3" dephead="2" deprel="ET">till</w>
    <w pos="NN" msd="NN.UTR.SIN.DEF.NOM" lemma="|" lex="|" saldo="|" prefix="|nät..nn.1|nätt..av.1|" suffix="|tjänst..nn.2|tjänst..nn.1|" ref="4" dephead="3" deprel="PA">nättjänsten</w>
    </sentence>
    </paragraph>
    </corpus>
    </result>

## Analys av andra språk än svenska

Som standard sker analysen på svenska, men det finns även stöd för
andra språk. Språkval görs genom `settings`-variabeln `lang`.
För närvarande finns det stöd för följande språk:

* bulgariska (bg)
* engelska (en)
* estniska (et)
* finska (fi)
* franska (fr)
* italienska (it)
* latin (la)
* nederländska (nl)
* polska (pl)
* portugisiska (pt)
* ryska (ru)
* slovakiska (sk)
* spanska (es)
* tyska (de)

Ett exempel på analys av tyska kan se ut så här:

> `http://spraakbanken.gu.se/ws/korp/annotate?text=Nun+folgt+ein+deutscher+Beispielsatz.&settings={"lang":"de"}`

Beroende på vilket språk man väljer, finns det stöd för
olika annotationer och verktyg. Använd [framändan](http://spraakbanken.gu.se/korp/annoteringslabbet)
för att enklast se vilka valmöjligheter som finns för ett visst språk.

## Inkrementell framstegsinformation

Med flaggan till anropen ovan `incremental=true` fås information om hur
byggprocessen förlöper. Ett exempelanrop ser ut så här:

> `http://spraakbanken.gu.se/ws/korp/annotate?text=Nu+med+inkrementell+information&incremental=true`

Resultat-XML:en innehåller då dessa extra taggar:

    <increment command="" step="0" steps="23"/>
    <increment command="sb.fileid" step="1" steps="23"/>
    <increment command="sb.xmlparser" step="2" steps="23"/>
    <increment command="sb.segment" step="3" steps="23"/>
    <increment command="sb.segment" step="4" steps="23"/>
    <increment command="sb.number --position" step="5" steps="23"/>
    <increment command="sb.segment" step="6" steps="23"/>
    <increment command="sb.annotate --span_as_value" step="7" steps="23"/>
    <increment command="sb.parent --parents" step="8" steps="23"/>
    <increment command="sb.parent --parents" step="9" steps="23"/>
    <increment command="sb.annotate --text_spans" step="10" steps="23"/>
    <increment command="sb.parent --children" step="11" steps="23"/>
    <increment command="sb.number --position" step="12" steps="23"/>
    <increment command="sb.hunpos" step="13" steps="23"/>
    <increment command="sb.number --relative" step="14" steps="23"/>
    <increment command="sb.annotate --translate_tag" step="15" steps="23"/>
    <increment command="sb.saldo" step="16" steps="23"/>
    <increment command="sb.compound" step="17" steps="23"/>
    <increment command="sb.malt" step="18" steps="23"/>
    <increment command="sb.annotate --select" step="19" steps="23"/>
    <increment command="sb.annotate --select" step="20" steps="23"/>
    <increment command="sb.annotate --chain" step="21" steps="23"/>
    <increment command="sb.cwb --export" step="22" steps="23"/>
    <increment command="" step="23" steps="23"/>

Denna variabel kan kombineras med `settings`, samt med `/join`, och med POST-anrop.

<!--
## Övriga anrop
Visar om nättjänstens python-bakända svarar på ping:

> `http://spraakbanken.gu.se/ws/korp/annotate/ping`

Statusarna för alla byggen:

> `http://spraakbanken.gu.se/ws/korp/annotate/status`

Ta bort byggen som inte hämtats på över 24 timmar:

> `http://spraakbanken.gu.se/ws/korp/annotate/cleanup`

Ta bort felaktiga byggen:

> `http://spraakbanken.gu.se/ws/korp/annotate/cleanup/errors`

Visa nättjänstens api i ett swagger-ui JSON-schema:

> `http://spraakbanken.gu.se/ws/korp/annotate/api`
-->
