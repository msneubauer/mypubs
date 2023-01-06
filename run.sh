rm -f -- pubs.bib

# i below is the year, e.g. 22 is 2022
for i in $(seq -f "%02g" 22 0)
do
  curl 'https://inspirehep.net/api/literature?sort=mostrecent&size=1000&q=a%20M.S.Neubauer%20and%20date%2020'$i -H 'accept: application/x-bibtex' >> pubs.bib
done

perl -i -pe 's/<\/?\w+>//g;s/<[^<]+pagebody[^>]+>//g' pubs.bib
perl -i -pe 's/&gt;/\>/g' pubs.bib
perl -i -pe 's/\\t\\Wmp/ tW/g' pubs.bib
perl -i -pe 's/\\Wpm/ W/g' pubs.bib
perl -i -pe 's/\\Qbar/\\bar{Q}/g' pubs.bib
perl -i -pe 's/\\tbar/\\bar{t}/g' pubs.bib
perl -i -pe 's/\\Upsilon{/\\ensuremath{\\Upsilon/g' pubs.bib

rm *.aux *.bbl *.bcf *.blg *.log *.pdf *.xml
pdflatex pubs; biber pubs; pdflatex pubs; pdflatex pubs
#pdflatex pubs_selected; biber pubs_selected; pdflatex pubs_selected; pdflatex pubs_selected

#"/System/Library/Automator/Combine PDF Pages.action/Contents/Resources/join.py" -o ./pubs_both.pdf ./pubs_selected.pdf ./pubs.pdf
