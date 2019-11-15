
## Annotating parallel corpora

A parallel corpus is a corpus that contains a collection of original texts and
their translations into other languages. A parallel corpus can be bilingual or
multilingual. In Sparv each text collection of one language is treated as a
separate corpus which needs to be annotated separately but may be linked to one
or more corpora in other languages. The following example demonstrates how to
annotate a bilingual (English-Swedish) parallel corpus with automatic
sentence-linking and word-linking.

You can download an example mini corpus including a working Makefile [here](https://github.com/spraakbanken/sparv-docs/raw/master/examples/parallel_corpus_example.zip).

### Folder structure
Each corpus has its own root directory. The names of the root directories (
`mycorpus-en` and `mycorpus-sv`) need to be identical apart from the language ID
suffix. If the language in question should be annotated with Sparv its language ID
suffix should be a two-letter ISO code (check [this table](https://spraakbanken.gu.se/eng/research/infrastructure/sparv/distribution/pipeline#language_table) for reference). Files that are linked to each other must
have the same name (in this example: `sparv-intro.xml`).

```
my_parallel_corpus/
    mycorpus-en/
        original/
            xml/
                sparv-intro.xml
    mycorpus-sv/
        original/
            xml/
                sparv-intro.xml
    Makefile
```

### Linking corpora
Sparv includes tools for automatic sentence-linking and word-linking.
Sentence-linking is a prerequisite for word-linking, and sentence-linking requires
pre-aligned text chunks (e.g. paragraphs or similar). In the example corpus the
pre-aligned chunks are called "link". Each link has an ID (attribute `n`) which
corresponds to the link-element with the same ID its linked translation.

If you are using automatic sentence-linking you need to set the variable
`align_sentences` to `true` and you must specify `sent_align_chunk` to the element
that has been pre-aligned.

If your text is already linked on sentence level you need to have `sentlink` elements
sourrounding the sentences, in order to get automatic word-linking. They should have
IDs indicating which sentences belong together (e.g. `<sentlink n="0001">`). The IDs
should be unique for each indata file. Don't forget to set the variable `align_sentences = false` in your makefile.

If you would like to use automatic word-linking you need to add the attribute
`wordlink-$(other_lang)` to the variables `vrt_columns` and
`vrt_columns_annotations` in your Makefile. `$(other_lang)` is the variable for
the language ID suffix of the linked language.

### The Makefile
For parallel corpora the following variables must be set in addition to the
standard variables:

* `parallel_base`: the root directory name without language ID suffix (`mycorpus`)
* `root`: the root directory with language ID suffix (`mycorpus-$(lang)`)

For automatic word-linking:

* `align_sentences`: `true` if sentences should be linked, else `false` (In this
    case the sentences must be pre-aligned. Word-linking will not work without
    sentence-alignment.)
* `sent_align_chunk`: the pre-aligned chunk which is parent to sentence

You need to include `Makefile.langs` in your Makefile (after including
`Makefile.config`). By doing this Sparv will know which analysis tool
(TreeTagger or FreeLing) to use for which language.

If the languages you are annotating make use of different analysis modes (e.g.
FreeLing, TreeTagger or the standard Swedish mode) you need to define
language-specific if-clauses in your Makefile in order for the variables to be
set to the correct values. Check the example Makefile for more details.

If you have certain attributes that are not used in all the languages in your
parallel corpus you need to list these attributes in the `null_annotations`
variable. In that case you also need to set `skip_cwb_compression` and  
`skip_cwb_validation` to `true`, otherwise you will not be able to create the
Corpus Workbench binaries.

### Annotating
Run each corpus separately and define which language should be annotated (`lang`)
and which language the corpus should be linked to (`other_lang`; Note: this parameter is set automatically in the example corpus!):
```
make vrt lang=en other_lang=sv
make vrt lang=sv other_lang=en
```

When creating the corpus Workbench binaries you also need to run `make align` for
both languages (after creating the vrt-files), e.g.:
```
make align lang=en other_lang=sv
make align lang=sv other_lang=en
```

### Annotation result

This is what the vrt result could look like for a Swedish-English parallel corpus (taken from the example corpus which can be downloaded above):

```
<text>
<link n="1">
<sentlink n="sparv-intro.01">
<sentence id="sv0248-sv02a2">
Sparv	NN	NN.UTR.SIN.IND.NOM	|sparv|	|sparv..nn.1|	01	|01|
är	VB	VB.PRS.AKT	|vara|	|vara..vb.1|	02	|02|
Språkbankens	NN	NN.UTR.SIN.DEF.GEN	|språkbank|	|språkbank..nn.1|	03	|03|04|
annoteringsverktyg	NN	NN.NEU.PLU.IND.NOM	|	|	04	|05|06|
...
</sentence>
</sentlink>
</link>
</text>
```

```
<text>
<link n="1">
<sentlink n="sparv-intro.01">
<sentence id="en038c2-en0affc">
Sparv	PROPN	NP	sparv	__UNDEF__	01	|01|
is	VERB	VBZ	be	__UNDEF__	02	|02|
an	DET	DT	a	__UNDEF__	03	|03|
annotation	NOUN	NN	annotation	__UNDEF__	04	|03|
tool	NOUN	NN	tool	__UNDEF__	05	|04|
developed	VERB	VBN	develop	__UNDEF__	06	|04|
...
</sentence>
</sentlink>
</link>
</text>
```

The tab-separated columns in the vrt output contain the following information:

`word pos msd baseform lemgram linkref wordlink`

In this example the texts were manually linked by the `<link>` elements. The
`sentlink` element was added automatically by the sentence linking module. If the
`link` element contains multiple sentences the `sentlink` attribute will break down
the linked elements into smaller units. The ID in the `link` and `sentlink` elements
(e.g. `n="1"`, `n="sparv-intro.01"`) indicates which elements belong together across
linked texts in different languages. By default the `sentlink`-ID is prefixed with
the name of the indata file (in this case "sparv-intro"). Note that the prefix is
not required for automatic word-linking, so if you use manual sentences-linking you
will not need to set a prefix. 

The last column (`wordlink`) contains a set of link reference numbers (`linkref`)
referring to tokens from the linked text within the same `<link>` element. Note that
this set may be empty in some cases, meaning that the token was not linked to any
token in the other language.

The column `lemgram` contains only `__UNDEF__` values for the English text because
`lemgram` was listed in the `null_annotations` since this annotation is only
available for Swedish. Columns containing only `__UNDEF__` values are not present in
the XML export.
