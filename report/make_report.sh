set -x

# Script for creating technical report from markdown files
# Requires markdown and latex


# # Get documentation for pipeline
# svn export https://svn.spraakdata.gu.se/repos/lb/trunk/sbkhs/pub/dist_pipeline.md
# svn export https://svn.spraakdata.gu.se/repos/lb/trunk/sbkhs/pub/guide_pipeline_eng.md
# svn export https://svn.spraakdata.gu.se/repos/lb/trunk/sbkhs/pub/import_format.md

# Concatenate all markdownfiles and add headings

# echo -e "Korp 6: Technical Report\n" > techincal_report.md
echo -e "\n# Acknowledgements\n" > techincal_report.md
echo -e "\nThis work and research was supported by Malin Ahlberg, Peter Ljunglöf and Roland Schäfer. We thank our colleagues and former colleagues who made great contributions to Sparv.\n" >> techincal_report.md

echo -e "\n# The Sparv Pipeline\n" >> techincal_report.md
cat dist_pipeline.md >> techincal_report.md
cat guide_pipeline_eng.md >> techincal_report.md
cat import_format.md >> techincal_report.md
cat ../annotations_eng.md >> techincal_report.md
echo -e "\n# The Sparv Frontend\n" >> techincal_report.md
cat ../dist_frontend_eng.md >> techincal_report.md
cat ../devel_frontend_eng.md >> techincal_report.md
echo -e "\n# The Sparv Backend\n" >> techincal_report.md
cat ../dist_backend_eng.md >> techincal_report.md
cat ../devel_backend_eng.md >> techincal_report.md
echo -e "\n# The Sparv Web API\n" >> techincal_report.md
cat ../ws_eng.md >> techincal_report.md

# cat ../korp_manual_swe.md | sed 's/^##/#/' > användarmanual.md

cat settings_template.tex | sed 's/LANGUAGE/swedish/' > settings_swe.tex
cat settings_template.tex | sed 's/LANGUAGE/english/' > settings_eng.tex

# New page for new chapter
echo "\\newcommand{\\sectionbreak}{\\clearpage}" >> settings_eng.tex


function make_document {
    # Convert markdown to latex/pdf:
    # pandoc $1 -t latex -o `basename $1 .md`.pdf \
    gpp -H -DTEX=1 --include macros.gpp $1 | pandoc -t latex -o `basename $1 .md`.pdf \
    -H settings_$2.tex `# include in header` \
    --toc `# table of contents` \
    -N `# numbered sections` \
    --listings `# use listings package for LaTeX code blocks` \
    -V urlcolor=RoyalBlue `# color links blue` \
    -V links-as-notes=true `# print links as footnotes`
}

# make_document användarmanual.md swe
make_document techincal_report.md eng

# Clean-up
rm settings_swe.tex
rm settings_eng.tex
rm techincal_report.md
# rm användarmanual.md
# rm dist_pipeline.md
# rm guide_pipeline_eng.md
# rm import_format.md
