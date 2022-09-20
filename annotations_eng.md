This page aims at giving an overview of the analyses available within the Sparv Pipeline and the Sparv plugins developed
by Språkbanken.

**annotations** are the names of the annotations as they are used in the corpus config file in the `export.annotations`
section (read more about this in the [Sparv user
manual](https://spraakbanken.gu.se/sparv/#/user-manual/corpus-configuration?id=corpus-configuration)). Please observe
that the annotations usually have shorter names in the corpus exports.

**annotators** are the names of the annotation functions (including their module names) which are used for procuding the
annotations. They can be run directly with the `sparv run-rule [annoterare]` command. Though in most cases this is not
necessary due to the fact that the annotation functions needed to produce all annotations listed in the corpus config
file are executed automatically when running `sparv run`.


# Analyses for contemporary Swedish
The following analyses are available in Sparv for contemporary Swedish. For various reasons not all of these are used by
us at Språkbanken for analysing the corpora in Korp.

- Sentence segmentation with PunktSentenceTokenizer
    - **description**: Texts are split into sentences.
    - **model**: [punkt-nltk-svenska.pickle](https://github.com/spraakbanken/sparv-models/blob/master/segment/punkt-nltk-svenska.pickle?raw=true)
    - **method**: The model is build with [NLTK's
      PunktTrainer](https://www.nltk.org/api/nltk.tokenize.html?highlight=punkttrainer#nltk.tokenize.punkt.PunktTrainer)
      and trained on [StorSUC](https://spraakbanken.gu.se/resurser/storsuc). The segmentation is done with NLTK's
      [PunktSentenceTokenizer](https://www.nltk.org/api/nltk.tokenize.html?highlight=punktsentencetokenizer#nltk.tokenize.punkt.PunktSentenceTokenizer).
    - **annotations**:
        - `segment.sentence`: sentence segments
    - **annotators**: `segment.sentence`

- Tokenization
    - **description**: Sentence segments are split into tokens.
    - **model**:
        - [configuration file bettertokenizer.sv](https://raw.githubusercontent.com/spraakbanken/sparv-models/master/segment/bettertokenizer.sv)
        - word list `bettertokenizer.sv.saldo-tokens` built upon [SALDOs
          morphology](https://spraakbanken.gu.se/resurser/saldo) (it is built automatically by Sparv)
    - **method**: Tokenizer using regular expressions and lists of words containing special characters and common
      abbreviations. Sparv's version is custom-made for Swedish but it is possible to configure it for other languages.
    - **annotations**:
        - `segment.token`: token segments
    - **annotators**: `segment.tokenize`

- POS-tagging with Stanza
    - **description**: Sentence segments are analysed to enrich tokens with part-of-speech tags and morphosyntactic
      information.
    - **tool**: [Stanza](https://stanfordnlp.github.io/stanza/)
    - **model**: https://spraakbanken.gu.se/resurser/stanzamorph
    - **tagset**:
        - [SUC MSD tags](https://spraakbanken.gu.se/korp/markup/msdtags.html)
        - [Universal features](https://universaldependencies.org/u/feat/index.html)
    - **annotations**:
        - `<token>:stanza.pos`: part-of-speech tag
        - `<token>:stanza.msd`: morphosyntactic tag
        - `<token>:stanza.ufeats`: universal features
    - **annotators**: `stanza.msdtag`

- Translation from SUC to UPOS
    - **description**: SUC POS tags are translated to UPOS. Not used by default because the translations are not very
      reliable.
    - **model**: Method has no model. A translation table is used.
    - **tagset**: [Universal POS tags](https://universaldependencies.org/u/pos/index.html)
    - **annotations**:
        - `<token>:misc.upos`: UPOS (universal POS tags)
    - **annotators**: `misc.upostag`

- POS-tagging with Hunpos
    - **description**: Sentence segments are analysed to enrich tokens varje token with part-of-speech tags and
      morphosyntactic information. No longer used by default because Stanza's POS-tagging yields better results.
    - **tool**: [Hunpos](http://code.google.com/p/hunpos/)
    - **model**: [suc3_suc-tags_default-setting_utf8.model](https://github.com/spraakbanken/sparv-models/blob/master/hunpos/suc3_suc-tags_default-setting_utf8.model?raw=true)
    - **method**: The model is trained on [SUC 3.0](https://spraakbanken.gu.se/resurser/suc3).
    - **tagset**: [SUC MSD tags](https://spraakbanken.gu.se/korp/markup/msdtags.html)
    - **annotations**:
        - `<token>:hunpos.msd`: morphosyntactic tag
        - `<token>:hunpos.pos`: part-of-speech tag
    - **annotators**:
        - `hunpos.msdtag`
        - `hunpos.postag`

- Dependency parsning with Stanza
    - **description**: Sentence segments are analysed to enrich tokens with dependency information.
    - **tool**: [Stanza](https://stanfordnlp.github.io/stanza/)
    - **model**: https://spraakbanken.gu.se/resurser/stanzasynt
    - **tagset**: [Mamba-Dep](https://svn.spraakdata.gu.se/sb-arkiv/pub/mamba.html)
    - **annotations**:
        - `<token>:stanza.ref`: the token position within the sentence
        - `<token>:stanza.dephead_ref`: dependency head, the ref of the word which the current word modifies or is dependent of
        - `<token>:stanza.deprel`: dependency relation, the relation of the current word to its dependency head
    - **annotators**:
        - `stanza.dep_parse`
        - `stanza.make_ref`

- Dependency parsning with MaltParser
    - **description**: Sentence segments are analysed to enrich tokens with dependency information.
      No longer used by default because Stanza's dependency parsning yields better results.
    - **tool**: [MaltParser](http://www.maltparser.org/download.html)
    - **model**: [swemalt](http://www.maltparser.org/mco/swedish_parser/swemalt.html)
    - **method**: The model is trained on [Svensk trädbank](https://spraakbanken.gu.se/resurser/sv-treebank).
    - **tagset**: [Mamba-Dep](https://svn.spraakdata.gu.se/sb-arkiv/pub/mamba.html)
    - **annotations**:
        - `<token>:malt.ref`: the token position within the sentence
        - `<token>:malt.dephead_ref`: dependency head, the ref of the word which the current word modifies or is dependent of
        - `<token>:malt.deprel`: dependency relation, the relation of the current word to its dependency head
    - **annotators**:
        - `malt.annotate`
        - `malt.make_ref`

- Phrase structure parsing
    - **description**: Mamba-Dep dependencies produced by the dependency analysis are converted to phrase structures.
      Not used in Korp due to incompatibility with Corpus Workbench.
    - **model**: Method has no model.
    - **annotations**:
        - `phrase_structure.phrase`: phrase segments
        - `phrase_structure.phrase:phrase_structure.name`: name of the phrase segment
        - `phrase_structure.phrase:phrase_structure.func`: function of the phrase segment
    - **annotators**: `phrase_structure.annotate`

- SALDO-based analyses
    - **description**: Tokens and their POS tags are looked up in the SALDO lexicon in order to enrich them with more
      information.
    - **model**: [SALDO morphology](https://spraakbanken.gu.se/resurser/saldo)
    - **tagset**: [SALDO tags](https://spraakbanken.gu.se/resurser/saldo/taggmangd) for lemgrams
    - **annotations**:
        - `<token>:saldo.baseform`: citation forms
        - `<token>:saldo.lemgram`: lemgrams, identifying the inflectional table
        - `<token>:saldo.sense`: identify senses in SALDO
    - **annotators**: `saldo.annotate`

- Citation form analysis with Stanza
    - **description**: Sentence segments are analysed to enrich tokens with citation forms.
      Not used in Korp. Citations forms are produced by SALDO instead.
    - **tool**: [Stanza](https://stanfordnlp.github.io/stanza/)
    - **model**: https://spraakbanken.gu.se/resurser/stanzasynt
    - **annotations**:
        - `<token>:stanza.baseform`: citation form
    - **annotators**: `stanza.annotate_swe`

- Sense disambiguation
    - **description**: SALDO IDs from the `<token>:saldo.sense`-attributet are enriched with likelihoods.
    - **tool**: [Sparv wsd](https://github.com/spraakbanken/sparv-wsd)
    - **dokumentation**: [Running the Koala word sense disambiguators](https://github.com/spraakbanken/sparv-wsd/blob/master/README.pdf)
    - **model**:
        - [ALL_512_128_w10_A2_140403_ctx1.bin](https://github.com/spraakbanken/sparv-wsd/blob/master/models/scouse/ALL_512_128_w10_A2_140403_ctx1.bin)
        - [lem_cbow0_s512_w10_NEW2_ctx.bin](https://github.com/spraakbanken/sparv-wsd/blob/master/models/scouse/lem_cbow0_s512_w10_NEW2_ctx.bin)
    - **annotations**:
        - `<token>:wsd.sense`: identifies senses in SALDO along with their likelihoods
    - **annotators**: `wsd.annotate`

- Compound analysis with SALDO
    - **description**: Tokens and their POS tags are looked up in the SALDO lexicon in order to enrich them with
      compound information. More information (in Swedish) is found in the [FAQ](https://spraakbanken.gu.se/faq#q24).
      Citation forms are enriched in this analysis.
    - **model**:
        - [SALDO morphology](https://spraakbanken.gu.se/resurser/saldo)
        - [NST pronunciation lexicon for Swedish](https://www.nb.no/sprakbanken/en/resource-catalogue/oai-nb-no-sbr-22/)
        - [word frequency statistics from Korp](https://svn.spraakdata.gu.se/sb-arkiv/pub/frekvens/stats_all.txt)
    - **annotations**:
        - `<token>:saldo.complemgram`: compound lemgrams including a comparison score 
        - `<token>:saldo.compwf`: compound word forms
        - `<token>:saldo.baseform2`: citation form
    - **annotators**: `saldo.compound`

- Sentiment analysis with SenSALDO
    - **description**: Tokens and their SALDO IDs are looked up in SenSALDO in order to enrich them with sentiments. 
    - **model**: [SenSALDO](https://spraakbanken.gu.se/resurser/sensaldo)
    - **annotations**:
        - `<token>:sensaldo.sentiment_label`: sentiment
        - `<token>:sensaldo.sentiment_score`: sentiment value
    - **annotators**: `sensaldo.annotate`

- Named entity recognition with HFST-SweNER
    - **description**: Sentence segments are analysed and enriched with named entities.
    - **tool**: [hfst-SweNER](http://urn.fi/urn%3Anbn%3Afi%3Alb-2021101202)
    - **model**: included in the tool
    - **referenser**:
        - [HFST-SweNER – A New NER Resource for Swedish](http://www.lrec-conf.org/proceedings/lrec2014/pdf/391_Paper.pdf)
        - [Reducing the effect of name explosion](http://demo.spraakdata.gu.se/svedk/pbl/kokkinakisBNER.pdf)
    - **tagset**: [HFST-SweNER tags](https://svn.spraakdata.gu.se/sb-arkiv/pub/swener-tags.html)
    - **annotations**:
        - `swener.ne`: named entity segment
        - `swener.ne:swener.name`: text in the entire named entity segment
        - `swener.ne:swener.ex`: named entity (name expression, numerical expression or time expression)
        - `swener.ne:swener.type`: named entity type
        - `swener.ne:swener.subtype`: named entity subtype
    - **annotators**: `swener.annotate`

- Readability metrics
    - **description**: Documents are analysed in order to enrich them with readability metrics.
    - **model**: Method has no model.
    - **annotations**:
        - `<text>:readability.lix`: the Swedish readability metric LIX, läsbarhetsindex
        - `<text>:readability.ovix`: the Swedish readability metric OVIX, ordvariationsindex
        - `<text>:readability.nk`: the Swedish readability metric nominalkvot (noun ratio)
    - **annotators**:
        - `readability.lix`
        - `readability.ovix`
        - `readability.nominal_ratio`

- Lexical classes
    - **description**: Tokens are looked up in Blingbring and SweFN in order to enrich them with information about their
      lexical classes. Documents are then enriched with information about lexical classes based on which classes are
      common for the tokens within them.
    - **model**:
        - [Blingbring](https://spraakbanken.gu.se/resurser/blingbring)
        - [Swedish FrameNet (SweFN)](https://spraakbanken.gu.se/resurser/swefn)
    - **annotations**:
        - `<token>:lexical_classes.blingbring`: lexical class from the Blingbring resource per token
        - `<token>:lexical_classes.swefn`: frames from swedish FrameNet (SweFN) per token
        - `<text>:lexical_classes.blingbring`: lexical class from the Blingbring resource per dokument
        - `<text>:lexical_classes.swefn`: frames from swedish FrameNet (SweFN) per dokument
    - **annotators**:
        `lexical_classes.blingbring_words`
        `lexical_classes.swefn_words`
        `lexical_classes.blingbring_text`
        `lexical_classes.swefn_text`

- Geotagging
    - **description**: Sentences (and paragraphs if existing) are enriched with place names (and their geographic
      coordinates) occurring within them. This is based on the place names found by the named entity tagger.
      Geographical coordinates are looked up in the GeoNames database.
    - **model**: [GeoNames](https://www.geonames.org/)
    - **annotations**:
        - `<sentence>:geo.geo_context`: places and their coordinates occurring within the sentence
        - `<paragraph>:geo.geo_context`: places and their coordinates occurring within the paragraph
    - **annotators**: `geo.contextual`


# Analyses for Swedish from the 1800's
All analyses for contemporary Swedish are also available for this variety. Beyond that some analyses have been adapted
for Swedish from the 1800's:

- POS-tagging with Hunpos (adapted for 1800-talssvenska)
    - **description**: Sentence segments are analysed to enrich tokens with part-of-speech tags and morphosyntactic
      information.
    - **tool**: [Hunpos](http://code.google.com/p/hunpos/)
    - **model**:
        - [suc3_suc-tags_default-setting_utf8.model](https://github.com/spraakbanken/sparv-models/blob/master/hunpos/suc3_suc-tags_default-setting_utf8.model?raw=true)
        - a word list along with the words' morphosyntactig information generated from the [Dalin
          morphology](https://spraakbanken.gu.se/resurser/dalinm) and the [Swedberg
          morphology](https://spraakbanken.gu.se/resurser/swedbergm)
    - **method**: The model is trained on [SUC 3.0](https://spraakbanken.gu.se/resurser/suc3).
    - **tagset**: [SUC MSD tags](https://spraakbanken.gu.se/korp/markup/msdtags.html)
    - **annotations**:
        - `<token>:hunpos.msd`: morphosyntactic tag
        - `<token>:hunpos.pos`: part-of-speech tag
    - **annotators**:
        - `hunpos.msdtag_hist`
        - `hunpos.postag`

- Lexicon-based analyses
    - **description**: Tokens and their POS tags are looked up in different lexicons in order to enrich them with more
      information.
    - **model**:
        - [SALDO morphology](https://spraakbanken.gu.se/resurser/saldo)
        - [Dalin morphology](https://spraakbanken.gu.se/resurser/dalinm)
        - [Swedberg morphology](https://spraakbanken.gu.se/resurser/swedbergm)
        - [Diachronic pivot](https://spraakbanken.gu.se/resurser/diapivot)
    - **tagset**: [SALDO tags](https://spraakbanken.gu.se/resurser/saldo/taggmangd) (for lemgrams)
    - **annotations**:
        - `<token>:hist.baseform`: citation forms
        - `<token>:hist.sense`: identifies senses in SALDO
        - `<token>:hist.lemgram`: lemgrams, identifying the inflectional table
        - `<token>:hist.diapivot`: SALDO lemgrams from the diapivot model 
        - `<token>:hist.combined_lemgrams`: SALDO lemgram, combined from SALDO, Dalin, Swedberg and the diapivot model
    - **annotators**:
        - `hist.annotate_saldo`
        - `hist.diapivot_annotate`
        - `hist.combine_lemgrams`

# Analyses for Old Swedish
All analyses for contemporary Swedish are available for this language variety, however, we do not recommend to use these
due to the fact that the spelling often differs too much to give satisfying results. At Språkbanken we use the following analyses for texts written in Old Swedish:

- Sentence segmentation and tokenization (same analyses as for contemporary Swedish)

- Spelling variations
    - **description**: Tokens are looked up in a model to get common spelling variations.
    - **model**: [model for Old Swedish spelling
      variations](https://media.githubusercontent.com/media/spraakbanken/sparv-models/master/hist/fsv-spelling-variants.txt)
    - **annotations**:
        - `<token>:hist.spelling_variants`: possible spelling variations for the token
    - **annotators**: `hist.spelling_variants`

- Lexicon-based analyses
    - **description**: Tokens and their POS tags are looked up in different lexicons in order to enrich them with more
      information.
    - **model**:
        - [Fornsvensk morphology from Söderwall and Schlyter](https://spraakbanken.gu.se/resurser/fsvm)
        - [SALDO morphology](https://spraakbanken.gu.se/resurser/saldo)
        - [Diachronic pivot](https://spraakbanken.gu.se/resurser/diapivot)
    - **tagset**: [SALDO tags](https://spraakbanken.gu.se/resurser/saldo/taggmangd) for lemgrams
    - **annotations**:
        - `<token>:hist.baseform`: citation forms
        - `<token>:hist.lemgram`: lemgrams, identifying the inflectional table
        - `<token>:hist.diapivot`: SALDO lemgrams from the diapivot model
        - `<token>:hist.combined_lemgrams`: SALDO lemgram, combined from SALDO, Dalin, Swedberg and the diapivot model
    - **annotators**:
        - `hist.annotate_saldo_fsv`
        - `hist.diapivot_annotate`
        - `hist.combine_lemgrams`

- Homograph sets
    - **description**: A set of possible POS tags is extracted from the lemgram annotation.
    - **model**: Method has no model.
    - **tagset**: [POS tags from the SUC MSD tag set](https://spraakbanken.gu.se/korp/markup/msdtags.html)
    - **annotations**:
        - `<token>:hist.homograph_set`: possible part-of-speech tags for the token
    - **annotators**: `hist.extract_pos`


# Analyses for other languages than Swedish
Sparv supports analyses for a number of different languages. A list of which languages are supported and what analysis
tools are available can be found
[here](https://spraakbanken.gu.se/sparv/#/user-manual/installation-and-setup?id=software-for-analysing-other-languages-than-swedish).

- Analyses from TreeTagger
    - **description**: Tokenised sentence segments are analysed to enrich tokens with more information.
    - **tool**: [TreeTagger](https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/)
    - **model**: Different language-dependent parameter files are used. Please check the [TreeTagger
          web site](https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/) for more information.
    - **tagset**:
        - Different language-dependent POS tag sets are used. Please check the [TreeTagger
          web page](https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/) for more information.
        - [Universal POS tags](https://universaldependencies.org/u/pos/index.html)
    - **annotations**:
        - `<token>:treetagger.baseform`: citation form
        - `<token>:treetagger.pos`: part-of-speech tag, may include morphosyntactic information
        - `<token>:treetagger.upos`: universal part-of-speech tags, translated from `<token>:treetagger.pos`
    - **annotators**: `treetagger.annotate`

- Analyses from FreeLing
    - **description**: Entire documents are analysed with FreeLing for sentence segmentation, tokenization and
      enrichment with other information. FreeLing does not use the same permissive licence as Sparv. Installation of the
      [Sparv FreeLing plugin](https://github.com/spraakbanken/sparv-freeling) is necessary.
    - **tool**: [FreeLing](https://github.com/TALP-UPC/FreeLing)
    - **model**: Models for different languages are included in the tool.
    - **tagset**:
        - Different language-dependent POS tagsets (often
          [EAGLES](http://www.ilc.cnr.it/EAGLES96/annotate/node9.html)). Please check the [FreeLing
          documentation](https://freeling-user-manual.readthedocs.io/en/v4.2/tagsets/) for more information.
        - [Universal POS tags](https://universaldependencies.org/u/pos/index.html)
    - **annotations**:
        - `freeling.sentence`: sentence segments from FreeLing
        - `freeling.token`: token segments from FreeLing
        - `freeling.token:freeling.baseform`: citation form
        - `freeling.token:freeling.pos`: part-of-speech tag, often including some morphosyntactic information
        - `freeling.token:freeling.upos`: universal part-of-speech tags
        - `freeling.token:freeling.ne_type`: named entity type (only available for some languages)
    - **annotators**: `freeling.annotate` or `freeling.annotate_full` (depending on the language)

- Analyses from Stanford Parser (for English)
    - **description**: Entire documents are analysed with Stanford Parser for sentence segmentation, tokenization and
      enrichment with other information.
    - **tool**: [Stanford Parser](https://nlp.stanford.edu/software/lex-parser.shtml)
    - **model**: included in the tool
    - **tagset**:
        - [Penn Treebank tagset](https://www.sketchengine.eu/penn-treebank-tagset/)
        - [Universal POS tags](https://universaldependencies.org/u/pos/index.html)
    - **annotations**:
        - `stanford.sentence`: sentence segments from Stanford Parser
        - `stanford.token`: token segments from Stanford Parser
        - `stanford.token:stanford.baseform`: citation form
        - `stanford.token:stanford.pos`: part-of-speech tag
        - `stanford.token:stanford.upos`: universal part-of-speech tags
        - `stanford.token:stanford.ne_type`: named entity type
        - `stanford.token:stanford.ref`: the token position within the sentence
        - `stanford.token:stanford.dephead_ref`: dependency head, the ref of the word which the current word modifies or
          is dependent of
        - `stanford.token:stanford.deprel`: dependency relation, the relation of the current word to its dependency head
    - **annotators**:
        - `stanford.annotate`
        - `stanford.make_ref`

<!-- - Analyses from Stanza (for English)
    - **description**: Entire documents are analysed with Stanza for sentence segmentation, tokenization and
      enrichment with other information.
    - **tool**: [Stanza](https://stanfordnlp.github.io/stanza/)
    - **model**: included in the tool
    - **tagset**:
        - [Universal POS tags](https://universaldependencies.org/u/pos/index.html)
        - [Universal features](https://universaldependencies.org/u/feat/index.html)
    - **annotations**:
        - `stanza.sentence`: sentece segments from Stanza
        - `stanza.ne`: named entity segments from Stanza
        - `stanza.ne:stanza.ne_type`: named entity type
        - `stanza.token`: token segments from Stanza
        - `<token>:stanza.baseform`: citation form
        - `<token>:stanza.pos`: part-of-speech tag
        - `<token>:stanza.upos`: universal part-of-speech tags
        - `<token>:stanza.ufeats`: universal features
        - `<token>:stanza.ref`: the token position within the sentence
        - `<token>:stanza.dephead_ref`: dependency head, the ref of the word which the current word modifies or is
          dependent of
        - `<token>:stanza.deprel`: dependency relation, the relation of the current word to its dependency head
    - **annotators**:
        - `stanza.annotate`
        - `stanza.make_ref` -->
