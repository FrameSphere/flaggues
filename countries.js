// Liste der Länder mit ihren ISO-Codes für Flaggen-URLs
const COUNTRIES = [
    { name: "Deutschland", code: "de" },
    { name: "Frankreich", code: "fr" },
    { name: "Italien", code: "it" },
    { name: "Spanien", code: "es" },
    { name: "Portugal", code: "pt" },
    { name: "Niederlande", code: "nl" },
    { name: "Belgien", code: "be" },
    { name: "Österreich", code: "at" },
    { name: "Schweiz", code: "ch" },
    { name: "Polen", code: "pl" },
    { name: "Tschechien", code: "cz" },
    { name: "Ungarn", code: "hu" },
    { name: "Rumänien", code: "ro" },
    { name: "Bulgarien", code: "bg" },
    { name: "Griechenland", code: "gr" },
    { name: "Schweden", code: "se" },
    { name: "Norwegen", code: "no" },
    { name: "Dänemark", code: "dk" },
    { name: "Finnland", code: "fi" },
    { name: "Island", code: "is" },
    { name: "Irland", code: "ie" },
    { name: "Großbritannien", code: "gb" },
    { name: "Kroatien", code: "hr" },
    { name: "Slowenien", code: "si" },
    { name: "Slowakei", code: "sk" },
    { name: "Serbien", code: "rs" },
    { name: "Ukraine", code: "ua" },
    { name: "Russland", code: "ru" },
    { name: "USA", code: "us" },
    { name: "Kanada", code: "ca" },
    { name: "Mexiko", code: "mx" },
    { name: "Brasilien", code: "br" },
    { name: "Argentinien", code: "ar" },
    { name: "Chile", code: "cl" },
    { name: "Kolumbien", code: "co" },
    { name: "Peru", code: "pe" },
    { name: "Venezuela", code: "ve" },
    { name: "China", code: "cn" },
    { name: "Japan", code: "jp" },
    { name: "Südkorea", code: "kr" },
    { name: "Indien", code: "in" },
    { name: "Thailand", code: "th" },
    { name: "Vietnam", code: "vn" },
    { name: "Indonesien", code: "id" },
    { name: "Malaysia", code: "my" },
    { name: "Philippinen", code: "ph" },
    { name: "Singapur", code: "sg" },
    { name: "Australien", code: "au" },
    { name: "Neuseeland", code: "nz" },
    { name: "Südafrika", code: "za" },
    { name: "Ägypten", code: "eg" },
    { name: "Marokko", code: "ma" },
    { name: "Nigeria", code: "ng" },
    { name: "Kenia", code: "ke" },
    { name: "Türkei", code: "tr" },
    { name: "Israel", code: "il" },
    { name: "Saudi-Arabien", code: "sa" },
    { name: "Vereinigte Arabische Emirate", code: "ae" },
    { name: "Katar", code: "qa" },
    { name: "Estland", code: "ee" },
    { name: "Lettland", code: "lv" },
    { name: "Litauen", code: "lt" },
    { name: "Luxemburg", code: "lu" },
    { name: "Monaco", code: "mc" },
    { name: "Malta", code: "mt" },
    { name: "Zypern", code: "cy" },
    { name: "Albanien", code: "al" },
    { name: "Nordmazedonien", code: "mk" },
    { name: "Bosnien und Herzegowina", code: "ba" },
    { name: "Montenegro", code: "me" },
    { name: "Kosovo", code: "xk" }
];

// Funktion um Flaggen-URL zu generieren
function getFlagUrl(countryCode) {
    return `https://flagcdn.com/w640/${countryCode}.png`;
}

// Funktion um Land nach Namen zu finden
function findCountryByName(name) {
    const normalized = name.toLowerCase().trim();
    return COUNTRIES.find(c => c.name.toLowerCase() === normalized);
}

// Autocomplete-Datenliste füllen
function populateDatalist() {
    const datalist = document.getElementById('countries');
    COUNTRIES.forEach(country => {
        const option = document.createElement('option');
        option.value = country.name;
        datalist.appendChild(option);
    });
}

// Zufälliges Land auswählen
function getRandomCountry() {
    return COUNTRIES[Math.floor(Math.random() * COUNTRIES.length)];
}
