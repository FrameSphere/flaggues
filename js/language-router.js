// ============================================
// SIMPLIFIED LANGUAGE ROUTING SYSTEM
// Works with /de/index.html and /en/index.html
// ============================================

class LanguageRouter {
    constructor() {
        this.currentLang = this.detectLanguage();
        this.init();
    }

    // Detect current language from URL
    detectLanguage() {
        const path = window.location.pathname;
        
        // Check if URL contains /de/ or /en/
        if (path.includes('/de/')) return 'de';
        if (path.includes('/en/')) return 'en';

        // Check localStorage
        const saved = localStorage.getItem('flagguess-language');
        if (saved === 'de' || saved === 'en') return saved;

        // Check browser language
        const browserLang = navigator.language.substring(0, 2);
        return browserLang === 'de' ? 'de' : 'en';
    }

    // Save language preference
    setLanguage(lang) {
        if (lang !== 'de' && lang !== 'en') {
            console.error('[LanguageRouter] Invalid language:', lang);
            return;
        }
        
        this.currentLang = lang;
        localStorage.setItem('flagguess-language', lang);
        console.log('[LanguageRouter] Language set to:', lang);
    }

    // Get current language
    getLanguage() {
        return this.currentLang;
    }

    // Initialize
    init() {
        document.addEventListener('DOMContentLoaded', () => {
            this.syncLanguageSelect();
        });
    }

    // Sync language select to current language (no event listener - translations.js handles that)
    syncLanguageSelect() {
        const langSelect = document.getElementById('languageSelect');
        if (!langSelect) return;

        // Set current value based on URL
        langSelect.value = this.currentLang;
        
        console.log('[LanguageRouter] Language select synced to:', this.currentLang);
    }

    // Handle language change (called by translations.js)
    handleLanguageChange(newLang) {
        if (newLang === this.currentLang) {
            console.log('[LanguageRouter] Already on language:', newLang);
            return;
        }

        // Save new language
        this.setLanguage(newLang);
        
        // Get current path
        const path = window.location.pathname;
        
        // Determine new path
        let newPath;
        
        if (path.includes('/de/')) {
            // We're on a DE page → switch to EN
            newPath = path.replace('/de/', '/en/');
        } else if (path.includes('/en/')) {
            // We're on an EN page → switch to DE
            newPath = path.replace('/en/', '/de/');
        } else {
            // We're on root or other page → go to language root
            newPath = `/${newLang}/`;
        }
        
        console.log('[LanguageRouter] Navigating from', path, 'to', newPath);
        
        // Use replace to avoid back button issues
        window.location.replace(newPath);
    }

    // Check if currently on a localized page
    isOnLocalizedPage() {
        const path = window.location.pathname;
        return path.includes('/de/') || path.includes('/en/');
    }
}

// Create global instance
window.languageRouter = new LanguageRouter();

// Debug info
console.log('[LanguageRouter] Initialized');
console.log('[LanguageRouter] Current language:', window.languageRouter.getLanguage());
console.log('[LanguageRouter] Current path:', window.location.pathname);
