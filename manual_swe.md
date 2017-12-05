
## Introduktion

Sparv är Språkbankens annoteringsverktyg som används bland annat för att
analysera korpusarna i Korp och texterna i Strix. Sparvs webbgränssnitt
(https://spraakbanken.gu.se/sparv)  kan användas för att annotera egna texter.

Denna manual beskriver de flesta funktionerna som finns i Sparv. Det finns även
ett par övningsuppgifter för Sparv som du kan ladda hem
[här](https://svn.spraakdata.gu.se/sb-arkiv/pub/dokumentation/sparv/exercises/sparvovningar_hw2017.pdf).

För att göra en analys räcker det att skriva eller klistra in en text i
textfältet (alternativt trycka på en av exempelknapparna) och sedan trycka på
den gröna **Kör**-knappen. När analysen är klar visas den som tabell under
inmatningsfältet.

![Sparvs webbgränssnitt](https://svn.spraakdata.gu.se/sb-arkiv/pub/dokumentation/sparv/img/sparv_granssnitt.png){width=550px style="float: right; margin-left: 10px;"}

## Snabbinställningar

Med kryssrutorna under inmatningsfältet kan man snabbt välja eller välja bort
analystyper. Om man t.ex. inte vill se dependensträden i resultatet, kan man
klicka ur kryssrutan för dependensanalysen.

Ovanför inmatningsfältet väljer man om man vill mata in ren text eller XML.
Standardläget är ren text. Om man matar in uppmärkt text måste man byta till XML
för att inte uppmärkningen ska försvinna.

## Resultatvy

När analysen är klar visas resultatet som en tabell under inmatningsfältet.
Varje kolumn i tabellen representerar en viss typ av analys på ordnivå. Man kan
få en kort förklaring för en analystyp genom att hålla musen över namnet i
tabellhuvudet. Även många andra förkortningar förklaras när man håller
muspekaren över dem, t.ex. etiketterna i dependensanalysen, kategorierna i
namntaggarna och de morfosyntaktiska beskrivningarna.

Om man har valt att göra en dependensanalys så visas denna inte bara i tabellen
utan även som ett dependensträd i tabellen i början av varje mening.

Strukturella attribut, dvs. analyser som görs på högre nivå en ordnivå visas som XML-taggar i tabellen.

- strukturella attribut (t.ex. lix, namn)

![En färdig sparvanalys](https://svn.spraakdata.gu.se/sb-arkiv/pub/dokumentation/sparv/img/sparv_resultat.png){width=550px style="float: right; margin-left: 10px;"}

## Analyslägen


## Avancerade inställningar

- olika för rentext/xml
- återställningsknapp

## Filuppladdning
