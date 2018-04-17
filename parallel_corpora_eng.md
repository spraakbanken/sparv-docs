
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

You need to include `Makefile.langs` (after including `Makefile.config`). By doing
this Sparv will know which analysis tool (TreeTagger or FreeLing) to use for which
language.

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
**Work in Progress!** Describe result (vrt, word-linking...)
