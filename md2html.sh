# Convert all markdown files ending in md to html
for file in ./*.md; do 
	markdown $file > "`basename $file .md`.html"
done
