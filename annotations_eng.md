
## Available Sparv Annotations

For texts written in contemporary Swedish Sparv can generate the following types of annotations:


* Part of speech tagging:
    * `pos`: part of speech, see http://spraakbanken.gu.se/korp/markup/msdtags.html
    * `msd`: morphosyntactic tag, see http://spraakbanken.gu.se/korp/markup/msdtags.html

    Tool: [Hunpos](http://code.google.com/p/hunpos/),
    Model: in-house model trained on [SUC 3.0](https://spraakbanken.gu.se/swe/resurs/suc3)


* SALDO-based analysis:
    * `baseform`: citation form
    * `lemgram`: lemgram, identifies the inflectional table
    * `sense`: identifies a sense in SALDO and its probability
    * (`saldo`: identifies a sense in SALDO - *will be removed soon*)
    * `sentiment`: sentiment score


* Compound analysis (also based on SALDO):
    * `complemgram`: compound lemgram
    * `compwf`: compound word form
    * (`prefix`: initial part of a compound - *will be removed soon*)
    * (`suffix`: final part of a compound - *will be removed soon*)


* Dependency analysis:
    * `ref`: the position of the word in the sentence
    * `dephead`: dependency head, the ref of the word which the current word modifies or is dependent of
    * `deprel`: dependency relation, the relation of the current word to its dependency head, see http://stp.ling.uu.se/~nivre/swedish_treebank/dep.html

    Tool: [MaltParser](http://www.maltparser.org/download.html),
    Model: swemalt, trained on Swedish Treebank


* Named entity recognition:
    * `ne.ex`: named entity (name expression, numerical expression or time expression)
    * `ne.type`: named entity type
    * `ne.subtype`: named entity sub type

    Tool: [hfst-SweNER](http://www.ling.helsinki.fi/users/janiemi/finclarin/ner/hfst-swener-0.9.3.tgz)

    References: [HFST-SweNER – A New NER Resource for Swedish](http://www.lrec-conf.org/proceedings/lrec2014/pdf/391_Paper.pdf), [Reducing the effect of name explosion](http://demo.spraakdata.gu.se/svedk/pbl/kokkinakisBNER.pdf)

* Readability metrics:
    * `text.lix`: the Swedish readability metric LIX, läsbarhetsindex
    * `text.ovix`: the Swedish readability metric OVIX, ordvariationsindex
    * `text.nk`: the Swedish readability metric nominalkvot


* Lexical classes:
    * `blingbring`: lexical class from the Blingbring resource (on word level)
    * `swefn`: frames from swedish FrameNet (on word level)
    * `text.blingbring`: lexical class from the Blingbring resource (on document level)
    * `text.swefn`: frames from swedish FrameNet (on document level)


Older Swedish texts or texts written in other languages can often be annotated
with a sub set of the above annotation types.

The `msd` annotation for non-Swedish languages is based on different tag sets,
depending on which language is annotated and what annotation tool is being used.
The attribute contains information about the part of speech and in many cases
morphosyntactic information.
The `pos` annotation contains only part-of-speech information and uses the
[universal POS tag set](http://universaldependencies.org/u/pos/).
