
<#pagebreak>

## Introduktion

Sparv är Språkbankens annoteringsverktyg som används bland annat för att
analysera korpusarna i Korp och texterna i Strix. [Sparvs webbgränssnitt](https://spraakbanken.gu.se/sparv)  kan användas för att annotera egna texter.

Denna användarhandledningen beskriver de flesta funktionerna som finns
tillgängliga i webbgränssnittet. Det finns även ett par övningsuppgifter för
Sparv som du kan ladda hem
[här](https://svn.spraakdata.gu.se/sb-arkiv/pub/dokumentation/sparv/exercises/sparvovningar_hw2017.pdf).

För att göra en analys räcker det att skriva eller klistra in en text i
textfältet (alternativt trycka på en av exempelknapparna) och sedan trycka på
den gröna **Kör**-knappen. När analysen är klar visas den som tabell under
inmatningsfältet.

![Sparvs webbgränssnitt](https://svn.spraakdata.gu.se/sb-arkiv/pub/dokumentation/sparv/img/sparv_granssnitt.png){width=550px style="margin-left: 10px;"}

<#pagebreak>

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
utan även som ett dependensträd i början av varje mening. Strukturella attribut,
dvs. analyser som kan sträcka sig över flera ord eller över hela texten (t.ex.
läsbarhetsvärden eller namntaggar) visas som XML-taggar i tabellen.

Man kan även ladda ner hela analysen som XML genom att trycka på **XML**-knappen
ovanför tabellen.

![En färdig sparvanalys](https://svn.spraakdata.gu.se/sb-arkiv/pub/dokumentation/sparv/img/sparv_resultat.png){width=550px style="margin-left: 10px;"}

<#pagebreak>

## Analyslägen

Under Sparvlogotypen finns det en analysspråksväljare. Med hjälp av denna kan
man analysera texter som är skrivna på andra språk än svenska. I nuläget har
Sparv stöd för 20 analysspråk, men för de flesta språken stöds enbart
ordklasstaggning och lemmatisering.

Sparv har även ett analysläge för att annotera svenska texter från 1800-talet.
Här används information från två äldre ordböcker (Dalin och Swedberg) för att få
fram bättre analyser av ord med gammal stavning.

![Språkväljarmenyn](https://svn.spraakdata.gu.se/sb-arkiv/pub/dokumentation/sparv/img/sparv_sprakvaljare.png){width=200px style="float: right; margin-left: 10px;"}

## Avancerade inställningar

När man vill analysera en text som inte har någon uppmärkning räcker det oftast
att man skriver in texten i inmatningsfältet och sedan trycker på
**Kör**-knappen. Om texten innehåller XML behöver man dock ändra på några
inställningar för att berätta för Sparv vilka funktioner de olika taggarna i
indatan fyller.

Inställningarna öppnas genom att klicka på **Visa avancerade
inställningar**. Här kan man ange om styckes-, menings- och ordsegmenteringen
ska ske automatiskt eller om befintliga attribut ska användas, man kan
specifiera vad dokumentelementet heter, samt ange ytterligare taggar och
attribut som ska bevaras från indatan. Taggar och attribut som inte specifieras
kommer att försvinna i resultatet.

Man har även kontroll över exakt vilka
analyser som ska göras genom att klicka på de olika analysattributen. Är man
t.ex. bara intresserad av läsbarhetsvärdet **lix** kan man klicka ur **ovix**
och **nk** i de avancerade inställningarna. Man kan få en kort förklaring för en
inställning genom att klicka på frågetecknet bredvid den. Med hjälp av återställningsknappen kan man få fram standardinställningarna.

![Sparvs avancerade inställningar i XML-läget](https://svn.spraakdata.gu.se/sb-arkiv/pub/dokumentation/sparv/img/sparv_installningar.png){width=550px}

<#pagebreak>

## Filuppladdning

Istället för att mata in text i Sparvs textfält kan man använda sig av
filuppladdningen genom att trycka på **Ladda upp**-knappen. Accepterade
filformat är txt (ren text) och XML. Dokument skapade i Microsoft Word och
liknande kan inte analyseras.

Om man laddar upp XML-filer behöver man anpassa de avancerade inställningarna
för att inte uppmärkningen ska tolkas som vanlig text. Även analysspråket måste
väljas i filuppladdningsläget. Observera att man kan ladda upp och analysera
flera filer åt gången. Inställningarna och språkvalet gäller då alla filer som
laddas upp i samma körning.

Vissa analyser tar lång tid på sig och om man vill slippa vänta kan man skriva
in sin mailadress i email-fältet. Man kommer då att få ett mail med en
nedladdningslänk när analysen är klar. Om du har angett din mailadress går det
bra att stänga webbläsarfönstret medan analysen körs.

När man använder sig av filuppladdningen visas resultatet inte som tabell utan
man kan ladda ner en zip-fil med den annoterade texten i XML-format.

![Filuppladdningsläget](https://svn.spraakdata.gu.se/sb-arkiv/pub/dokumentation/sparv/img/sparv_uppladdning.png){width=400px style="margin-left: 10px;"}
