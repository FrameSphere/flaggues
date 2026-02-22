// Übersetzungen für die Library-Seite
const LIBRARY_TRANSLATIONS = {
    de: {
        // Header
        subtitle: "Entdecke alle Flaggen der Welt",
        backToGame: "Zurück zum Spiel",
        searchPlaceholder: "Suche nach Land oder Kontinent...",
        
        // Stats
        totalCountriesLabel: "Länder insgesamt",
        continentsLabel: "Kontinente",
        displayedLabel: "Angezeigt",

        // Info
        infoText: "Klicke auf eine Länder Karte um mehr Informationen über dieses Land zu erhalten!",
        
        // Filter
        filterTitle: "Filtern nach Kontinent",
        filterAll: "Alle",
        filterEurope: "Europa",
        filterAsia: "Asien",
        filterAfrica: "Afrika",
        filterAmericas: "Amerika",
        filterOceania: "Ozeanien",
        
        // Card Details
        continentLabel: "Kontinent:",
        capitalLabel: "Hauptstadt:",
        populationLabel: "Bevölkerung:",
        
        // No Results
        noResultsText: "Keine Länder gefunden",
        noResultsHint: "Versuche eine andere Suche oder wähle einen anderen Kontinent",
        
        // Footer
        backToGameFooter: "Zurück zum Spiel",
        imprint: "Impressum",
        privacy: "Datenschutz"
    },
    en: {
        // Header
        subtitle: "Discover all flags of the world",
        backToGame: "Back to Game",
        searchPlaceholder: "Search for country or continent...",
        
        // Stats
        totalCountriesLabel: "Total Countries",
        continentsLabel: "Continents",
        displayedLabel: "Displayed",

        // Info
        infoText: "Click on any country card to get more informations about this country!",
        
        // Filter
        filterTitle: "Filter by Continent",
        filterAll: "All",
        filterEurope: "Europe",
        filterAsia: "Asia",
        filterAfrica: "Africa",
        filterAmericas: "Americas",
        filterOceania: "Oceania",
        
        // Card Details
        continentLabel: "Continent:",
        capitalLabel: "Capital:",
        populationLabel: "Population:",
        
        // No Results
        noResultsText: "No countries found",
        noResultsHint: "Try a different search or select another continent",
        
        // Footer
        backToGameFooter: "Back to Game",
        imprint: "Imprint",
        privacy: "Privacy"
    }
};

// Sprachverwaltung für Library
class LibraryLanguageManager {
    constructor() {
        this.currentLang = this.getInitialLanguage();
    }

    getInitialLanguage() {
        const saved = localStorage.getItem('flagguess-language');
        if (saved && LIBRARY_TRANSLATIONS[saved]) return saved;
        
        const browser = navigator.language.split('-')[0];
        return LIBRARY_TRANSLATIONS[browser] ? browser : 'de';
    }

    setLanguage(lang) {
        if (!LIBRARY_TRANSLATIONS[lang]) return;
        this.currentLang = lang;
        localStorage.setItem('flagguess-language', lang);
        this.updatePage();
    }

    get(key) {
        return LIBRARY_TRANSLATIONS[this.currentLang][key] || key;
    }

    updatePage() {
        // UI-Elemente aktualisieren
        this.updateElement('subtitle');
        this.updateElement('backToGame');
        this.updateElement('totalCountriesLabel');
        this.updateElement('continentsLabel');
        this.updateElement('displayedLabel');
        this.updateElement('filterTitle');
        this.updateElement('backToGameFooter');
        this.updateElement('infoText');
        
        // Filter Buttons
        document.getElementById('filterAll').innerHTML = `🌍 ${this.get('filterAll')}`;
        document.getElementById('filterEurope').innerHTML = `🇪🇺 ${this.get('filterEurope')}`;
        document.getElementById('filterAsia').innerHTML = `🌏 ${this.get('filterAsia')}`;
        document.getElementById('filterAfrica').innerHTML = `🌍 ${this.get('filterAfrica')}`;
        document.getElementById('filterAmericas').innerHTML = `🌎 ${this.get('filterAmericas')}`;
        document.getElementById('filterOceania').innerHTML = `🌊 ${this.get('filterOceania')}`;
        
        // Search Placeholder
        const searchInput = document.getElementById('searchInput');
        if (searchInput) searchInput.placeholder = this.get('searchPlaceholder');
        
        // Language Select
        const langSelect = document.getElementById('languageSelect');
        if (langSelect) langSelect.value = this.currentLang;
        
        // Footer Links
        const footerLinks = document.querySelectorAll('.footer-links a');
        if (footerLinks[0]) footerLinks[0].textContent = this.get('backToGameFooter');
        if (footerLinks[1]) footerLinks[1].textContent = this.get('imprint');
        if (footerLinks[2]) footerLinks[2].textContent = this.get('privacy');
    }

    updateElement(id, key = null) {
        const el = document.getElementById(id);
        if (el) el.textContent = this.get(key || id);
    }

    getContinentName(continentKey) {
        return CONTINENTS[continentKey]?.[this.currentLang] || continentKey;
    }
}

// Globale Instanz
let libraryLangManager;
