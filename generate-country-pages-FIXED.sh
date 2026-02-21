#!/bin/bash
# Flag Country Pages Generator (GERMAN - FIXED VERSION)
# Generates individual SEO pages for each country in /de/countries/

echo "🇩🇪 Generating German country pages..."

# Create countries directory
mkdir -p de/countries

# Country data array
declare -A COUNTRIES=(
    ["germany"]="Deutschland|Germany|Europe|Schwarz-Rot-Gold|Black-Red-Gold|Die deutsche Flagge zeigt drei horizontale Streifen in Schwarz, Rot und Gold.|The German flag shows three horizontal stripes in black, red, and gold."
    ["france"]="Frankreich|France|Europe|Blau-Weiß-Rot|Blue-White-Red|Die französische Trikolore zeigt drei vertikale Streifen.|The French tricolor shows three vertical stripes."
    ["italy"]="Italien|Italy|Europe|Grün-Weiß-Rot|Green-White-Red|Die italienische Flagge zeigt drei vertikale Streifen in Grün, Weiß und Rot.|The Italian flag shows three vertical stripes in green, white, and red."
    ["spain"]="Spanien|Spain|Europe|Rot-Gelb-Rot|Red-Yellow-Red|Die spanische Flagge zeigt drei horizontale Streifen mit dem Wappen auf dem mittleren gelben Streifen.|The Spanish flag shows three horizontal stripes with the coat of arms on the middle yellow stripe."
    ["portugal"]="Portugal|Portugal|Europe|Grün-Rot|Green-Red|Die portugiesische Flagge zeigt zwei vertikale Streifen mit dem Nationalwappen auf der Grenze.|The Portuguese flag shows two vertical stripes with the national coat of arms on the dividing line."
    ["netherlands"]="Niederlande|Netherlands|Europe|Rot-Weiß-Blau|Red-White-Blue|Die niederländische Flagge zeigt drei horizontale Streifen in Rot, Weiß und Blau.|The Dutch flag shows three horizontal stripes in red, white, and blue."
    ["belgium"]="Belgien|Belgium|Europe|Schwarz-Gelb-Rot|Black-Yellow-Red|Die belgische Flagge zeigt drei vertikale Streifen in Schwarz, Gelb und Rot.|The Belgian flag shows three vertical stripes in black, yellow, and red."
    ["austria"]="Österreich|Austria|Europe|Rot-Weiß-Rot|Red-White-Red|Die österreichische Flagge zeigt drei horizontale Streifen in Rot, Weiß und Rot.|The Austrian flag shows three horizontal stripes in red, white, and red."
    ["switzerland"]="Schweiz|Switzerland|Europe|Rot mit weißem Kreuz|Red with white cross|Die Schweizer Flagge zeigt ein weißes Kreuz auf rotem Hintergrund.|The Swiss flag shows a white cross on a red background."
    ["poland"]="Polen|Poland|Europe|Weiß-Rot|White-Red|Die polnische Flagge zeigt zwei horizontale Streifen in Weiß und Rot.|The Polish flag shows two horizontal stripes in white and red."
    ["czech-republic"]="Tschechien|Czech Republic|Europe|Weiß-Rot-Blau|White-Red-Blue|Die tschechische Flagge zeigt zwei horizontale Streifen mit blauem Dreieck am Mast.|The Czech flag shows two horizontal stripes with a blue triangle at the hoist."
    ["hungary"]="Ungarn|Hungary|Europe|Rot-Weiß-Grün|Red-White-Green|Die ungarische Flagge zeigt drei horizontale Streifen in Rot, Weiß und Grün.|The Hungarian flag shows three horizontal stripes in red, white, and green."
    ["romania"]="Rumänien|Romania|Europe|Blau-Gelb-Rot|Blue-Yellow-Red|Die rumänische Flagge zeigt drei vertikale Streifen in Blau, Gelb und Rot.|The Romanian flag shows three vertical stripes in blue, yellow, and red."
    ["bulgaria"]="Bulgarien|Bulgaria|Europe|Weiß-Grün-Rot|White-Green-Red|Die bulgarische Flagge zeigt drei horizontale Streifen in Weiß, Grün und Rot.|The Bulgarian flag shows three horizontal stripes in white, green, and red."
    ["greece"]="Griechenland|Greece|Europe|Blau-Weiß|Blue-White|Die griechische Flagge zeigt neun horizontale Streifen und ein weißes Kreuz auf blauem Feld.|The Greek flag shows nine horizontal stripes and a white cross on blue field."
    ["sweden"]="Schweden|Sweden|Europe|Blau-Gelb|Blue-Yellow|Die schwedische Flagge zeigt ein gelbes Kreuz auf blauem Hintergrund.|The Swedish flag shows a yellow cross on blue background."
    ["norway"]="Norwegen|Norway|Europe|Rot-Blau-Weiß|Red-Blue-White|Die norwegische Flagge zeigt ein blaues Kreuz mit weißem Rand auf rotem Hintergrund.|The Norwegian flag shows a blue cross with white border on red background."
    ["denmark"]="Dänemark|Denmark|Europe|Rot-Weiß|Red-White|Die dänische Flagge zeigt ein weißes Kreuz auf rotem Hintergrund.|The Danish flag shows a white cross on red background."
    ["finland"]="Finnland|Finland|Europe|Weiß-Blau|White-Blue|Die finnische Flagge zeigt ein blaues Kreuz auf weißem Hintergrund.|The Finnish flag shows a blue cross on white background."
    ["iceland"]="Island|Iceland|Europe|Blau-Weiß-Rot|Blue-White-Red|Die isländische Flagge zeigt ein rotes Kreuz mit weißem Rand auf blauem Hintergrund.|The Icelandic flag shows a red cross with white border on blue background."
    ["ireland"]="Irland|Ireland|Europe|Grün-Weiß-Orange|Green-White-Orange|Die irische Flagge zeigt drei vertikale Streifen in Grün, Weiß und Orange.|The Irish flag shows three vertical stripes in green, white, and orange."
    ["united-kingdom"]="Großbritannien|United Kingdom|Europe|Blau-Weiß-Rot|Blue-White-Red|Die britische Flagge zeigt das Union Jack-Muster.|The United Kingdom flag shows the Union Jack pattern."
    ["croatia"]="Kroatien|Croatia|Europe|Rot-Weiß-Blau mit Wappen|Red-White-Blue with coat of arms|Die kroatische Flagge zeigt drei horizontale Streifen mit Wappen in der Mitte.|The Croatian flag shows three horizontal stripes with coat of arms in the center."
    ["slovenia"]="Slowenien|Slovenia|Europe|Weiß-Blau-Rot mit Wappen|White-Blue-Red with coat of arms|Die slowenische Flagge zeigt drei horizontale Streifen mit Staatswappen.|The Slovenian flag shows three horizontal stripes with coat of arms."
    ["slovakia"]="Slowakei|Slovakia|Europe|Weiß-Blau-Rot mit Wappen|White-Blue-Red with coat of arms|Die slowakische Flagge zeigt drei horizontale Streifen mit Wappen auf der linken Seite.|The Slovak flag shows three horizontal stripes with coat of arms on the left."
    ["serbia"]="Serbien|Serbia|Europe|Rot-Blau-Weiß mit Wappen|Red-Blue-White with coat of arms|Die serbische Flagge zeigt drei horizontale Streifen mit Wappen auf der linken Seite.|The Serbian flag shows three horizontal stripes with coat of arms on the left."
    ["ukraine"]="Ukraine|Ukraine|Europe|Blau-Gelb|Blue-Yellow|Die ukrainische Flagge zeigt zwei horizontale Streifen in Blau und Gelb.|The Ukrainian flag shows two horizontal stripes in blue and yellow."
    ["russia"]="Russland|Russia|Europe|Weiß-Blau-Rot|White-Blue-Red|Die russische Flagge zeigt drei horizontale Streifen in Weiß, Blau und Rot.|The Russian flag shows three horizontal stripes in white, blue, and red."
    ["usa"]="USA|USA|North America|Rot-Weiß-Blau|Red-White-Blue|Die US-amerikanische Flagge zeigt 50 Sterne auf blauem Feld und 13 horizontale Streifen.|The US flag shows 50 stars on blue field and 13 horizontal stripes."
    ["canada"]="Kanada|Canada|North America|Rot‑Weiß mit Ahornblatt|Red‑White with maple leaf|Die kanadische Flagge zeigt ein rotes Ahornblatt auf weißem Hintergrund zwischen zwei roten Streifen.|The Canadian flag shows a red maple leaf on a white background between two red bars."
    ["mexico"]="Mexiko|Mexico|North America|Grün‑Weiß‑Rot mit Wappen|Green‑White‑Red with coat of arms|Die mexikanische Flagge besteht aus drei vertikalen Streifen mit dem Staatswappen in der Mitte.|The Mexican flag consists of three vertical stripes with the national coat of arms in the center."
    ["brazil"]="Brasilien|Brazil|South America|Grün‑Gelb‑Blau|Green‑Yellow‑Blue|Die brasilianische Flagge zeigt einen gelben Rhombus mit blauem Kreis und Sternen auf grünem Hintergrund.|The Brazilian flag shows a yellow rhombus with a blue circle and stars on a green background."
    ["argentina"]="Argentinien|Argentina|South America|Hellblau‑Weiß‑Hellblau mit Sonne|Light Blue‑White‑Light Blue with sun|Die argentinische Flagge zeigt drei horizontale Streifen und eine Sonne in der Mitte.|The Argentine flag shows three horizontal stripes and a sun in the center."
    ["chile"]="Chile|Chile|South America|Weiß‑Rot‑Blau mit Stern|White‑Red‑Blue with star|Die chilenische Flagge zeigt einen blauen Kanton mit weißem Stern und horizontale Streifen.|The Chilean flag shows a blue canton with a white star and horizontal stripes."
    ["colombia"]="Kolumbien|Colombia|South America|Gelb‑Blau‑Rot|Yellow‑Blue‑Red|Die kolumbianische Flagge zeigt drei horizontale Streifen – gelb, blau und rot.|The Colombian flag shows three horizontal stripes in yellow, blue, and red."
    ["peru"]="Peru|Peru|South America|Rot‑Weiß‑Rot mit Wappen|Red‑White‑Red with coat of arms|Die peruanische Flagge zeigt vertikale Streifen mit Staatswappen in der Mitte.|The Peruvian flag shows vertical stripes with the national coat of arms in the center."
    ["venezuela"]="Venezuela|Venezuela|South America|Gelb‑Blau‑Rot mit Sternen|Yellow‑Blue‑Red with stars|Die venezolanische Flagge zeigt drei horizontale Streifen mit Sternen im blauen Streifen.|The Venezuelan flag shows three horizontal stripes with stars in the blue stripe."
    ["china"]="China|China|Asia|Rot mit gelben Sternen|Red with yellow stars|Die chinesische Flagge zeigt eine große und vier kleine gelbe Sterne auf rotem Hintergrund.|The Chinese flag shows one large and four small yellow stars on red background."
    ["japan"]="Japan|Japan|Asia|Weiß mit rotem Kreis|White with red circle|Die japanische Flagge zeigt eine rote Sonnenscheibe auf weißem Hintergrund.|The Japanese flag shows a red sun disc on white background."
    ["south-korea"]="Südkorea|South Korea|Asia|Weiß mit Yin‑Yang und Trigrammen|White with yin‑yang and trigrams|Die südkoreanische Flagge zeigt ein Yin‑Yang‑Symbol und vier schwarze Trigramme.|The South Korean flag shows a yin‑yang symbol and four black trigrams."
    ["india"]="Indien|India|Asia|Orange‑Weiß‑Grün mit Rad|Saffron‑White‑Green with wheel|Die indische Flagge zeigt drei horizontale Streifen mit einem blauen Rad in der Mitte.|The Indian flag shows three horizontal stripes with a blue wheel in the center."
    ["thailand"]="Thailand|Thailand|Asia|Rot‑Weiß‑Blau|Red‑White‑Blue|Die thailändische Flagge zeigt fünf horizontale Streifen in Rot, Weiß und Blau.|The Thai flag shows five horizontal stripes in red, white, and blue."
    ["vietnam"]="Vietnam|Vietnam|Asia|Rot mit gelbem Stern|Red with yellow star|Die vietnamesische Flagge zeigt einen gelben Stern auf rotem Hintergrund.|The Vietnamese flag shows a yellow star on a red background."
    ["indonesia"]="Indonesien|Indonesia|Asia|Rot‑Weiß|Red‑White|Die indonesische Flagge zeigt zwei horizontale Streifen in Rot und Weiß.|The Indonesian flag shows two horizontal stripes in red and white."
    ["malaysia"]="Malaysia|Malaysia|Asia|Rot‑Weiß‑Blau mit Halbmond und Stern|Red‑White‑Blue with crescent and star|Die malaysische Flagge zeigt rote und weiße Streifen sowie einen gelben Halbmond und Stern.|The Malaysian flag shows red and white stripes with a yellow crescent and star."
    ["philippines"]="Philippinen|Philippines|Asia|Blau‑Rot‑Weiß mit Sonne und Sternen|Blue‑Red‑White with sun and stars|Die philippinische Flagge zeigt horizontale Streifen und ein Dreieck mit Sonne und Sternen.|The Philippine flag shows horizontal stripes and a triangle with sun and stars."
    ["singapore"]="Singapur|Singapore|Asia|Rot‑Weiß mit Halbmond und Sternen|Red‑White with crescent and stars|Die singapurische Flagge zeigt einen weißen Halbmond und fünf Sterne auf rotem Feld.|The Singaporean flag shows a white crescent and five stars on a red field."
    ["australia"]="Australien|Australia|Oceania|Blau mit Union Jack und Sternen|Blue with Union Jack and stars|Die australische Flagge zeigt den Union Jack und Sterne des Südkreuzes auf blauem Hintergrund.|The Australian flag shows the Union Jack and Southern Cross stars on blue background."
    ["new-zealand"]="Neuseeland|New Zealand|Oceania|Blau mit Union Jack und Sternen|Blue with Union Jack and stars|Die neuseeländische Flagge zeigt den Union Jack und vier rote Sterne mit weißem Rand.|The New Zealand flag shows the Union Jack and four red stars with white border."
    ["south-africa"]="Südafrika|South Africa|Africa|Mehrfarbig mit Y‑Form|Multicolored with Y‑shape|Die südafrikanische Flagge zeigt ein Y‑förmiges Muster mit mehreren Farben.|The South African flag shows a Y‑shaped pattern with multiple colors."
    ["egypt"]="Ägypten|Egypt|Africa|Rot‑Weiß‑Schwarz mit Adler|Red‑White‑Black with eagle|Die ägyptische Flagge zeigt drei horizontale Streifen mit einem goldenen Adler.|The Egyptian flag shows three horizontal stripes with a golden eagle."
    ["morocco"]="Marokko|Morocco|Africa|Rot mit grünem Stern|Red with green star|Die marokkanische Flagge zeigt einen grünen fünfzackigen Stern auf rotem Hintergrund.|The Moroccan flag shows a green five‑pointed star on a red background."
    ["nigeria"]="Nigeria|Nigeria|Africa|Grün‑Weiß‑Grün|Green‑White‑Green|Die nigerianische Flagge besteht aus drei vertikalen Streifen in Grün und Weiß.|The Nigerian flag consists of three vertical stripes in green and white."
    ["kenya"]="Kenia|Kenya|Africa|Schwarz‑Rot‑Grün mit Schild|Black‑Red‑Green with shield|Die kenianische Flagge zeigt horizontale Streifen und ein traditionelles Schild.|The Kenyan flag shows horizontal stripes and a traditional shield."
    ["turkey"]="Türkei|Turkey|Europe/Asia|Rot mit weißem Halbmond und Stern|Red with white crescent and star|Die türkische Flagge zeigt einen weißen Halbmond und Stern auf rotem Hintergrund.|The Turkish flag shows a white crescent and star on a red background."
    ["israel"]="Israel|Israel|Asia|Weiß mit blauem Davidstern|White with blue Star of David|Die israelische Flagge zeigt zwei blaue Streifen und einen Davidstern.|The Israeli flag shows two blue stripes and a Star of David."
    ["saudi-arabia"]="Saudi-Arabien|Saudi Arabia|Asia|Grün mit Schrift und Schwert|Green with script and sword|Die saudische Flagge zeigt arabische Schrift und ein Schwert.|The Saudi Arabian flag shows Arabic script and a sword."
    ["united-arab-emirates"]="Vereinigte Arabische Emirate|United Arab Emirates|Asia|Rot‑Grün‑Weiß‑Schwarz|Red‑Green‑White‑Black|Die Flagge der VAE kombiniert Farben in horizontalen und vertikalen Bereichen.|The UAE flag combines colors in horizontal and vertical sections."
    ["qatar"]="Katar|Qatar|Asia|Bordeaux‑Weiß gezackt|Maroon‑White serrated|Die Flagge Katars zeigt bordeauxfarbene und weiße gezackte Streifen.|The Qatari flag shows maroon and white serrated stripes."
    ["estonia"]="Estland|Estonia|Europe|Blau‑Schwarz‑Weiß|Blue‑Black‑White|Die estnische Flagge zeigt drei horizontale Streifen in Blau, Schwarz und Weiß.|The Estonian flag shows three horizontal stripes in blue, black, and white."
    ["latvia"]="Lettland|Latvia|Europe|Dunkelrot‑Weiß‑Dunkelrot|Dark Red‑White‑Dark Red|Die lettische Flagge zeigt zwei dunkelrote Streifen mit einem weißen Streifen dazwischen.|The Latvian flag shows two dark red stripes with a white stripe between them."
    ["lithuania"]="Litauen|Lithuania|Europe|Gelb‑Grün‑Rot|Yellow‑Green‑Red|Die litauische Flagge zeigt drei horizontale Streifen in Gelb, Grün und Rot.|The Lithuanian flag shows three horizontal stripes in yellow, green, and red."
    ["luxembourg"]="Luxemburg|Luxembourg|Europe|Rot‑Weiß‑Hellblau|Red‑White‑Light Blue|Die luxemburgische Flagge zeigt drei horizontale Streifen mit Hellblau statt Dunkelblau.|The Luxembourg flag shows three horizontal stripes with light blue instead of dark blue."
    ["monaco"]="Monaco|Monaco|Europe|Rot‑Weiß|Red‑White|Die monegassische Flagge zeigt zwei horizontale Streifen in Rot und Weiß.|The Monaco flag shows two horizontal stripes in red and white."
    ["malta"]="Malta|Malta|Europe|Weiß‑Rot mit Georgskreuz|White‑Red with George Cross|Die maltesische Flagge zeigt zwei vertikale Streifen und das Georgskreuz.|The Maltese flag shows two vertical stripes and the George Cross."
    ["cyprus"]="Zypern|Cyprus|Europe|Weiß mit Karte und Olivenzweigen|White with map and olive branches|Die zypriotische Flagge zeigt die Inselkarte und Olivenzweige.|The Cyprus flag shows the island map and olive branches."
    ["albania"]="Albanien|Albania|Europe|Rot mit schwarzem Adler|Red with black eagle|Die albanische Flagge zeigt einen schwarzen Doppelkopfadler auf rotem Hintergrund.|The Albanian flag shows a black double‑headed eagle on red background."
    ["north-macedonia"]="Nordmazedonien|North Macedonia|Europe|Rot‑Gelb|Red‑Yellow|Die nordmazedonische Flagge zeigt eine stilisierte Sonne mit Strahlen.|The North Macedonian flag shows a stylized sun with rays."
    ["bosnia-herzegovina"]="Bosnien und Herzegowina|Bosnia and Herzegovina|Europe|Blau‑Gelb‑Weiß|Blue‑Yellow‑White|Die Flagge zeigt ein gelbes Dreieck auf blauem Hintergrund mit weißen Sternen.|The flag shows a yellow triangle on a blue background with white stars."
    ["montenegro"]="Montenegro|Montenegro|Europe|Rot mit Wappen|Red with coat of arms|Die Flagge zeigt ein goldenes Wappen auf rotem Hintergrund.|The flag shows a golden coat of arms on a red background."
    ["kosovo"]="Kosovo|Kosovo|Europe|Blau mit Sternen|Blue with stars|Die Flagge zeigt sechs weiße Sterne auf blauem Hintergrund.|The flag shows six white stars on a blue background."
    ["andorra"]="Andorra|Andorra|Europe|Blau‑Gelb‑Rot mit Wappen|Blue‑Yellow‑Red with coat of arms|Die Flagge zeigt drei vertikale Streifen mit dem Wappen in der Mitte.|The flag shows three vertical stripes with the coat of arms in the center."
    ["liechtenstein"]="Liechtenstein|Liechtenstein|Europe|Blau‑Rot mit Krone|Blue‑Red with crown|Die Flagge zeigt zwei horizontale Streifen mit Krone.|The flag shows two horizontal stripes with a crown."
    ["san-marino"]="San Marino|San Marino|Europe|Weiß‑Blau mit Wappen|White‑Blue with coat of arms|Die Flagge zeigt zwei horizontale Streifen mit Staatswappen.|The flag shows two horizontal stripes with the national coat of arms."
    ["vatican"]="Vatikanstadt|Vatican City|Europe|Gelb‑Weiß mit Wappen|Yellow‑White with coat of arms|Die Flagge zeigt zwei vertikale Streifen und das päpstliche Wappen.|The flag shows two vertical stripes and the papal coat of arms."
    ["moldova"]="Moldau|Moldova|Europe|Blau‑Gelb‑Rot mit Wappen|Blue‑Yellow‑Red with coat of arms|Die Flagge zeigt drei vertikale Streifen mit Wappen in der Mitte.|The flag shows three vertical stripes with the coat of arms in the center."
    ["belarus"]="Belarus|Belarus|Europe|Rot‑Grün mit Ornament|Red‑Green with pattern|Die Flagge zeigt horizontale Streifen und ein traditionelles Muster.|The flag shows horizontal stripes with a traditional pattern."
    ["georgia"]="Georgien|Georgia|Europe/Asia|Weiß mit roten Kreuzen|White with red crosses|Die Flagge zeigt fünf rote Kreuze auf weißem Hintergrund.|The flag shows five red crosses on a white background."
    ["armenia"]="Armenien|Armenia|Europe/Asia|Rot‑Blau‑Orange|Red‑Blue‑Orange|Die Flagge zeigt drei horizontale Streifen in Rot, Blau und Orange.|The flag shows three horizontal stripes in red, blue, and orange."
    ["azerbaijan"]="Aserbaidschan|Azerbaijan|Asia|Blau‑Rot‑Grün mit Mond und Stern|Blue‑Red‑Green with crescent and star|Die Flagge zeigt drei Streifen mit Halbmond und achtzackigem Stern.|The flag shows three stripes with a crescent and eight‑pointed star."
    ["pakistan"]="Pakistan|Pakistan|Asia|Grün‑Weiß mit Mond und Stern|Green‑White with crescent and star|Die Flagge zeigt einen weißen Halbmond und Stern auf grünem Hintergrund.|The flag shows a white crescent and star on green background."
    ["bangladesh"]="Bangladesch|Bangladesh|Asia|Grün mit rotem Kreis|Green with red circle|Die Flagge zeigt einen roten Kreis auf grünem Hintergrund.|The flag shows a red circle on a green background."
    ["sri-lanka"]="Sri Lanka|Sri Lanka|Asia|Gelb‑Orange‑Grün mit Löwe|Yellow‑Orange‑Green with lion|Die Flagge zeigt einen goldenen Löwen und Farbstreifen.|The flag shows a golden lion and colored stripes."
    ["myanmar"]="Myanmar|Myanmar|Asia|Gelb‑Grün‑Rot mit Stern|Yellow‑Green‑Red with star|Die Flagge zeigt drei horizontale Streifen mit weißem Stern.|The flag shows three horizontal stripes with a white star."
    ["cambodia"]="Kambodscha|Cambodia|Asia|Blau‑Rot mit Tempel|Blue‑Red with temple|Die Flagge zeigt Angkor Wat auf rotem Streifen zwischen blauen Streifen.|The flag shows Angkor Wat on a red stripe between blue stripes."
    ["laos"]="Laos|Laos|Asia|Blau‑Rot‑Weiß|Blue‑Red‑White|Die Flagge zeigt drei horizontale Streifen mit weißem Kreis.|The flag shows three horizontal stripes with a white circle."
    ["brunei"]="Brunei|Brunei|Asia|Gelb mit Wappen|Yellow with coat of arms|Die Flagge zeigt ein gelbes Feld mit königlichem Wappen.|The flag shows a yellow field with the royal coat of arms."
    ["east-timor"]="Osttimor|East Timor|Asia|Rot‑Schwarz‑Gelb mit Stern|Red‑Black‑Yellow with star|Die Flagge zeigt ein rotes Dreieck, ein schwarzes Dreieck und gelbe Elemente.|The flag shows a red triangle, black triangle, and yellow elements."
    ["mongolia"]="Mongolei|Mongolia|Asia|Rot‑Blau mit Symbol|Red‑Blue with symbol|Die Flagge zeigt vertikale Streifen und das mongolische Symbol.|The flag shows vertical stripes and the Mongolian symbol."
    ["nepal"]="Nepal|Nepal|Asia|Rot mit blauem Rand und Sonne|Red with blue border and sun|Die Flagge zeigt zwei ungleich große Dreiecke mit Symbolen.|The flag shows two unequal triangles with symbols."
    ["bhutan"]="Bhutan|Bhutan|Asia|Orange‑Gelb mit Drache|Orange‑Yellow with dragon|Die Flagge zeigt einen Drachen auf zweifarbigen Streifen.|The flag shows a dragon on two colored stripes."
    ["maldives"]="Malediven|Maldives|Asia|Rot‑Grün mit Rechteck|Red‑Green with rectangle|Die Flagge zeigt ein weißes Rechteck auf rotem und grünem Feld.|The flag shows a white rectangle on red and green fields."
    ["afghanistan"]="Afghanistan|Afghanistan|Asia|Schwarz‑Rot‑Grün mit Emblem|Black‑Red‑Green with emblem|Die Flagge zeigt drei vertikale Streifen mit Emblem in der Mitte.|The flag shows three vertical stripes with emblem in the center."
    ["kazakhstan"]="Kasachstan|Kazakhstan|Asia|Hellblau mit Sonne und Adler|Light blue with sun and eagle|Die Flagge zeigt Sonne und Adler auf hellblauem Hintergrund.|The flag shows sun and eagle on light blue background."
    ["uzbekistan"]="Usbekistan|Uzbekistan|Asia|Blau‑Weiß‑Grün mit Rot|Blue‑White‑Green with red|Die Flagge zeigt Streifen mit Mondsichel und Sternen.|The flag shows stripes with crescent and stars."
    ["turkmenistan"]="Turkmenistan|Turkmenistan|Asia|Grün mit Muster und Rot|Green with pattern and red|Die Flagge zeigt traditionelle Muster auf grünem Hintergrund.|The flag shows traditional patterns on green background."
    ["kyrgyzstan"]="Kirgisistan|Kyrgyzstan|Asia|Rot mit Sonne|Red with sun|Die Flagge zeigt eine gelbe Sonne mit 40 Strahlen auf rotem Hintergrund.|The flag shows a yellow sun with 40 rays on red background."
    ["tajikistan"]="Tadschikistan|Tajikistan|Asia|Rot‑Weiß‑Grün mit Krone|Red‑White‑Green with crown|Die Flagge zeigt drei Streifen und ein Emblem in der Mitte.|The flag shows three stripes and an emblem in the center."
    ["north-korea"]="Nordkorea|North Korea|Asia|Rot‑Blau‑Weiß mit Stern|Red‑Blue‑White with star|Die Flagge zeigt horizontale Streifen und einen roten Stern.|The flag shows horizontal stripes and a red star."
    ["taiwan"]="Taiwan|Taiwan|Asia|Rot mit Blau und weißem Sonne|Red with blue and white sun|Die Flagge zeigt eine weiße Sonne auf blauem Kanton.|The flag shows a white sun on blue canton."
    ["hong-kong"]="Hongkong|Hong Kong|Asia|Rot mit weißem Bauhinia-Blume|Red with white Bauhinia flower|Die Flagge zeigt die weiße Bauhinia-Blume auf rotem Hintergrund.|The flag shows the white Bauhinia flower on red background."
    ["iran"]="Iran|Iran|Asia|Grün‑Weiß‑Rot mit Wappen|Green‑White‑Red with emblem|Die Flagge zeigt drei horizontale Streifen mit Staatswappen.|The flag shows three horizontal stripes with the national emblem."
    ["iraq"]="Irak|Iraq|Asia|Rot‑Weiß‑Schwarz mit Schrift|Red‑White‑Black with script|Die Flagge zeigt drei horizontale Streifen mit arabischer Schrift.|The flag shows three horizontal stripes with Arabic script."
    ["kuwait"]="Kuwait|Kuwait|Asia|Grün‑Weiß‑Rot‑Schwarz|Green‑White‑Red‑Black|Die Flagge zeigt horizontale Streifen und ein schwarzes Dreieck.|The flag shows horizontal stripes and a black triangle."
    ["bahrain"]="Bahrain|Bahrain|Asia|Rot-Weiß|Red-White|Die Flagge zeigt rote und weiße Zackenstreifen.|The flag shows red and white serrated stripes."
    ["oman"]="Oman|Oman|Asia|Weiß-Rot-Grün mit Wappen|White-Red-Green with emblem|Die Flagge zeigt drei horizontale Streifen und ein Emblem links.|The flag shows three horizontal stripes with an emblem on the left."
    ["yemen"]="Jemen|Yemen|Asia|Rot-Weiß-Schwarz|Red-White-Black|Die Flagge besteht aus drei horizontalen Streifen.|The flag consists of three horizontal stripes."
    ["syria"]="Syrien|Syria|Asia|Rot-Weiß-Schwarz mit Sternen|Red-White-Black with stars|Die Flagge zeigt drei Streifen mit zwei grünen Sternen.|The flag shows three stripes with two green stars."
    ["lebanon"]="Libanon|Lebanon|Asia|Rot-Weiß-Grün mit Zeder|Red-White-Green with cedar|Die Flagge zeigt eine Zeder auf weißem Streifen.|The flag shows a cedar tree on the white stripe."
    ["jordan"]="Jordanien|Jordan|Asia|Schwarz-Weiß-Grün mit rotem Dreieck|Black-White-Green with red triangle|Die Flagge hat drei Streifen und ein rotes Dreieck.|The flag has three stripes and a red triangle."
    ["palestine"]="Palästina|Palestine|Asia|Schwarz-Weiß-Grün mit rotem Dreieck|Black-White-Green with red triangle|Die Flagge zeigt drei horizontale Streifen mit Dreieck links.|The flag shows three horizontal stripes with a triangle on the left."
    ["algeria"]="Algerien|Algeria|Africa|Grün-Weiß mit Halbmond und Stern|Green-White with crescent and star|Die Flagge zeigt Halbmond und Stern in der Mitte.|The flag shows a crescent and star in the center."
    ["tunisia"]="Tunesien|Tunisia|Africa|Rot-Weiß mit Halbmond und Stern|Red-White with crescent and star|Die Flagge zeigt einen weißen Kreis mit Halbmond und Stern.|The flag shows a white circle with crescent and star."
    ["libya"]="Libyen|Libya|Africa|Rot-Schwarz-Grün mit Mond und Stern|Red-Black-Green with crescent and star|Die Flagge zeigt drei horizontale Streifen mit Symbol.|The flag shows three horizontal stripes with symbol."
    ["sudan"]="Sudan|Sudan|Africa|Rot-Weiß-Schwarz-Grün|Red-White-Black-Green|Die Flagge hat drei horizontale Streifen und ein grünes Dreieck.|The flag has three horizontal stripes and a green triangle."
    ["south-sudan"]="Südsudan|South Sudan|Africa|Schwarz-Rot-Grün-Blau mit Stern|Black-Red-Green-Blue with star|Die Flagge zeigt Streifen und einen gelben Stern auf blauem Dreieck.|The flag shows stripes and a yellow star on a blue triangle."
    ["ethiopia"]="Äthiopien|Ethiopia|Africa|Grün-Gelb-Rot mit Emblem|Green-Yellow-Red with emblem|Die Flagge zeigt drei Streifen mit rundem Emblem in der Mitte.|The flag shows three stripes with a round emblem in the center."
    ["somalia"]="Somalia|Somalia|Africa|Hellblau mit weißem Stern|Light Blue with white star|Die Flagge zeigt einen weißen fünfzackigen Stern.|The flag shows a white five-pointed star."
    ["uganda"]="Uganda|Uganda|Africa|Schwarz-Gelb-Rot mit Vogel|Black-Yellow-Red with bird|Die Flagge zeigt einen Vogel auf weißen Streifen.|The flag shows a bird on white stripes."
    ["tanzania"]="Tansania|Tanzania|Africa|Grün-Schwarz-Blau-Gelb|Green-Black-Blue-Yellow|Die Flagge zeigt diagonale Streifen in vier Farben.|The flag shows diagonal stripes in four colors."
    ["ghana"]="Ghana|Ghana|Africa|Rot-Gelb-Grün mit schwarzem Stern|Red-Yellow-Green with black star|Die Flagge zeigt einen schwarzen Stern auf gelbem Streifen.|The flag shows a black star on the yellow stripe."
    ["ivory-coast"]="Elfenbeinküste|Ivory Coast|Africa|Orange-Weiß-Grün|Orange-White-Green|Die Flagge besteht aus drei vertikalen Streifen.|The flag consists of three vertical stripes."
    ["senegal"]="Senegal|Senegal|Africa|Grün-Gelb-Rot mit grünem Stern|Green-Yellow-Red with green star|Die Flagge zeigt einen grünen Stern auf dem mittleren Streifen.|The flag shows a green star on the middle stripe."
    ["cameroon"]="Kamerun|Cameroon|Africa|Grün-Rot-Gelb mit Stern|Green-Red-Yellow with star|Die Flagge zeigt einen gelben Stern auf dem mittleren roten Streifen.|The flag shows a yellow star on the middle red stripe."
    ["angola"]="Angola|Angola|Africa|Rot-Schwarz mit Emblem|Red-Black with emblem|Die Flagge zeigt ein gelbes Emblem in der Mitte.|The flag shows a yellow emblem in the center."
    ["mozambique"]="Mosambik|Mozambique|Africa|Grün-Schwarz-Gelb-Rot mit Emblem|Green-Black-Yellow-Red with emblem|Die Flagge zeigt ein Emblem auf der linken Seite.|The flag shows an emblem on the left side."
    ["zimbabwe"]="Simbabwe|Zimbabwe|Africa|Grün-Gold-Rot-Schwarz mit Stern|Green-Gold-Red-Black with star|Die Flagge zeigt einen roten Stern auf weißem Dreieck.|The flag shows a red star on a white triangle."
    ["zambia"]="Sambia|Zambia|Africa|Grün-Orange-Schwarz-Blau|Green-Orange-Black-Blue|Die Flagge zeigt einen Adler und farbige Streifen.|The flag shows an eagle and colored stripes."
    ["namibia"]="Namibia|Namibia|Africa|Blau-Rot-Grün mit Sonne|Blue-Red-Green with sun|Die Flagge zeigt eine gelbe Sonne auf blauem Hintergrund.|The flag shows a yellow sun on blue background."
    ["botswana"]="Botswana|Botswana|Africa|Blau-Schwarz-Blau|Blue-Black-Blue|Die Flagge zeigt einen schwarzen Streifen auf blauem Hintergrund.|The flag shows a black stripe on a blue background."
    ["madagascar"]="Madagaskar|Madagascar|Africa|Rot-Weiß-Grün|Red-White-Green|Die Flagge zeigt vertikale und horizontale Streifen.|The flag shows vertical and horizontal stripes."
    ["mauritius"]="Mauritius|Mauritius|Africa|Rot-Blau-Gelb-Grün|Red-Blue-Yellow-Green|Die Flagge zeigt vier horizontale Streifen.|The flag shows four horizontal stripes."
    ["rwanda"]="Ruanda|Rwanda|Africa|Blau-Gelb-Grün mit Sonne|Blue-Yellow-Green with sun|Die Flagge zeigt eine Sonne auf blauem Streifen.|The flag shows a sun on the blue stripe."
    ["benin"]="Benin|Benin|Africa|Grün-Gelb-Rot|Green-Yellow-Red|Die Flagge zeigt drei farbige Flächen.|The flag shows three colored fields."
    ["togo"]="Togo|Togo|Africa|Grün-Gelb-Rot mit Stern|Green-Yellow-Red with star|Die Flagge zeigt horizontale Streifen und einen weißen Stern.|The flag shows horizontal stripes with a white star."
    ["mali"]="Mali|Mali|Africa|Grün-Gelb-Rot|Green-Yellow-Red|Die Flagge besteht aus drei vertikalen Streifen.|The flag consists of three vertical stripes."
    ["burkina-faso"]="Burkina Faso|Burkina Faso|Africa|Rot-Grün mit Stern|Red-Green with star|Die Flagge zeigt einen gelben Stern in der Mitte.|The flag shows a yellow star in the center."
    ["niger"]="Niger|Niger|Africa|Orange-Weiß-Grün mit Sonne|Orange-White-Green with sun|Die Flagge zeigt eine orange Sonne auf weißem Streifen.|The flag shows an orange sun on the white stripe."
    ["chad"]="Tschad|Chad|Africa|Blau-Gelb-Rot|Blue-Yellow-Red|Die Flagge besteht aus drei vertikalen Streifen.|The flag consists of three vertical stripes."
    ["gabon"]="Gabun|Gabon|Africa|Grün-Gelb-Blau|Green-Yellow-Blue|Die Flagge zeigt drei horizontale Streifen.|The flag shows three horizontal stripes."
    ["congo"]="Kongo|Congo|Africa|Blau-Gelb-Rot|Blue-Yellow-Red|Die Flagge besteht aus diagonalen Streifen.|The flag consists of diagonal stripes."
    ["dr-congo"]="Demokratische Republik Kongo|Democratic Republic of the Congo|Africa|Blau-Rot-Gelb|Blue-Red-Yellow|Die Flagge zeigt einen gelben Stern auf blauem Feld.|The flag shows a yellow star on blue field."
    ["uruguay"]="Uruguay|Uruguay|South America|Weiß-Blau mit Sonne|White-Blue with sun|Die Flagge zeigt Sonne auf weiß-blauen Streifen.|The flag shows a sun on white-blue stripes."
    ["paraguay"]="Paraguay|Paraguay|South America|Rot-Weiß-Blau mit Wappen|Red-White-Blue with coat of arms|Die Flagge zeigt das Wappen in der Mitte.|The flag shows the coat of arms in the center."
    ["ecuador"]="Ecuador|Ecuador|South America|Gelb-Blau-Rot mit Wappen|Yellow-Blue-Red with coat of arms|Die Flagge zeigt das Wappen in der Mitte.|The flag shows the coat of arms in the center."
    ["bolivia"]="Bolivien|Bolivia|South America|Rot-Gelb-Grün|Red-Yellow-Green|Die Flagge zeigt drei horizontale Streifen.|The flag shows three horizontal stripes."
    ["panama"]="Panama|Panama|North America|Weiß-Rot-Blau|White-Red-Blue|Die Flagge zeigt vier Felder mit Sternen.|The flag shows four fields with stars."
    ["costa-rica"]="Costa Rica|Costa Rica|North America|Blau-Weiß-Rot|Blue-White-Red|Die Flagge zeigt fünf horizontale Streifen.|The flag shows five horizontal stripes."
    ["guatemala"]="Guatemala|Guatemala|North America|Blau-Weiß-Blau mit Wappen|Blue-White-Blue with coat of arms|Die Flagge zeigt das Wappen auf dem weißen Streifen.|The flag shows the coat of arms on the white stripe."
    ["honduras"]="Honduras|Honduras|North America|Blau-Weiß-Blau mit Sternen|Blue-White-Blue with stars|Die Flagge zeigt fünf blaue Sterne auf weißem Streifen.|The flag shows five blue stars on the white stripe."
    ["nicaragua"]="Nicaragua|Nicaragua|North America|Blau-Weiß-Blau mit Wappen|Blue-White-Blue with coat of arms|Die Flagge zeigt das Wappen auf dem weißen Streifen.|The flag shows the coat of arms on the white stripe."
    ["el-salvador"]="El Salvador|El Salvador|North America|Blau-Weiß-Blau mit Wappen|Blue-White-Blue with coat of arms|Die Flagge zeigt das Wappen auf dem weißen Streifen.|The flag shows the coat of arms on the white stripe."
    ["cuba"]="Kuba|Cuba|North America|Rot-Weiß-Blau|Red-White-Blue|Die Flagge zeigt fünf Streifen und ein rotes Dreieck.|The flag shows five stripes and a red triangle."
    ["jamaica"]="Jamaika|Jamaica|North America|Grün-Schwarz-Gelb|Green-Black-Yellow|Die Flagge zeigt diagonale Streifen und ein X.|The flag shows diagonal stripes forming an X."
    ["haiti"]="Haiti|Haiti|North America|Blau-Rot mit Wappen|Blue-Red with coat of arms|Die Flagge zeigt das Wappen in der Mitte.|The flag shows the coat of arms in the center."
    ["dominican-republic"]="Dominikanische Republik|Dominican Republic|North America|Blau-Rot-Weiß mit Wappen|Blue-Red-White with coat of arms|Die Flagge zeigt ein Kreuz und Wappen.|The flag shows a cross and coat of arms."
    ["trinidad-tobago"]="Trinidad und Tobago|Trinidad and Tobago|North America|Rot-Schwarz-Weiß|Red-Black-White|Die Flagge zeigt ein schwarzes diagonales Band auf rotem Hintergrund.|The flag shows a black diagonal band on red background."
    ["bahamas"]="Bahamas|Bahamas|North America|Türkis-Gelb-Schwarz|Turquoise-Yellow-Black|Die Flagge zeigt horizontale Streifen und ein schwarzes Dreieck.|The flag shows horizontal stripes and a black triangle."
    ["barbados"]="Barbados|Barbados|North America|Blau-Gelb-Blau mit Dreizack|Blue-Yellow-Blue with trident|Die Flagge zeigt einen schwarzen Dreizack auf gelbem Streifen.|The flag shows a black trident on the yellow stripe."
    ["belize"]="Belize|Belize|North America|Blau-Weiß-Rot|Blue-White-Red|Die Flagge zeigt das Wappen auf einem blau-weißen Feld.|The flag shows the coat of arms on a blue-white field."
    ["guyana"]="Guyana|Guyana|South America|Grün-Rot-Gelb-Schwarz-Weiß|Green-Red-Yellow-Black-White|Die Flagge zeigt ein rotes Dreieck mit gelbem Rand auf grünem Feld.|The flag shows a red triangle with yellow border on green field."
    ["suriname"]="Suriname|Suriname|South America|Grün-Weiß-Rot mit gelbem Stern|Green-White-Red with yellow star|Die Flagge zeigt einen gelben Stern in der Mitte.|The flag shows a yellow star in the center."
    ["papua-new-guinea"]="Papua-Neuguinea|Papua New Guinea|Oceania|Schwarz-Rot mit Vogel|Black-Red with bird|Die Flagge zeigt den Vogel des Paradieses und Sterne.|The flag shows the bird of paradise and stars."
    ["fiji"]="Fidschi|Fiji|Oceania|Hellblau mit Wappen|Light Blue with coat of arms|Die Flagge zeigt das Wappen auf blauem Hintergrund.|The flag shows the coat of arms on blue background."
    ["solomon-islands"]="Salomonen|Solomon Islands|Oceania|Blau-Gelb-Grün mit Sternen|Blue-Yellow-Green with stars|Die Flagge zeigt gelbe diagonale Streifen mit Sternen.|The flag shows yellow diagonal stripes with stars."
    ["samoa"]="Samoa|Samoa|Oceania|Blau-Rot mit Sternen|Blue-Red with stars|Die Flagge zeigt vier Sterne im blauen Feld.|The flag shows four stars on the blue field."
    ["vanuatu"]="Vanuatu|Vanuatu|Oceania|Schwarz-Rot-Gelb-Grün|Black-Red-Yellow-Green|Die Flagge zeigt diagonale Streifen mit Emblem.|The flag shows diagonal stripes with emblem."
    ["tonga"]="Tonga|Tonga|Oceania|Rot-Weiß|Red-White|Die Flagge zeigt ein rotes Kreuz auf weißem Feld.|The flag shows a red cross on a white field."
    ["palau"]="Palau|Palau|Oceania|Hellblau mit gelber Sonne|Light Blue with yellow sun|Die Flagge zeigt eine gelbe Sonne auf blauem Hintergrund.|The flag shows a yellow sun on blue background."
    ["micronesia"]="Mikronesien|Micronesia|Oceania|Hellblau mit vier weißen Sternen|Light Blue with four white stars|Die Flagge zeigt vier weiße Sterne auf hellblauem Feld.|The flag shows four white stars on light blue field."
    ["burundi"]="Burundi|Burundi|Africa|Weiß-Rot-Grün mit drei Sternen|White-Red-Green with three stars|Die Flagge zeigt drei rote Sterne im Zentrum.|The flag shows three red stars in the center."
    ["central-african-republic"]="Zentralafrikanische Republik|Central African Republic|Africa|Blau-Weiß-Grün-Gelb-Rot mit Stern|Blue-White-Green-Yellow-Red with star|Die Flagge zeigt fünf Streifen und einen gelben Stern.|The flag shows five stripes and a yellow star."
    ["comoros"]="Komoren|Comoros|Africa|Gelb-Weiß-Rot-Blau-Grün|Yellow-White-Red-Blue-Green|Die Flagge zeigt vier Sterne und einen Halbmond.|The flag shows four stars and a crescent."
    ["djibouti"]="Dschibuti|Djibouti|Africa|Blau-Weiß-Grün mit rotem Dreieck|Blue-White-Green with red triangle|Die Flagge zeigt ein rotes Dreieck mit Stern.|The flag shows a red triangle with star."
    ["eritrea"]="Eritrea|Eritrea|Africa|Grün-Rot-Blau mit Emblem|Green-Red-Blue with emblem|Die Flagge zeigt ein gelbes Emblem auf rotem Dreieck.|The flag shows a yellow emblem on red triangle."
    ["eswatini"]="Eswatini|Eswatini|Africa|Blau-Gelb-Rot mit Schild|Blue-Yellow-Red with shield|Die Flagge zeigt einen traditionellen Schild und Speere.|The flag shows a traditional shield and spears."
    ["gambia"]="Gambia|Gambia|Africa|Rot-Blau-Grün mit Weiß|Red-Blue-Green with White|Die Flagge zeigt drei horizontale Streifen mit weißen Trennlinien.|The flag shows three horizontal stripes with white lines."
    ["guinea"]="Guinea|Guinea|Africa|Rot-Gelb-Grün|Red-Yellow-Green|Die Flagge besteht aus drei vertikalen Streifen.|The flag consists of three vertical stripes."
    ["guinea-bissau"]="Guinea-Bissau|Guinea-Bissau|Africa|Rot-Gelb-Grün mit schwarzem Stern|Red-Yellow-Green with black star|Die Flagge zeigt einen schwarzen Stern auf rotem Streifen.|The flag shows a black star on the red stripe."
    ["equatorial-guinea"]="Äquatorialguinea|Equatorial Guinea|Africa|Blau-Weiß-Grün-Rot mit Wappen|Blue-White-Green-Red with coat of arms|Die Flagge zeigt das Wappen in der Mitte.|The flag shows the coat of arms in the center."
    ["lesotho"]="Lesotho|Lesotho|Africa|Blau-Weiß-Grün mit Schild|Blue-White-Green with shield|Die Flagge zeigt einen schwarzen Schild in der Mitte.|The flag shows a black shield in the center."
    ["liberia"]="Liberia|Liberia|Africa|Rot-Weiß-Blau mit Stern|Red-White-Blue with star|Die Flagge zeigt einen weißen Stern auf blauem Feld.|The flag shows a white star on blue field."
    ["malawi"]="Malawi|Malawi|Africa|Schwarz-Rot-Grün|Black-Red-Green|Die Flagge zeigt eine rote Sonne auf schwarzem Streifen.|The flag shows a red sun on black stripe."
    ["mauritania"]="Mauretanien|Mauritania|Africa|Grün-Gelb-Rot|Green-Yellow-Red|Die Flagge zeigt einen Halbmond und Stern.|The flag shows a crescent and star."
    ["seychelles"]="Seychellen|Seychelles|Africa|Blau-Gelb-Rot-Weiß-Grün|Blue-Yellow-Red-White-Green|Die Flagge zeigt diagonale farbige Streifen.|The flag shows diagonal colored stripes."
    ["sierra-leone"]="Sierra Leone|Sierra Leone|Africa|Grün-Weiß-Blau|Green-White-Blue|Die Flagge besteht aus drei horizontalen Streifen.|The flag consists of three horizontal stripes."
    ["sao-tome-principe"]="São Tomé und Príncipe|São Tomé and Príncipe|Africa|Grün-Gelb-Rot mit Sternen|Green-Yellow-Red with stars|Die Flagge zeigt zwei schwarze Sterne im gelben Streifen.|The flag shows two black stars on the yellow stripe."
    ["cape-verde"]="Kap Verde|Cape Verde|Africa|Blau-Rot-Weiß mit Sternen|Blue-Red-White with stars|Die Flagge zeigt zehn gelbe Sterne in Kreisform.|The flag shows ten yellow stars in a circle."
    ["antigua-barbuda"]="Antigua und Barbuda|Antigua and Barbuda|North America|Schwarz-Blau-Weiß-Rot-Gelb|Black-Blue-White-Red-Yellow|Die Flagge zeigt Sonne, Dreiecke und Farben.|The flag shows sun, triangles, and colors."
    ["dominica"]="Dominica|Dominica|North America|Grün-Gelb-Schwarz-Rot mit Papagei|Green-Yellow-Black-Red with parrot|Die Flagge zeigt einen Papagei im Zentrum.|The flag shows a parrot in the center."
    ["grenada"]="Grenada|Grenada|North America|Rot-Gelb-Grün mit Stern und Muskatnuss|Red-Yellow-Green with star and nutmeg|Die Flagge zeigt Muskatnuss und Sterne.|The flag shows nutmeg and stars."
    ["saint-kitts-nevis"]="St. Kitts und Nevis|Saint Kitts and Nevis|North America|Grün-Schwarz-Rot-Gelb|Green-Black-Red-Yellow|Die Flagge zeigt diagonale Streifen mit Sternen.|The flag shows diagonal stripes with stars."
    ["saint-lucia"]="St. Lucia|Saint Lucia|North America|Blau-Schwarz-Gelb|Blue-Black-Yellow|Die Flagge zeigt ein schwarzes Dreieck auf blauem Feld.|The flag shows a black triangle on blue field."
    ["saint-vincent-grenadines"]="St. Vincent und die Grenadinen|Saint Vincent and the Grenadines|North America|Blau-Gelb-Grün|Blue-Yellow-Green|Die Flagge zeigt drei vertikale Streifen.|The flag shows three vertical stripes."
    ["kiribati"]="Kiribati|Kiribati|Oceania|Rot-Blau-Gelb|Red-Blue-Yellow|Die Flagge zeigt Sonne und Vogel über Wellen.|The flag shows sun and bird over waves."
    ["marshall-islands"]="Marshallinseln|Marshall Islands|Oceania|Blau-Orange-Weiß|Blue-Orange-White|Die Flagge zeigt diagonale Streifen mit Sonne.|The flag shows diagonal stripes with sun."
    ["nauru"]="Nauru|Nauru|Oceania|Blau-Gelb|Blue-Yellow|Die Flagge zeigt einen weißen Stern und gelbe Linie.|The flag shows a white star and yellow line."
    ["tuvalu"]="Tuvalu|Tuvalu|Oceania|Hellblau mit Sternen|Light Blue with stars|Die Flagge zeigt neun gelbe Sterne.|The flag shows nine yellow stars."
    ["macau"]="Macau|Macau|Asia|Grün mit Lotus und Brücke|Green with lotus and bridge|Die Flagge zeigt einen weißen Lotus und fünf Sterne.|The flag shows a white lotus and five stars."
)

# Template function
generate_country_page() {
    slug="$1"
    de_name="$2"
    en_name="$3"
    continent="$4"
    de_colors="$5"
    en_colors="$6"
    de_desc="$7"
    en_desc="$8"

    # ✅ FIXED: Korrekte Output-Location
    filename="de/countries/${slug}.html"
    
    cat > "$filename" <<'EOF_TEMPLATE'
<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>%%DE_NAME%% Flagge Quiz – %%DE_NAME%%flagge erraten | FlagGuess</title>
    <meta name="description" content="Lerne die %%DE_NAME%% Flagge kennen. %%DE_DESC%% Teste dein Wissen im kostenlosen Flaggen Quiz.">
    
    <script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-3654554314003005"
     crossorigin="anonymous"></script>

    <!-- Open Graph -->
    <meta property="og:title" content="%%DE_NAME%% Flagge | FlagGuess">
    <meta property="og:description" content="%%DE_DESC%%">
    <meta property="og:image" content="https://flaggues.pages.dev/assets/og-image.svg">
    <meta property="og:url" content="https://flaggues.pages.dev/de/countries/%%SLUG%%.html">
    
    <!-- Canonical -->
    <link rel="canonical" href="https://flaggues.pages.dev/de/countries/%%SLUG%%.html">
    
    <!-- Favicon -->
    <link rel="icon" type="image/svg+xml" href="/assets/favicon.svg">
    
    <!-- ✅ FIXED: Korrekte CSS Pfade -->
    <link rel="stylesheet" href="../../css/style.css">
    <link rel="stylesheet" href="../../css/library.css">
    <link rel="stylesheet" href="../../css/content-pages.css">
    
    <!-- Structured Data -->
    <script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@type": "WebPage",
      "name": "%%DE_NAME%% Flagge",
      "description": "%%DE_DESC%%",
      "breadcrumb": {
        "@type": "BreadcrumbList",
        "itemListElement": [{
          "@type": "ListItem",
          "position": 1,
          "name": "Home",
          "item": "https://flaggues.pages.dev/de/"
        }, {
          "@type": "ListItem",
          "position": 2,
          "name": "%%DE_NAME%% Flagge",
          "item": "https://flaggues.pages.dev/de/countries/%%SLUG%%.html"
        }]
      }
    }
    </script>
</head>
<body data-theme="dark">
    <div class="container">
        <header>
            <nav class="main-nav">
                <a href="../index.html" class="nav-logo">🎯 FlagGuess</a>
                <div class="nav-links">
                    <a href="../index.html">Quiz</a>
                    <a href="../../library.html">Bibliothek</a>
                </div>
            </nav>
        </header>

        <main class="content-page">
            <div class="page-hero">
                <h1>🚩 %%DE_NAME%% Flagge</h1>
                <p class="hero-subtitle">Lerne alles über die %%DE_NAME%%flagge – Farben, Bedeutung und Geschichte</p>
            </div>

            <div class="content-wrapper">
                <section class="seo-content">
                    <h2>Die %%DE_NAME%% Flagge – Übersicht</h2>
                    <p>%%DE_DESC%% Die <strong>%%DE_NAME%% Flagge</strong> gehört zu %%CONTINENT%% und ist ein wichtiges Nationalsymbol des Landes.</p>
                    
                    <h3>Farben der %%DE_NAME%% Flagge</h3>
                    <p>Die Hauptfarben der <strong>%%DE_NAME%%flagge</strong> sind: <strong>%%DE_COLORS%%</strong></p>
                    
                    <h3>%%DE_NAME%% Flagge im Quiz</h3>
                    <p>Kannst du die %%DE_NAME%% Flagge im Quiz erkennen? Teste dein Wissen über die <strong>%%DE_NAME%%flagge</strong> in unserem kostenlosen <strong>Flaggen Quiz</strong>. Die %%DE_NAME%% Flagge ist eine der bekanntesten Flaggen aus %%CONTINENT%%.</p>
                    
                    <h3>Warum die %%DE_NAME%% Flagge lernen?</h3>
                    <ul>
                        <li><strong>Geografie-Wissen:</strong> Lerne %%DE_NAME%% und seine Position in %%CONTINENT%% kennen</li>
                        <li><strong>Quiz-Vorbereitung:</strong> Die %%DE_NAME%% Flagge ist ein Klassiker in jedem Flaggen Quiz</li>
                        <li><strong>Allgemeinbildung:</strong> Wichtiges Grundwissen über %%DE_NAME%%</li>
                        <li><strong>Reisevorbereitung:</strong> Perfekt wenn du nach %%DE_NAME%% reisen möchtest</li>
                    </ul>

                    <h3>Interessante Fakten zur %%DE_NAME%% Flagge</h3>
                    <p>Die <strong>%%DE_NAME%% Flagge</strong> ist nicht nur ein Symbol für %%DE_NAME%%, sondern auch ein Zeugnis der Geschichte und Kultur des Landes. Jede Farbe und jedes Symbol auf der %%DE_NAME%%flagge hat eine besondere Bedeutung.</p>

                    <div class="cta-box">
                        <h3>Bereit die %%DE_NAME%% Flagge im Quiz zu erraten?</h3>
                        <p>Teste dein Wissen über die %%DE_NAME%% Flagge und über 190 weitere Länderflaggen!</p>
                        <a href="../index.html" class="cta-button">🚩 Quiz starten</a>
                    </div>

                    <h3>Häufig gestellte Fragen zur %%DE_NAME%% Flagge</h3>
                    <div class="faq">
                        <div class="faq-item">
                            <h4>Wie sieht die %%DE_NAME%% Flagge aus?</h4>
                            <p>%%DE_DESC%%</p>
                        </div>
                        <div class="faq-item">
                            <h4>Welche Farben hat die %%DE_NAME%% Flagge?</h4>
                            <p>Die %%DE_NAME%% Flagge hat die Farben: %%DE_COLORS%%.</p>
                        </div>
                        <div class="faq-item">
                            <h4>Wo liegt %%DE_NAME%%?</h4>
                            <p>%%DE_NAME%% liegt in %%CONTINENT%%.</p>
                        </div>
                        <div class="faq-item">
                            <h4>Wie schwer ist die %%DE_NAME%% Flagge im Quiz?</h4>
                            <p>Die %%DE_NAME%% Flagge ist eine bekannte Flagge und eignet sich gut für Anfänger und Fortgeschrittene im Flaggen Quiz.</p>
                        </div>
                    </div>

                    <h3>Mehr über %%DE_NAME%% lernen</h3>
                    <p>Die <strong>%%DE_NAME%% Flagge</strong> ist nur der Anfang. In unserem Flaggen Quiz kannst du auch die Geografie, Hauptstadt und weitere Fakten über %%DE_NAME%% lernen. Die %%DE_NAME%%flagge ist ein wichtiger Teil der nationalen Identität und Geschichte des Landes.</p>
                </section>

                <aside class="related-pages">
                    <h3>Mehr Flaggen</h3>
                    <div class="continent-grid">
                        <a href="../../library.html" class="continent-card">
                            <span class="continent-icon">📚</span>
                            <h4>Alle Flaggen</h4>
                            <p>195+ Länder</p>
                        </a>
                        <a href="../easy-flags.html" class="continent-card">
                            <span class="continent-icon">🟢</span>
                            <h4>Einfache Flaggen</h4>
                            <p>Top 20 zum Start</p>
                        </a>
                        <a href="../hardest-flags.html" class="continent-card">
                            <span class="continent-icon">🔥</span>
                            <h4>Schwerste Flaggen</h4>
                            <p>Ultimative Challenge</p>
                        </a>
                        <a href="../similar-flags.html" class="continent-card">
                            <span class="continent-icon">👯</span>
                            <h4>Ähnliche Flaggen</h4>
                            <p>Verwechslungsgefahr</p>
                        </a>
                    </div>
                </aside>
            </div>
        </main>

        <footer class="footer">
            <div class="footer-content">
                <p>&copy; 2026 FlagGuess. Dein Einstieg in die Welt der Flaggen!</p>
                <div class="footer-links">
                    <a href="index.html"  class="footer-link">Quiz spielen</a>
                    <a href="../library.html" class="footer-link">Flaggen Bibliothek</a>
                    <a href="../hardest-flags.html" class="footer-link">Schwerste Flaggen</a>
                    <a href="../similar-flags.html" class="footer-link">Ähnliche Flaggen</a>
                    <a href="../impressum.html" class="footer-link">Impressum</a>
                    <a href="../datenschutz.html" class="footer-link">Datenschutz</a>
                </div>
            </div>
        </footer>
    </div>
</body>
</html>
EOF_TEMPLATE

    # Replace placeholders
    sed -i.bak \
        -e "s|%%SLUG%%|${slug}|g" \
        -e "s|%%DE_NAME%%|${de_name}|g" \
        -e "s|%%EN_NAME%%|${en_name}|g" \
        -e "s|%%CONTINENT%%|${continent}|g" \
        -e "s|%%DE_COLORS%%|${de_colors}|g" \
        -e "s|%%EN_COLORS%%|${en_colors}|g" \
        -e "s|%%DE_DESC%%|${de_desc}|g" \
        -e "s|%%EN_DESC%%|${en_desc}|g" \
        "$filename"
    
    rm -f "${filename}.bak"
    
    echo "  ✅ Created: $filename"
}

# Generate pages for all countries
count=0
for slug in "${!COUNTRIES[@]}"; do
    country_data="${COUNTRIES[$slug]}"
    country_data=$(printf '%s' "$country_data" | tr '\n' ' ')
    IFS='|' read -r de_name en_name continent de_colors en_colors de_desc en_desc <<< "$country_data"
    generate_country_page "$slug" "$de_name" "$en_name" "$continent" "$de_colors" "$en_colors" "$de_desc" "$en_desc"
    ((count++))
done

echo ""
echo "✅ Generated $count German country pages successfully!"
echo "📍 Location: de/countries/"
echo ""
echo "💡 Next: Run generate-encountry-pages-FIXED.sh for English pages"
