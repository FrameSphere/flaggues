// ============================================
// LANGUAGE ROUTING SYSTEM
// ============================================

class LanguageRouter {
    constructor() {
        this.currentLang = this.detectLanguage();
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
    }

    // Erkennt aktuelle Sprache
    detectLanguage() {
        // 1. Prüfe URL-Pfad
        const path = window.location.pathname;
        if (path.includes('/de/')) return 'de';
        if (path.includes('/en/')) return 'en';

        // 2. Prüfe localStorage
        const saved = localStorage.getItem('flagguess-language');
        if (saved === 'de' || saved === 'en') return saved;

        // 3. Prüfe Browser-Sprache
        const browserLang = navigator.language.substring(0, 2);
        if (browserLang === 'de') return 'de';

        // 4. Default: Deutsch
        return 'de';
    }

    // Speichert Sprach-Präferenz
    setLanguage(lang) {
        if (lang !== 'de' && lang !== 'en') {
            console.error('Invalid language:', lang);
            return;
        }
        
        this.currentLang = lang;
        localStorage.setItem('flagguess-language', lang);
        
        // Dispatch Event für andere Scripts
        window.dispatchEvent(new CustomEvent('languageChanged', { 
            detail: { language: lang } 
        }));
    }

    // Gibt aktuelle Sprache zurück
    getLanguage() {
        return this.currentLang;
    }

    // Konvertiert Root-Links zu Sprach-Links
    getLocalizedPath(path) {
        // Entferne führende Slashes
        path = path.replace(/^\/+/, '');

        // Prüfe ob es eine Content-Seite ist
        const isContentPage = this.contentPages.some(page => 
            path.includes(page) || path.endsWith(page)
        );

        if (!isContentPage) {
            // Root-Seiten (index.html, library.html, etc.)
            return '/' + path;
        }

        // Content-Seiten → mit Sprach-Prefix
        const fileName = this.contentPages.find(page => path.includes(page));
        return `/${this.currentLang}/${fileName}`;
    }

    // Initialisiert Routing auf Content-Seiten
    initContentPageRouting() {
        // Prüfe ob wir auf einer Content-Seite sind
        const path = window.location.pathname;
        const isInLangFolder = path.includes('/de/') || path.includes('/en/');
        
        if (!isInLangFolder) return;

        // Update alle internen Links
        document.addEventListener('DOMContentLoaded', () => {
            this.updateAllLinks();
        });
    }

    // Updated alle Links auf der Seite
    updateAllLinks() {
        const links = document.querySelectorAll('a[href]');
        
        links.forEach(link => {
            const href = link.getAttribute('href');
            
            // Skip externe Links, Anker, mailto, tel
            if (!href || 
                href.startsWith('http') || 
                href.startsWith('#') || 
                href.startsWith('mailto:') || 
                href.startsWith('tel:')) {
                return;
            }

            // Skip wenn Link schon korrekt ist
            if (href.includes('/de/') || href.includes('/en/')) {
                return;
            }

            // Prüfe ob es eine Content-Seite ist
            const isContentPage = this.contentPages.some(page => 
                href.includes(page)
            );

            if (isContentPage) {
                // Extrahiere Dateiname
                const fileName = this.contentPages.find(page => 
                    href.includes(page)
                );
                
                // Setze korrekten Pfad basierend auf aktueller Position
                const currentPath = window.location.pathname;
                if (currentPath.includes('/de/') || currentPath.includes('/en/')) {
                    // Wir sind in einem Sprach-Ordner → relativer Link
                    link.setAttribute('href', fileName);
                } else {
                    // Wir sind auf Root → absoluter Link
                    link.setAttribute('href', `/${this.currentLang}/${fileName}`);
                }
            }
        });
    }

    // Language Switcher für Root-Seiten
    createLanguageSwitcher(containerId) {
        const container = document.getElementById(containerId);
        if (!container) return;

        const html = `
            <div class="language-switcher">
                <button class="lang-btn ${this.currentLang === 'de' ? 'active' : ''}" 
                        data-lang="de">🇩🇪 DE</button>
                <button class="lang-btn ${this.currentLang === 'en' ? 'active' : ''}" 
                        data-lang="en">🇬🇧 EN</button>
            </div>
        `;

        container.innerHTML = html;

        // Event Listeners
        container.querySelectorAll('.lang-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                const newLang = e.target.dataset.lang;
                this.switchLanguage(newLang);
            });
        });
    }

    // Sprachwechsel mit Reload
    switchLanguage(newLang) {
        if (newLang === this.currentLang) return;

        this.setLanguage(newLang);
        
        // Wenn auf Content-Seite → zur neuen Sprach-Version
        const path = window.location.pathname;
        const currentFile = path.split('/').pop();
        
        if (this.contentPages.includes(currentFile)) {
            window.location.href = `/${newLang}/${currentFile}`;
        } else {
            // Root-Seite → einfach neu laden
            window.location.reload();
        }
    }
}

// Globale Instanz
window.languageRouter = new LanguageRouter();

// Auto-Init für Content-Seiten
window.languageRouter.initContentPageRouting();