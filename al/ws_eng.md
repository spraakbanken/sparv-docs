The Annotation Laboratory has an API which is available at the following address:

> `https://spraakbanken.gu.se/ws/korp/annotate`


## Queries for Annotating Texts
Queries to the web service can be sent as a simple GET request:

> `https://spraakbanken.gu.se/ws/korp/annotate?text=En+exempelmening+till+nättjänsten`

The response is an XML-objekt which for the above request looks like this:

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

POST requests are also supported using the same address. This can be useful for longer texts.
Here is an example using curl:

> `curl -X POST --data-binary text="En exempelmening till nättjänsten" https://spraakbanken.gu.se/ws/korp/annotate`

The response is the same as for the above GET request.


## Settings
The web service supports some costum settings, e.g. it lets you chose
between different tokenizers on word, sentence, and paragraph level
and you can define which annotations should be generated.

These settings can be provided as a JSON object to the `settings` variable.
This object must satisfy the JSON schema available at the following adress:

> `https://spraakbanken.gu.se/ws/korp/annotate/schema`

The schema holds default values for all the attributes. The use of the settings
variable is therefore optional.

A request which only generates a dependency analysis could look like this:

> `https://spraakbanken.gu.se/ws/korp/annotate?text=Det+trodde+jag+aldrig.&settings={"positional_attributes":{"dependency_attributes":["ref","dephead","deprel"],"lexical_attributes":[],"compound_attributes":[]}}`

If you are not sure how to define the settings variable you can get help from the
[frontend](https://spraakbanken.gu.se/korp/annoteringslabbet) by clicking
`Visa Formulärets JSON` under `Show advanced settings`. This will generate
the JSON-objekt for the chosen settings which is sent in the `settings` variable.

The makefile which is generated for a certain set of settings can be viewed by
sending a `makefile` query:

> `https://spraakbanken.gu.se/ws/korp/annotate/makefile?settings={"positional_attributes":{"dependency_attributes":["ref","dephead","deprel"],"lexical_attributes":[],"compound_attributes":[]}}`

## Joining a Build
At the top of the XML response you can find a hash number inside the `build`-tag.
This hash can be used to join a build of an earlier build.

The following request is used for joining the build from the first example of this documentation:

> `https://spraakbanken.gu.se/ws/korp/annotate/join?hash=4a09b377f4590c81af7e19a9afe1d7f0a6149873`

The response contains the chosen settings, the original text and of course the
result of the annotation. The entire response looks like this:

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

## Analysing Texts in Other Languages

The default analysis language is Swedish but the Annotation Laboratory
also supports other languages. The language is specified through
the `lang` attribute in the `settings` variable.

The following languages are currently supported:

* Bulgarian (bg)
* Dutch (nl)
* English (en)
* Estonian (et)
* Finish (fi)
* French (fr)
* German (de)
* Italian (it)
* Latin (la)
* Polish (pl)
* Portuguese (pt)
* Russian (ru)
* Slovak (sk)
* Spanish (es)

This is an example of an analysis of a German sentence:

> `https://spraakbanken.gu.se/ws/korp/annotate?text=Nun+folgt+ein+deutscher+Beispielsatz.&settings={"lang":"de"}`

Different kinds of settings are supported for different languages.
Please use the [frontend](https://spraakbanken.gu.se/korp/annoteringslabbet)
if you want to check which options there are for a certain language.


## Incremental Progress Information

By adding the flag `incremental=true` to your usual query you can
receive more information on how your analysis is being processed.
An example query could look like this:

> `https://spraakbanken.gu.se/ws/korp/annotate?text=Nu+med+inkrementell+information&incremental=true`

The resulting XML will contain the following extra tags:

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

This variable can of course be combined with `settings`, `/join`, and with POST requests.

<!--
## Övriga anrop
Visar om nättjänstens python-bakända svarar på ping:

> `https://spraakbanken.gu.se/ws/korp/annotate/ping`

Statusarna för alla byggen:

> `https://spraakbanken.gu.se/ws/korp/annotate/status`

Ta bort byggen som inte hämtats på över 24 timmar:

> `https://spraakbanken.gu.se/ws/korp/annotate/cleanup`

Ta bort felaktiga byggen:

> `https://spraakbanken.gu.se/ws/korp/annotate/cleanup/errors`

Visa nättjänstens api i ett swagger-ui JSON-schema:

> `https://spraakbanken.gu.se/ws/korp/annotate/api`
-->
