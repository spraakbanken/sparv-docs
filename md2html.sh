# Convert all markdown files ending in md to html
# for file in ./*.md; do
# 	markdown $file > "`basename $file .md`.html"
# done

for file in ./*.md; do
    gpp -H -DHTML=1 --include macros.gpp $file | pandoc -o `basename $file .md`.html \
    --listings `# use listings package for LaTeX code blocks` \
    -V urlcolor=RoyalBlue `# color links blue` \
    -V links-as-notes=true `# print links as footnotes`
done
