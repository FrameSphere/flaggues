// ============================================
// INTEGRIERTES LANGUAGE ROUTING SYSTEM
// Arbeitet zusammen mit translations.js
// ============================================

class LanguageRouter {
    constructor() {
        this.currentLang = this.detectLanguage();
        
        // Content-Seiten die in /de/ und /en/ liegen
        this.contentPages = [
            'easy-flags.html',
            'hardest-flags.html',
            'similar-flags.html',
            'flags-of-europe.html',
            'flags-of-asia.html',
            'flags-of-africa.html',
            'flags-of-americas.html',
            'flags-of-oceania.html'
        ];
        
        // Auto-Init
        this.init();
    }

    // Erkennt aktuelle Sprache (identisch mit translations.js)
    detectLanguage() {
        // 1. Prüfe URL-Pfad
        const path = window.location.pathname;
        if (path.includes('/de/')) return 'de';
        if (path.includes('/en/')) return 'en';

        // 2. Prüfe localStorage (gleicher Key wie translations.js!)
        const saved = localStorage.getItem('flagguess-language');
        if (saved === 'de' || saved === 'en') return saved;

        // 3. Prüfe Browser-Sprache
        const browserLang = navigator.language.substring(0, 2);
        if (browserLang === 'de') return 'de';

        // 4. Default: Deutsch
        return 'de';
    }

    // Speichert Sprach-Präferenz (synchronisiert mit translations.js)
    setLanguage(lang) {
        if (lang !== 'de' && lang !== 'en') {
            console.error('[LanguageRouter] Invalid language:', lang);
            return;
        }
        
        this.currentLang = lang;
        localStorage.setItem('flagguess-language', lang);
        
        console.log('[LanguageRouter] Language set to:', lang);
    }

    // Gibt aktuelle Sprache zurück
    getLanguage() {
        return this.currentLang;
    }

    // Initialisierung
    init() {
        const path = window.location.pathname;
        const isContentPage = this.contentPages.some(page => path.includes(page));
        const isRootPage = path === '/' || path.includes('index.html') || path.includes('library.html');
        
        if (isRootPage) {
            // Root-Seite: Update Links dynamisch
            document.addEventListener('DOMContentLoaded', () => {
                this.updateContentLinks();
                this.setupLanguageSelectListener();
            });
        } else if (isContentPage) {
            // Content-Seite: Nur Language Select Listener
            document.addEventListener('DOMContentLoaded', () => {
                this.setupLanguageSelectListener();
            });
        }
    }

    // Updated alle Links zu Content-Seiten auf Root-Seiten
    updateContentLinks() {
        const links = document.querySelectorAll('a[href]');
        
        links.forEach(link => {
            const href = link.getAttribute('href');
            
            // Prüfe ob Link zu einer Content-Seite geht
            const isContentPageLink = this.contentPages.some(page => {
                // Match sowohl "de/page.html" als auch "page.html"
                return href.includes(page) || href.endsWith(page);
            });
            
            if (isContentPageLink) {
                // Extrahiere Dateiname
                const fileName = this.contentPages.find(page => href.includes(page));
                
                // Setze Pfad basierend auf aktueller Sprache
                const newHref = `${this.currentLang}/${fileName}`;
                link.setAttribute('href', newHref);
                
                console.log('[LanguageRouter] Updated link:', href, '→', newHref);
            }
        });
    }

    // Setup Language Select Event Listener
    setupLanguageSelectListener() {
        const langSelect = document.getElementById('languageSelect');
        if (!langSelect) return;

        // Setze aktuellen Wert
        langSelect.value = this.currentLang;

        // Event Listener (zusätzlich zu translations.js)
        langSelect.addEventListener('change', (e) => {
            const newLang = e.target.value;
            this.handleLanguageChange(newLang);
        });
        
        console.log('[LanguageRouter] Language select initialized');
    }

    // Sprachwechsel Handler
    handleLanguageChange(newLang) {
        if (newLang === this.currentLang) return;

        const path = window.location.pathname;
        const currentFile = path.split('/').pop();
        
        // Speichere neue Sprache
        this.setLanguage(newLang);
        
        // Prüfe ob wir auf Content-Seite sind
        if (this.contentPages.includes(currentFile)) {
            // Content-Seite: Zur anderen Sprach-Version navigieren
            const newPath = `/${newLang}/${currentFile}`;
            console.log('[LanguageRouter] Navigating to:', newPath);
            window.location.href = newPath;
        } else {
            // Root-Seite: Links updaten (translations.js kümmert sich um Texte)
            this.updateContentLinks();
            console.log('[LanguageRouter] Updated content links for language:', newLang);
        }
    }

    // Hilfsfunktion: Ist aktuelle Seite eine Content-Seite?
    isOnContentPage() {
        const path = window.location.pathname;
        return this.contentPages.some(page => path.includes(page));
    }

    // Hilfsfunktion: Gibt Pfad zur Content-Seite in aktueller Sprache
    getContentPagePath(fileName) {
        if (!this.contentPages.includes(fileName)) {
            console.warn('[LanguageRouter] Not a content page:', fileName);
            return fileName;
        }
        return `/${this.currentLang}/${fileName}`;
    }
}

// Globale Instanz erstellen
window.languageRouter = new LanguageRouter();

// Debug Info
console.log('[LanguageRouter] Initialized with language:', window.languageRouter.getLanguage());
console.log('[LanguageRouter] Current path:', window.location.pathname);
