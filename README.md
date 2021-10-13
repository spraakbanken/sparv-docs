# sparv-docs
This repository includes documentation for the Sparv pipeline, web tool and web service up until version 3.
The documentation for Sparv version 4 (or newer) is included in [the sparv-pipeline repository](https://github.com/spraakbanken/sparv-pipeline).

## Requirements
* [GPP](https://logological.org/gpp)
* [Pandoc](https://pandoc.org/)
* [pdfTeX](https://www.tug.org/applications/pdftex/)

## Usage
Generate PDF files with user manual and technical report:

    cd report
    ./make_report.sh

Generate html files (for documentation on Språkbanken's web page):

    ./md2html.sh

Include html files in drupal:

    {include https://github.com/spraakbanken/sparv-docs/raw/master/html/annotations_eng.html}

Build exercises PDF:

    cd exercises
    pdflatex sparvovningar_hw2017.tex
