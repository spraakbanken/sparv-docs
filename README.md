# sparv-docs
This repository includes documentation for Sparv pipeline, web tool and web service.

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
