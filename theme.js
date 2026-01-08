// Theme Management
class ThemeManager {
    constructor() {
        this.themeToggle = document.getElementById('themeToggle');
        this.currentTheme = this.getInitialTheme();
        this.init();
    }

    getInitialTheme() {
        // Prüfe localStorage, Standard ist dark
        const savedTheme = localStorage.getItem('flagguess-theme');
        return savedTheme || 'dark';
    }

    init() {
        // Theme setzen
        this.setTheme(this.currentTheme, false);

        // Event Listener für Toggle Button
        this.themeToggle.addEventListener('click', () => {
            this.toggleTheme();
        });
    }

    setTheme(theme, animate = true) {
        this.currentTheme = theme;
        document.body.setAttribute('data-theme', theme);
        localStorage.setItem('flagguess-theme', theme);

        // Animation für Übergang
        if (animate) {
            document.body.style.transition = 'background-color 0.3s ease, color 0.3s ease';
        }
    }

    toggleTheme() {
        const newTheme = this.currentTheme === 'dark' ? 'light' : 'dark';
        this.setTheme(newTheme);
    }

    getTheme() {
        return this.currentTheme;
    }
}

// Theme Manager initialisieren wenn DOM geladen ist
let themeManager;
document.addEventListener('DOMContentLoaded', () => {
    themeManager = new ThemeManager();
});
