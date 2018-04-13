#set -x

# Script for creating technical report from markdown files
# Requires markdown and latex

# Concatenate all markdownfiles and add headings

# echo -e "Sparv 2: Technical Report\n" > technical_report.md
echo -e "\n# Acknowledgements\n" > technical_report.md
echo -e "\nThis work and research was supported by Yvonne Adesam, Malin Ahlberg, Gerlof Bouma, Martha Dís Brandt, Peter Ljunglöf, Richard Johansson, Luis Nieto Piña and Roland Schäfer. We thank our colleagues and former colleagues who made great contributions to Sparv.\n" >> technical_report.md

echo -e "\n# The Sparv Pipeline\n" >> technical_report.md
cat ../dist_pipeline.md >> technical_report.md
cat ../guide_pipeline_eng.md >> technical_report.md
cat ../import_format.md >> technical_report.md
cat ../annotations_eng.md >> technical_report.md
echo -e "\n# The Sparv Frontend\n" >> technical_report.md
cat ../dist_frontend_eng.md >> technical_report.md
cat ../devel_frontend_eng.md >> technical_report.md
echo -e "\n# The Sparv Backend\n" >> technical_report.md
cat ../dist_backend_eng.md >> technical_report.md
cat ../devel_backend_eng.md >> technical_report.md
echo -e "\n# The Sparv Web API\n" >> technical_report.md
cat ../ws_eng.md >> technical_report.md
echo -e "\n# Interaction between the Sparv Components\n" >> technical_report.md
cat ../interaction.md >> technical_report.md

cat ../manual_swe.md | sed 's/^##/#/' > användarmanual.md
cat ../manual_eng.md | sed 's/^##/#/' > usermanual.md

cat settings_template.tex | sed 's/LANGUAGE/swedish/' > settings_swe.tex
cat settings_template.tex | sed 's/LANGUAGE/english/' > settings_eng.tex


function make_document {
    # Convert markdown to latex/pdf:
    # Use macro.gpp to insert page breaks, references and files
    # pandoc $1 -t latex -o `basename $1 .md`.pdf \
    gpp -H -DTEX=1 --include ../macros.gpp $1 | pandoc -t latex -o `basename $1 .md`.pdf \
    -H settings_$2.tex `# include in header` \
    --toc `# table of contents` \
    -N `# numbered sections` \
    --listings `# use listings package for LaTeX code blocks` \
    -V urlcolor=RoyalBlue `# color links blue` \
    -V links-as-notes=true `# print links as footnotes`
}

make_document användarmanual.md swe
make_document usermanual.md eng

# New page for new chapter in technical report
echo "\\newcommand{\\sectionbreak}{\\clearpage}" >> settings_eng.tex
make_document technical_report.md eng

# Clean-up
rm settings_swe.tex
rm settings_eng.tex
rm användarmanual.md
rm usermanual.md
rm technical_report.md
