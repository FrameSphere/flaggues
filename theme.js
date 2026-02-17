// Theme Management
class ThemeManager {
    constructor() {
        this.currentTheme = this.getInitialTheme();
        this.init();
    }

    getInitialTheme() {
        const saved = localStorage.getItem('flagguess-theme');
        return saved || 'dark'; // Dark als Standard
    }

    init() {
        this.setTheme(this.currentTheme, false);
        
        const toggle = document.getElementById('themeToggle');
        if (toggle) {
            toggle.addEventListener('click', () => this.toggleTheme());
        }
    }

    setTheme(theme, animate = true) {
        this.currentTheme = theme;
        document.body.setAttribute('data-theme', theme);
        localStorage.setItem('flagguess-theme', theme);
        
        if (animate) {
            document.body.style.transition = 'background-color 0.3s ease, color 0.3s ease';
        }
    }

    toggleTheme() {
        const newTheme = this.currentTheme === 'dark' ? 'light' : 'dark';
        this.setTheme(newTheme);
    }
}

// Initialisierung
let themeManager;
document.addEventListener('DOMContentLoaded', () => {
    themeManager = new ThemeManager();
});
