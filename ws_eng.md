
Sparv has an API which is available at the following address:

> `https://ws.spraakbanken.gu.se/ws/sparv/latest/`


## Queries for Annotating Texts
Queries to the web service can be sent as a simple GET request:

> `https://ws.spraakbanken.gu.se/ws/sparv/latest/?text=En+exempelmening+till+nättjänsten`

The response is an XML-objekt which for the above request looks like this:

    <result>
    <build hash="edb2a4717701a65b721d97834a56b129dc3bf6aa"/>
    <corpus link="https://ws.spraakbanken.gu.se/ws/sparv/latest/download?hash=edb2a4717701a65b721d97834a56b129dc3bf6aa">
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

POST requests are also supported using the same address. This can be useful for longer texts.
Here is an example using curl:

> `curl -X POST --data-binary text="En exempelmening till nättjänsten" https://ws.spraakbanken.gu.se/ws/sparv/latest/`

The response is the same as for the above GET request.

It is also possible to upload text or XML files using curl:

> `curl -X POST -F files[]=@/path/to/file/myfile.txt https://ws.spraakbanken.gu.se/ws/sparv/latest/upload?`

The response will be a download link to a zip file containing the annotation.


## Settings
The web service supports some costum settings, e.g. it lets you chose
between different tokenizers on word, sentence, and paragraph level
and you can define which annotations should be generated.

These settings can be provided as a JSON object to the `settings` variable.
This object must satisfy the JSON schema available at the following adress:

> `https://ws.spraakbanken.gu.se/ws/sparv/latest/schema`

The schema holds default values for all the attributes. The use of the settings
variable is therefore optional.

A request which only generates a dependency analysis could look like this:

> `https://ws.spraakbanken.gu.se/ws/sparv/latest/?text=Det+trodde+jag+aldrig.&settings={"positional_attributes":{"dependency_attributes":["ref","dephead","deprel"],"lexical_attributes":[],"compound_attributes":[]}}`

Or as a POST request using curl:

> `curl -X POST -g --data-binary text="Det trodde jag aldrig." 'https://ws.spraakbanken.gu.se/ws/sparv/latest/?settings={"positional_attributes":{"dependency_attributes":["ref","dephead","deprel"],"lexical_attributes":[],"compound_attributes":[]}}'`

If you are not sure how to define the settings variable you can get help from the
[frontend](https://spraakbanken.gu.se/sparv) by clicking
`Show JSON Settings` under `Show advanced settings`. This will generate
the JSON-objekt for the chosen settings which is sent in the `settings` variable.

The makefile which is generated for a certain set of settings can be viewed by
sending a `makefile` query:

> `https://ws.spraakbanken.gu.se/ws/sparv/latest/makefile?settings={"positional_attributes":{"dependency_attributes":["ref","dephead","deprel"],"lexical_attributes":[],"compound_attributes":[]}}`

## Joining a Build
At the top of the XML response you can find a hash number inside the `build`-tag.
This hash can be used to join a build of an earlier build.

The following request is used for joining the build from the first example of this documentation:

> `https://ws.spraakbanken.gu.se/ws/sparv/latest/join?hash=edb2a4717701a65b721d97834a56b129dc3bf6aa`

The response contains the chosen settings, the original text and of course the
result of the annotation. The entire response looks like this:

~~~
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
~~~

~~~
<original>&lt;text&gt;En exempelmening till nättjänsten&lt;/text&gt;</original>
<build hash='edb2a4717701a65b721d97834a56b129dc3bf6aa'/>
<corpus link='https://ws.spraakbanken.gu.se/ws/sparv/latest/download?hash=edb2a4717701a65b721d97834a56b129dc3bf6aa'>
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
~~~

## Analysing Texts in Other Languages

The default analysis language is Swedish but Sparv
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

> `https://ws.spraakbanken.gu.se/ws/sparv/latest/?text=Nun+folgt+ein+deutscher+Beispielsatz.&settings={"lang":"de"}`

Different kinds of settings are supported for different languages.
Please use the [frontend](https://spraakbanken.gu.se/sparv)
if you want to check which options there are for a certain language.


## Incremental Progress Information

By adding the flag `incremental=true` to your usual query you can
receive more information on how your analysis is being processed.
An example query could look like this:

> `https://ws.spraakbanken.gu.se/ws/sparv/latest/?text=Nu+med+inkrementell+information&incremental=true`

The resulting XML will contain the following extra tags:

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

This variable can of course be combined with `settings`, `/join`, and with POST requests.

## Other calls

You can get a short description of all existing API calls from the following address:

> `https://ws.spraakbanken.gu.se/ws/sparv/latest/api`

<!--
## Övriga anrop
Visar om nättjänstens python-bakända svarar på ping:

> `https://ws.spraakbanken.gu.se/ws/sparv/latest/ping`

Statusarna för alla byggen:

> `https://ws.spraakbanken.gu.se/ws/sparv/latest/status`

Ta bort byggen som inte hämtats på över 24 timmar:

> `https://ws.spraakbanken.gu.se/ws/sparv/latest/cleanup`

Ta bort felaktiga byggen:

> `https://ws.spraakbanken.gu.se/ws/sparv/latest/cleanup/errors`

Visa nättjänstens api i ett swagger-ui JSON-schema:

> `https://ws.spraakbanken.gu.se/ws/sparv/latest/api`
-->
