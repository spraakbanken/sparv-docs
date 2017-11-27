Sparv har ett API som ligger på adressen:

> `https://ws.spraakbanken.gu.se/ws/sparv/v2/`


## Anrop för att annotera text
Frågor till nättjänsten kan göras med ett enkelt GET-anrop:

> `https://ws.spraakbanken.gu.se/ws/sparv/v2/?text=En+exempelmening+till+nättjänsten`

Svaret kommer i form av ett XML-objekt. För detta anropet blir svaret:

    <result>
    <build hash="edb2a4717701a65b721d97834a56b129dc3bf6aa"/>
    <corpus link="https://ws.spraakbanken.gu.se/ws/sparv/v2/download?hash=edb2a4717701a65b721d97834a56b129dc3bf6aa">
    <text lix="54.00" ovix="inf" nk="inf">
    <paragraph>
    <sentence id="8f7-84d">
    <w pos="DT" msd="DT.UTR.SIN.IND" lemma="|en|" lex="|en..al.1|" sense="|den..1:-1.000|en..2:-1.000|" complemgram="|" compwf="|" sentiment="0.6799" ref="1" dephead="2" deprel="DT">En</w>
    <w pos="NN" msd="NN.UTR.SIN.IND.NOM" lemma="|exempelmening|" lex="|" sense="|" complemgram="|exempel..nn.1+mening..nn.1:7.044e-09|" compwf="|exempel+mening|" ref="2" deprel="ROOT">exempelmening</w>
    <w pos="PP" msd="PP" lemma="|till|" lex="|till..pp.1|" sense="|till..1:-1.000|" complemgram="|" compwf="|" sentiment="0.5086" ref="3" dephead="2" deprel="ET">till</w>
    <w pos="NN" msd="NN.UTR.SIN.DEF.NOM" lemma="|nättjänst|nättjänsten|" lex="|" sense="|" complemgram="|nät..nn.1+tjänst..nn.2:6.813e-11|nät..nn.1+tjänst..nn.1:6.813e-11|nätt..av.1+tjänst..nn.1:1.039e-12|nätt..av.1+tjänst..nn.2:1.039e-12|nät..nn.1+tjäna..vb.1+sten..nn.1:1.047e-26|nät..nn.1+tjäna..vb.1+sten..nn.2:1.047e-26|nätt..av.1+tjäna..vb.1+sten..nn.2:2.120e-27|nätt..av.1+tjäna..vb.1+sten..nn.1:2.120e-27|" compwf="|nät+tjänsten|nätt+tjänsten|nät+tjän+sten|nätt+tjän+sten|" ref="4" dephead="3" deprel="PA">nättjänsten</w>
    </sentence>
    </paragraph>
    </text>
    </corpus>
    </result>

För större texter stöds också POST-anrop som skickas till samma address. Ett exempel med curl:

> `curl -X POST --data-binary text="En exempelmening till nättjänsten" https://ws.spraakbanken.gu.se/ws/sparv/v2/`

Svaret blir samma som för ovanstående GET-anropet.

Det är också möjligt att ladda upp XML- eller textfiler med curl:

> `curl -X POST -F files[]=@/path/to/file/myfile.txt https://ws.spraakbanken.gu.se/ws/sparv/v2/upload?`

Svaret är en nedladdningslänk till en zip-fil som innehåller annotationen.


## Inställningar
Nättjänsten har stöd för bland annat att byta ord-, mening- och
styckessegmenterare och vilka attribut som ska genereras. Dessa
ges som ett JSON-objekt till `settings`-variabeln. Detta objekt
måste uppfylla JSON-schemat som fås av detta anrop:

> `https://ws.spraakbanken.gu.se/ws/sparv/v2/schema`

Eftersom schemat innehåller `default`-värden för alla inställningar
är detta argument valfritt, och alla inställningar behövs inte anges.

Ett anrop där bara dependensinformationen genereras ser ut så här:

> `https://ws.spraakbanken.gu.se/ws/sparv/v2/?text=Det+trodde+jag+aldrig.&settings={"positional_attributes":{"dependency_attributes":["ref","dephead","deprel"],"lexical_attributes":[],"compound_attributes":[]}}`

På [frontenden](http://spraakbanken.gu.se/sparv) så finns en
knapp `Visa Formulärets JSON` under `Visa avancerade inställningar`
som visar formulärets JSON-objekt som skickas med i `settings`-variabeln.

Makefilen som genereras för ett visst inställningsobjekt kan också fås. Ett
anrop ser ut så här:

> `https://ws.spraakbanken.gu.se/ws/sparv/v2/makefile?settings={"positional_attributes":{"dependency_attributes":["ref","dephead","deprel"],"lexical_attributes":[],"compound_attributes":[]}}`

## Återuppta byggen
Längst upp i svarets XML finns ett hash-nummer i `build`-taggens
`hash`-attribut. Detta kan användas för att återuppta byggen. För att visa
första exemplet ovan används detta anrop:

> `https://ws.spraakbanken.gu.se/ws/sparv/v2/join?hash=edb2a4717701a65b721d97834a56b129dc3bf6aa`

Svaret innehåller förutom det annoterade resultatet också orginaltexten och
vilka inställningar som användes (grundinställningarna). Hela svaret ser ut så
här:

    <result>
        <settings>{
          "root": {
            "attributes": [],
            "tag": "text"
          },
          "text_attributes": {
            "readability_metrics": [
              "lix",
              "ovix",
              "nk"
            ]
          },
          "word_segmenter": "default_tokenizer",
          "positional_attributes": {
            "lexical_attributes": [
              "pos",
              "msd",
              "lemma",
              "lex",
              "sense"
            ],
            "compound_attributes": [
              "complemgram",
              "compwf"
            ],
            "dependency_attributes": [
              "ref",
              "dephead",
              "deprel"
            ],
            "sentiment": [
              "sentiment"
            ]
          },
          "sentence_segmentation": {
            "sentence_chunk": "paragraph",
            "sentence_segmenter": "default_tokenizer"
          },
          "paragraph_segmentation": {
            "paragraph_segmenter": "blanklines"
          },
          "lang": "sv",
          "textmode": "plain",
          "named_entity_recognition": [],
          "corpus": "untitled"
    }</settings>
    <original>&lt;text&gt;En exempelmening till nättjänsten&lt;/text&gt;</original>
    <build hash='edb2a4717701a65b721d97834a56b129dc3bf6aa'/>
    <corpus link='https://ws.spraakbanken.gu.se/ws/sparv/v2/download?hash=edb2a4717701a65b721d97834a56b129dc3bf6aa'>
        <text lix="54.00" ovix="inf" nk="inf">
            <paragraph>
                <sentence id="8f7-84d">
                    <w pos="DT" msd="DT.UTR.SIN.IND" lemma="|en|" lex="|en..al.1|" sense="|den..1:-1.000|en..2:-1.000|" complemgram="|" compwf="|" sentiment="0.6799" ref="1" dephead="2" deprel="DT">En</w>
                    <w pos="NN" msd="NN.UTR.SIN.IND.NOM" lemma="|exempelmening|" lex="|" sense="|" complemgram="|exempel..nn.1+mening..nn.1:7.044e-09|" compwf="|exempel+mening|" ref="2" deprel="ROOT">exempelmening</w>
                    <w pos="PP" msd="PP" lemma="|till|" lex="|till..pp.1|" sense="|till..1:-1.000|" complemgram="|" compwf="|" sentiment="0.5086" ref="3" dephead="2" deprel="ET">till</w>
                    <w pos="NN" msd="NN.UTR.SIN.DEF.NOM" lemma="|nättjänst|nättjänsten|" lex="|" sense="|" complemgram="|nät..nn.1+tjänst..nn.2:6.813e-11|nät..nn.1+tjänst..nn.1:6.813e-11|nätt..av.1+tjänst..nn.1:1.039e-12|nätt..av.1+tjänst..nn.2:1.039e-12|nät..nn.1+tjäna..vb.1+sten..nn.1:1.047e-26|nät..nn.1+tjäna..vb.1+sten..nn.2:1.047e-26|nätt..av.1+tjäna..vb.1+sten..nn.2:2.120e-27|nätt..av.1+tjäna..vb.1+sten..nn.1:2.120e-27|" compwf="|nät+tjänsten|nätt+tjänsten|nät+tjän+sten|nätt+tjän+sten|" ref="4" dephead="3" deprel="PA">nättjänsten</w>
                </sentence>
            </paragraph>
        </text>
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

> `https://ws.spraakbanken.gu.se/ws/sparv/v2/?text=Nun+folgt+ein+deutscher+Beispielsatz.&settings={"lang":"de"}`

Beroende på vilket språk man väljer, finns det stöd för
olika annotationer och verktyg. Använd [frontenden](http://spraakbanken.gu.se/sparv)
för att enklast se vilka valmöjligheter som finns för ett visst språk.

## Inkrementell framstegsinformation

Med flaggan till anropen ovan `incremental=true` fås information om hur
byggprocessen förlöper. Ett exempelanrop ser ut så här:

> `https://ws.spraakbanken.gu.se/ws/sparv/v2/?text=Nu+med+inkrementell+information&incremental=true`

Resultat-XML:en innehåller då dessa extra taggar:

    <increment command="" step="0" steps="27"/>
    <increment command="sb.segment" step="1" steps="27"/>
    <increment command="sb.segment" step="2" steps="27"/>
    <increment command="sb.number --position" step="3" steps="27"/>
    <increment command="sb.segment" step="4" steps="27"/>
    <increment command="sb.annotate --span_as_value" step="5" steps="27"/>
    <increment command="sb.annotate --text_spans" step="6" steps="27"/>
    <increment command="sb.parent --children" step="7" steps="27"/>
    <increment command="sb.parent --parents" step="8" steps="27"/>
    <increment command="sb.parent --parents" step="9" steps="27"/>
    <increment command="sb.parent --parents" step="10" steps="27"/>
    <increment command="sb.number --position" step="11" steps="27"/>
    <increment command="sb.hunpos" step="12" steps="27"/>
    <increment command="sb.number --relative" step="13" steps="27"/>
    <increment command="sb.annotate --select" step="14" steps="27"/>
    <increment command="sb.saldo" step="15" steps="27"/>
    <increment command="sb.readability --lix" step="16" steps="27"/>
    <increment command="sb.readability --ovix" step="17" steps="27"/>
    <increment command="sb.readability --nominal_ratio" step="18" steps="27"/>
    <increment command="sb.compound" step="19" steps="27"/>
    <increment command="sb.wsd" step="20" steps="27"/>
    <increment command="sb.malt" step="21" steps="27"/>
    <increment command="sb.sentiment" step="22" steps="27"/>
    <increment command="sb.annotate --select" step="23" steps="27"/>
    <increment command="sb.annotate --select" step="24" steps="27"/>
    <increment command="sb.annotate --chain" step="25" steps="27"/>
    <increment command="sb.cwb --export" step="26" steps="27"/>
    <increment command="" step="27" steps="27"/>

Denna variabel kan kombineras med `settings`, samt med `/join`, och med POST-anrop.

## Övriga anrop

Du kan få en kort översikt över alla anrop här:

> `https://ws.spraakbanken.gu.se/ws/sparv/v2/api`


<!--
## Övriga anrop
Visar om nättjänstens python-bakända svarar på ping:

> `https://ws.spraakbanken.gu.se/ws/sparv/v2/ping`

Statusarna för alla byggen:

> `https://ws.spraakbanken.gu.se/ws/sparv/v2/status`

Ta bort byggen som inte hämtats på över 24 timmar:

> `https://ws.spraakbanken.gu.se/ws/sparv/v2/cleanup`

Ta bort felaktiga byggen:

> `https://ws.spraakbanken.gu.se/ws/sparv/v2/cleanup/errors`

Visa nättjänstens api i ett swagger-ui JSON-schema:

> `https://ws.spraakbanken.gu.se/ws/sparv/v2/api`
-->
