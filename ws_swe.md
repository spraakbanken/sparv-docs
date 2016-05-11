Sparv har ett API som ligger på adressen:

> `https://ws.spraakbanken.gu.se/ws/sparv/v1`


## Anrop för att annotera text
Frågor till nättjänsten kan göras med ett enkelt GET-anrop:

> `https://ws.spraakbanken.gu.se/ws/sparv/v1?text=En+exempelmening+till+nättjänsten`

Svaret kommer i form av ett XML-objekt. För detta anropet blir svaret:

    <result>
    <build hash="cf97c7d78bfca58ab6ab575b365e3c74a6174852"/>
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

> `curl -X POST --data-binary text="En exempelmening till nättjänsten" https://ws.spraakbanken.gu.se/ws/sparv/v1/annotate`

Svaret blir samma som för ovanstående GET-anropet.

Det är också möjligt att ladda upp XML- eller textfiler med curl:

> `curl -X POST -F files[]=@/path/to/file/myfile.txt https://ws.spraakbanken.gu.se/ws/sparv/v1/upload?`

Svaret är en nedladdningslänk till en zip-fil som innehåller annotationen.


## Inställningar
Nättjänsten har stöd för bland annat att byta ord-, mening- och
styckessegmenterare och vilka attribut som ska genereras. Dessa
ges som ett JSON-objekt till `settings`-variabeln. Detta objekt
måste uppfylla JSON-schemat som fås av detta anrop:

> `https://ws.spraakbanken.gu.se/ws/sparv/v1/annotate/schema`

Eftersom schemat innehåller `default`-värden för alla inställningar
är detta argument valfritt, och alla inställningar behövs inte anges.

Ett anrop där bara dependensinformationen genereras ser ut så här:

> `https://ws.spraakbanken.gu.se/ws/sparv/v1/annotate?text=Det+trodde+jag+aldrig.&settings={"positional_attributes":{"dependency_attributes":["ref","dephead","deprel"],"lexical_attributes":[],"compound_attributes":[]}}`

På [framändan](http://spraakbanken.gu.se/sparv) så finns en
knapp `Visa Formulärets JSON` under `Visa avancerade inställningar`
som visar formulärets JSON-objekt som skickas med i `settings`-variabeln.

Makefilen som genereras för ett visst inställningsobjekt kan också fås. Ett
anrop ser ut så här:

> `https://ws.spraakbanken.gu.se/ws/sparv/v1/annotate/makefile?settings={"positional_attributes":{"dependency_attributes":["ref","dephead","deprel"],"lexical_attributes":[],"compound_attributes":[]}}`

## Återuppta byggen
Längst upp i svarets XML finns ett hash-nummer i `build`-taggens
`hash`-attribut. Detta kan användas för att återuppta byggen. För att visa
första exemplet ovan används detta anrop:

> `https://ws.spraakbanken.gu.se/ws/sparv/v1/annotate/join?hash=cf97c7d78bfca58ab6ab575b365e3c74a6174852`

Svaret innehåller förutom det annoterade resultatet också orginaltexten och
vilka inställningar som användes (grundinställningarna). Hela svaret ser ut så
här:

    <result>
      <settings>{
          "lang": "sv",
          "extra_tags": [],
          "textmode": "plain",
          "sentence_segmentation": {
              "sentence_segmenter": "default_tokenizer",
              "sentence_chunk": "paragraph"
          },
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
          "paragraph_segmentation": {
              "paragraph_segmenter": "blanklines",
              "paragraph_chunk": "root"
          },
          "corpus": "untitled",
          "root": {
              "attributes": [],
              "tag": "text"
          },
          "word_segmenter": "default_tokenizer"
      }</settings>
      <original>En exempelmening till nättjänsten</original>
      <build hash="cf97c7d78bfca58ab6ab575b365e3c74a6174852"/>
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

> `https://ws.spraakbanken.gu.se/ws/sparv/v1/annotate?text=Nun+folgt+ein+deutscher+Beispielsatz.&settings={"lang":"de"}`

Beroende på vilket språk man väljer, finns det stöd för
olika annotationer och verktyg. Använd [framändan](http://spraakbanken.gu.se/sparv)
för att enklast se vilka valmöjligheter som finns för ett visst språk.

## Inkrementell framstegsinformation

Med flaggan till anropen ovan `incremental=true` fås information om hur
byggprocessen förlöper. Ett exempelanrop ser ut så här:

> `https://ws.spraakbanken.gu.se/ws/sparv/v1/annotate?text=Nu+med+inkrementell+information&incremental=true`

Resultat-XML:en innehåller då dessa extra taggar:

    <increment command="" step="0" steps="21"/>
    <increment command="sb.segment" step="1" steps="21"/>
    <increment command="sb.segment" step="2" steps="21"/>
    <increment command="sb.number --position" step="3" steps="21"/>
    <increment command="sb.segment" step="4" steps="21"/>
    <increment command="sb.annotate --span_as_value" step="5" steps="21"/>
    <increment command="sb.parent --parents" step="6" steps="21"/>
    <increment command="sb.parent --parents" step="7" steps="21"/>
    <increment command="sb.annotate --text_spans" step="8" steps="21"/>
    <increment command="sb.parent --children" step="9" steps="21"/>
    <increment command="sb.number --position" step="10" steps="21"/>
    <increment command="sb.hunpos" step="11" steps="21"/>
    <increment command="sb.number --relative" step="12" steps="21"/>
    <increment command="sb.annotate --select" step="13" steps="21"/>
    <increment command="sb.compound_simple" step="14" steps="21"/>
    <increment command="sb.saldo" step="15" steps="21"/>
    <increment command="sb.malt" step="16" steps="21"/>
    <increment command="sb.annotate --select" step="17" steps="21"/>
    <increment command="sb.annotate --select" step="18" steps="21"/>
    <increment command="sb.annotate --chain" step="19" steps="21"/>
    <increment command="sb.cwb --export" step="20" steps="21"/>
    <increment command="" step="21" steps="21"/>

Denna variabel kan kombineras med `settings`, samt med `/join`, och med POST-anrop.

<!--
## Övriga anrop
Visar om nättjänstens python-bakända svarar på ping:

> `https://ws.spraakbanken.gu.se/ws/sparv/v1/annotate/ping`

Statusarna för alla byggen:

> `https://ws.spraakbanken.gu.se/ws/sparv/v1/annotate/status`

Ta bort byggen som inte hämtats på över 24 timmar:

> `https://ws.spraakbanken.gu.se/ws/sparv/v1/annotate/cleanup`

Ta bort felaktiga byggen:

> `https://ws.spraakbanken.gu.se/ws/sparv/v1/annotate/cleanup/errors`

Visa nättjänstens api i ett swagger-ui JSON-schema:

> `https://ws.spraakbanken.gu.se/ws/sparv/v1/annotate/api`
-->
