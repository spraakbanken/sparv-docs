
## Developing the Sparv Pipeline

This section describes the internal structure of the Sparv pipeline
and its usage and can be used as a developer's guide.

### Downloading and installing the Sparv pipeline

The latest distribution of the pipeline can be downloaded from the [distribution page](https://spraakbanken.gu.se/eng/research/infrastructure/sparv/distribution/pipeline).

Annotating corpora with the Sparv pipeline can be done in the same manner as on
Språkbanken's own servers which is described
[here](https://spraakbanken.gu.se/swe/forskning/infrastruktur/korp/korpusimport) (in Swedish only).

The import format is described [here](https://spraakbanken.gu.se/eng/research/infrastructure/sparv/importformat).

### The pipeline's folder structure

        annotate/
            bin/       binary files
            makefiles/ Makefiles
            models/    linguistic models
            python/    Python modules
            tests/     tests

### The pipeline structure

The Sparv corpus pipeline consists of Python modules which are located in the `python` directory.
Most of the modules contain code to solve a single task, e.g. part-of-speech tagging, tokenisation etc.
Some of the modules call external tools, e.g. Hunpos or the MaltParser.

The following is a short summary of most of the existing modules and their basic functionalities.
More information on every script can be found in the doc strings of the functions.

Module                    | Description
--------------------------|-----------------------------------------------------------------------
*annotate.py*             |Different types of small annotations.
*compound.py*             |Compound analysis using SALDO.
*crf.py*                  |Sentence segmentation with Conditional Random Fields.
*cwb.py*                  |Creates the different output formats (VRT, XML, Corpus Workbench files).
*dateformat.py*           |Date formatting.
*diapivot.py*             |Creates the diachronic pivot, linking older Swedish texts to SALDO.
*fileid.py*               |Creates IDs for every file in the corpus.
*freeling.py*             |For annotation of other languages. Calls the Freeling software and processes its output. (Only available in the AGPL-version of Sparv)
*geo.py*                  |Annotates geographical features.
*hist.py*                 |Different functions used for annotation historical Swedish texts.
*hunpos_morphtable.py*    |Creates a morphtable file for Hunpos, based on SALDO.
*hunpos.py*               |Part-of-speech tagging with Hunpos.
*info.py*                 |Creates an info file which is used by CWB.
*install.py*              |Installs corpora on other machines.
*lemgram_index.py*        |Creates a lemgramindex which is used by Korp.
*lexical_classes.py*      |Creates annotations for lexical classes with different resources (Blingbring, SweFN).
*lmflexicon.py*           |Parses LMF lexicons.
*malt.py*                 |Syntactic parsing with the MaltParser.
*number.py*               |Different types of numbering used e.g. in structural attributes.
*parent.py*               |Adds annotations for parent links and/or children links (needed for pipeline internal purposes).
*readability.py*          |Creates annotations for readability measures.
*relations.py*            |Creates data used by the word picture.
*saldo.py*                |Different types of SALDO-annotations.
*segment.py*              |All kinds of segmentation/tokenisation (paragraph, sentence, word).
*sent_align.py*           |Sentence linking of parallel corpora.
*sentiment.py*            |Creates sentiment annotations.
*suc2hunpos.py*           |Creates a test material based on SUC3 for Hunpos.
*swener.py*               |Creates named-entity annotations with hfst-SweNER.
*timespan.py*             |Handles time spans.
*train_nst_comp_model.py* |Trains a compound part-of-speech model used by the compound analysis.
*train_stats_model.py*    |Trains a statistical model used by the compound analysis.
*treetagger.py*           |For annotation of other languages. Calls the TreeTagger software and processes its output.
*vw.py*                   |Topic modelling with vowpal wabbit.
*word_align.py*           |Word linking of parallel corpora with fast_align and cdec.
*wsd.py*                  |Crates annotations for word sense disambiguation.
*xmlanalyser.py*          |An analyzer for pseudo-XML documents.
*xmlparser.py*            |Parses XML and generates files in the pipeline's working format.

The first thing that happens when annotating a corpus with the Sparv pipeline is that the
XML input data is parsed by the module xmlparser.py. This module generates the following
files for every input file (usually in the `annotations` directory):

* a `.@TEXT` file containing the source text with anchors
* one file for each structural attribute captured, where each line consists of a reference to
  two anchors indicating the span of the attribute, and the value of the attribute

The output of most modules are files in the above described format, with references to anchors
and data for the indicated span. The part-of-speech tagger module for instance creates a file
containing an anchor span per word and the part-of-speech as value.

### Annotations

Below is a list with some of the most common annotations and which module they are built with:

* *word*  
  The string containing a token (word or punctuation). This annotation is created by *xmlparser.py*.
* *msd*  
  A morphosyntactic descriptor. Created by *hunpos.py* with *word* as input data.
* *pos*  
  A simplified MSD, preserving only its initial part. Created by *annotate.py* with *msd* as input data.
* *baseform*, *lemgram*, *sense*  
  Citation form, lemgram, and SALDO-ID. Created by *saldo.py*, with *word*, *msd* and *ref* as input files. Uses a SALDO model which is created with *saldo.py*.
* *ref*  
  En numrering av varje token inom varje mening. Skapas av *annotate.py*.
* *dephead*, *deprel*  
  Dependency head and dependency relation. Created by *malt.py*, with *word*, *msd* and *pos* as input data. Uses the MALT parser with a model for Swedish.


### Developing a new module

This part describes how to create a new Python module within the Sparv pipeline.

Usually one does not have to define the format for the input and output data since
there are methods defined for reading and writing these.

Below is a minimal example script which could be integrated in the Sparv pipeline:

        # -*- coding: utf-8 -*-
        import sb.util as util

        def changecase(word, out, case):
            # Read the annotation "word"
            words = util.read_annotation(word)

            # Transform every word to upper or lower case
            for w in words:
                if case == "upper":
                    words[w] = words[w].upper()
                elif case == "lower":
                    words[w] = words[w].lower()

            # Write the result (out) to the indicated annotation (words)
            util.write_annotation(out, words)

        if __name__ == '__main__':
            util.run.main(changecase=changecase)

Most modules start with importing `util` which contains functions for reading
and writing annotations in the data format used within the pipeline.

Then you can define functions that may be used by Sparv. These functions
usually take paths to existing annotation files as arguments as well as
a path to the annotation file that should be created by the function.

The function `util.read_annotation()` is used to read existing annotations.
It returns a dictionary object with anchors as keys and annotation values as values.

A module function can be concluded with calling `util.write_annotation()` which
takes a path to an annotation file and a dictionary as arguments and saves the
dictionary contents to the specified file path.

A module should also contain some code that makes its functions available from the command line.
This is what the last two lines in the above example are there for. As arguments to the function
`util.run.main` you can list all the names of the functions you want to be able to use from the
command line in the following format: `alias=name_of_function`. The chosen alias can then
be specified as a flag in the command line. The first function may be set as default by
omitting the alias.


### Makefile

When running the Sparv pipeline its different modules are coordinated with makefiles. There are two global
makefiles containing configurations and rules for the creation of annotations (`Makefile.config`, `Makefile.rules`).
Furthermore, each corpus has its own makefile (`Makefile`) that contains information about the data
format and about which annotations should be used. The two global makefiles are imported by the corpus specific
makefile.

Documentation for the different corpus specific makefiles can be found in `Makefile.template`. This file
is distributed together with the other makefiles in the Sparv pipeline.

`Makefile.rules` is the file containing all rules that create annotations. `Makefile.config` contains
variables that can be configured.

A rule in Makefile.rules can for example look like this:

        %.token.uppercase: %.token.word
            $(python) -m sb.case --changecase --out $@ --word $(1) --case upper

The above rule creates the annotation *uppercase* from the Python example above. It takes the annotation *word*
as input and calls the function *uppercase* in the script *case.py* with *out*, *word* and *case* as arguments.

Adding a new annotation can in most cases be done by adding a rule like in the above example to `Makefile.rules`.
The name of the annotation must also be added to the list of annotations i the corpus specific makefile.
