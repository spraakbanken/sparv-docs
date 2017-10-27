
For texts written in contemporary Swedish Sparv can generate the following types of annotations:

* Part of speech tagging:
  * pos: part of speech, see http://spraakbanken.gu.se/korp/markup/msdtags.html
  * msd: morphosyntactic tag, see http://spraakbanken.gu.se/korp/markup/msdtags.html

* SALDO-based analysis:
  * lemma: citation form
  * lex: lemgram, identifies the inflectional table
  * sense: identifies a sense in SALDO and its probability
  * (saldo: identifies a sense in SALDO - *will be removed soon*)
  * sentiment: sentiment score

* Compound analysis (also based on SALDO):
  * complemgram: compound lemgram
  * compwf: compound word form
  * (prefix: initial part of a compound - *will be removed soon*)
  * (suffix: final part of a compound - *will be removed soon*)

* Dependency analysis:
  * ref: the position of the word in the sentence
  * dephead: dependency head, the ref of the word which the current word modifies or is dependent of
  * deprel: dependency relation, the relation of the current word to its dependency head, see http://stp.ling.uu.se/~nivre/swedish_treebank/dep.html

* Named entity recognition:
  * ne.ex: named entity (name expression, numerical expression or time expression)
  * ne.type: named entity type
  * ne.subtype: named entity sub type

* Readability metrics:
  * text.lix: the Swedish readability metric LIX, läsbarhetsindex
  * text.ovix: the Swedish readability metric OVIX, ordvariationsindex
  * text.nk: the Swedish readability metric nominalkvot

* Lexical classes:
  * blingbring: lexical class from the Blingbring resource (on word level)
  * swefn: frames from swedish FrameNet (on word level)
  * text.blingbring: lexical class from the Blingbring resource (on document level)
  * text.swefn: frames from swedish FrameNet (on document level)


Older Swedish texts or texts written in other languages can often be annotated
with a sub set of the above annotation types.
