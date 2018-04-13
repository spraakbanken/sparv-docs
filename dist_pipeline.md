
## Setting up the Sparv Pipeline

This section describes how to get the Sparv corpus pipeline up and running on your
own machine. Begin by downloading the latest version of the corpus pipeline
[here](https://spraakbanken.gu.se/pub/sparv.dist/sparv_pipeline/?C=M;O=D).

Note that the source code is made available in two different versions:

* under the [MIT license](https://opensource.org/licenses/MIT) without usage of FreeLing
* under the [AGPL license](http://www.gnu.org/licenses/agpl.html) including calls to FreeLing

### Requirements

To use the corpus pipeline you need the following:

* A Unix-like environment (e.g. Linux, OS X)
* [Python 3.4](http://python.org/) or newer
* GNU Make
* [Hunpos](http://code.google.com/p/hunpos/), with its path included in your `PATH` environment variable
* Java

Optional:

* [Corpus Workbench](http://cwb.sourceforge.net/beta.php) (CWB) 3.2 or newer (if you are going to use the Korp backend for searching in your corpora)
* [hfst-SweNER](http://www.ling.helsinki.fi/users/janiemi/finclarin/ner/hfst-swener-0.9.3.tgz) (if you want to use named entity recognition; experimental feature)
* [freeling](http://devel.cpl.upc.edu/freeling) 4.0 (if you want to annotate corpora in Catalan, English, French, Galician, German, Italian, Norwegian, Portuguese, Russian, Slovenian or Spanish)
* [TreeTagger](http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/) (if you want to annotate corpora in Bulgarian, Dutch, Estonian, Finnish, Latin, Polish, Romanian or Slovak)
* [fast_align](https://github.com/clab/fast_align) (if you want to run word-linking on parallel corpora)

### Installing the required software

The following information assumes that you are running Ubuntu, but will most likely work for any Linux-based OS.

#### Python virtual environment

Set up a Python virtual environment as a subdirectory to the `annotate` directory:

    python3 -m venv venv

Activate the virtual environment and install the required Python packages:

    source venv/bin/activate
    pip install -r requirements.txt

You can then deactivate the virtual environment:

    deactivate

#### Hunpos

Hunpos can be downloaded from [here](http://code.google.com/p/hunpos/). Installation is done by unpacking and
then adding the path of the executables to your `PATH` environmental variable.
If you are running a 64-bit OS, you might also have to install 32-bit compatibility libraries if Hunpos won't run:

    sudo apt install ia32-libs

On Arch Linux, activate the `multilib` repository and install `lib32-gcc-libs`.

If that doesn't work, you might have to compile Hunpos from its source code.

#### hfst-SweNER (optional)

The current version of hfst-SweNER expects to be run in a Python 2 environment
while the Sparv pipeline is written in Python 3. If you want to use hfst-SweNER's
named entity recognition from within Sparv you need to make sure that your `python`
command in your environment refers to Python 2. Alternatively, before installing
hfst-SweNER, you can make sure that it will be run with the correct version of Python by
replacing `python` with `python2` in all the Python scripts in the `hfst-swener-0.9.3/scripts`
directory. The first line in every script will then look like this:

    #! /usr/bin/env python2

#### TreeTagger and Freeling (optional)

TreeTagger and Freeling is used for POS-tagging and lemmatization of other languages than Swedish.
Please install the software according to the instructions on the respective website or in the provided
read-me file. If you are using TreeTagger, please copy the `tree-tagger` binary file into the `bin/treetagger`
directory belonging to the pipeline. The TreeTagger models (parameter files) need to be downloaded separately
and saved in the `models/treetagger` directory. The parameter files need to be re-named to a two-letter
language code followed by the file ending `.par`, e.g. the Dutch parameter file is called `nl.par`.

The Freeling model files (configuration files) must be copied from the Freeling source code
(the directory `data/config`) into the `models/freeling` directory of the pipeline.
The configuration files need to be re-named to a two-letter language code followed
by the file ending `.cfg`, e.g. the English parameter file is called `en.cfg`.

The following is a list over the languages currently supported by the corpus pipeline,
their language codes and which tool Sparv uses to analyze them:

Language      Code    Tool
----------    -----   ------------
Bulgarian     bg      TreeTagger
Catalan       ca      Freeling
Dutch         nl      TreeTagger
English       en      Freeling
Estonian      et      TreeTagger
Finnish       fi      TreeTagger
French        fr      Freeling
Galician      gl      Freeling
German        de      Freeling
Italian       it      Freeling
Latin         la      TreeTagger
Norwegian     no      Freeling
Polish        pl      TreeTagger
Portuguese    pt      Freeling
Romanian      ro      TreeTagger
Russian       ru      Freeling
Slovak        sk      TreeTagger
Slovenian     sl      Freeling
Spanish       es      Freeling

<!-- Asturian      as -->

#### Installing other optional software

To install the software listed under optional, please follow the installation instructions on the
respective websites or in the provided read-me files. Make sure to include their paths in the your `PATH`
environment variable. If you are using fast_align, please copy the binary files `atools` and `fast_align`
into the `bin/word_alignment` folder of the pipeline. Installation instructions for Corpus Workbench
are given [below](#cwb_install).

### Installing the Corpus Import tools

1. Install the corpus import tools by unpacking the archive to a directory of your choice (referred to as `installation_dir` from here on).
2. Set a new environment variable `SPARV_MAKEFILES` to `installation_dir/annotate/makefiles`.

### Editing some variables

In Makefile.config you will find a section called *Configuration*. Here you will need to specify the
path to the pipeline directory.
If you are planning on using the pipeline to install corpora on a remote computer, you must (in addition to installing CWB) edit the `remote_host`, `remote_cwb_datadir` and `remote_cwb_registry` variables.
If you are going to use anything database related (generating lemgram index or Word Picture data for Korp) you also have to edit the value of `rel_mysql_dbname`.

### Downloading and updating the models

Certain annotations need models to work. To download and generate the models follow these simple steps:

1. Navigate to the `installation_dir/annotate/models` directory in a terminal.
2. Run the command `make clean`, and then `make all`.

By default, the part-of-speech tagger also relies on the SALDO model. You can
disable this dependency by commenting out the line beginning with
`hunpos_morphtable` in Makefile.config, or changing its value to
`$(SPARV_MODELS)/hunpos.suc.morphtable`.

### Preparing a corpus

Create a directory for your corpus (e.g. `mycorpus`) under the `installation_dir/corpora` directory. Under your new directory create
another directory containing your input texts (e.g. `original`).

The input text must meet the following criteria:

* The files must be encoded in **UTF-8**.
* The format must be **valid XML**, *with the following two exceptions*:  
    1. No root element is needed. It is however required that all text in the file must be contained within elements.  
The simplest valid file possible consists of a single element, for example `<text>`, containing nothing but raw text.  
    2. Overlapping elements are allowed (`<a><b></a></b>`).
* No file should be larger than **~10-20 MB**, or you might run into memory problems. Split larger files into smaller files.

Every corpus needs a *Makefile* in which you configure the format of your input material and what annotations you want.
You can use the included `Makefile.example` as a base for a simple corpus, or `Makefile.template` if you want to dive into the more advanced stuff.
Whichever file you choose, you should put it in the directory you created for your corpus, and name the file `Makefile`.

By default `Makefile.example` is configured to read the source files from a directory named `original`, and assumes that all the text is contained within a `<text>` element.
This can easily be changed by editing the `original_dir` and `xml_elements` variables in the Makefile. For a description of every available variable and setting, see `Makefile.template`.

Once you have edited the Makefile to fit your source material and needs, you are ready to execute it by running one of the following commands in a terminal:

**`make TEXT`**  
This will parse your source files, which is a good place to start just to make sure everything works as it should. If there are any problems with the format of your source files,
the script will complain.

**`make vrt`**  
This will run every type of annotation that you have specified in the Makefile, and will output a VRT file for every input file.
The VRT format is used as input for Corpus Workbench to create binary corpus files. The resulting files will be found in the `annotations` directory (created automatically).

**`make export`**  
Same as `make vrt`, except the output format is XML and the files are saved to the `export.original` directory.

**`make cwb`**  
This command will take the VRT files and convert them to a Corpus Workbench corpus.

**`make install_corpus`**  
This will copy your Corpus Workbench corpus to a remote computer.

**`make relations`**  
Provided that you are using syntactic parsing, this will generate the relations data for the Word Picture in Korp.

**`make install_relations`**  
This will install the relations data to a remote MySQL server.

**`make add`**  
If you remove or add source files to your corpus after having already run one
of the commands above, you will have to run the above command.

For a complete list of available commands, run **`make`** without any arguments.

### <a name="cwb_install"></a>Installing Corpus Workbench (optional)

If you are not going to use the Korp backend, you can skip this step.

You will need the latest version of CWB for unicode support. Install by following these steps:

Check out the latest version of the source code from subversion by running the following command in a terminal:

    svn co https://cwb.svn.sourceforge.net/svnroot/cwb/cwb/trunk cwb

Navigate to the new cwb directory and run the following command:

    sudo ./install-scripts/cwb-install-ubuntu

CWB is now installed, and by default you will find it under `/usr/local/cwb-X.X.X/bin` (where `X.X.X` is the version number).
Confirm that the installation was successful by typing:

    /usr/local/cwb-X.X.X/bin/cqp -v

CWB needs two directories for storing the corpora. One for the data, and one for the corpus registry.
You may create these directories wherever you want, but let's assume that you have created the following two:

    /corpora/data
    /corpora/registry

You also need to edit the following variables in `installation_dir/annotate/makefiles/Makefile.config`, pointing to the directories created above:

    export CWB_DATADIR ?= /corpora/data
    export CORPUS_REGISTRY ?= /corpora/registry

If you're not running Ubuntu or if you run into any problems, refer to the INSTALL text file in the cwb dir for further instructions.
