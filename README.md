# FlagGuess - Professionelles Flaggen-Ratespiel

Ein hochmodernes, interaktives Ratespiel mit Dark/Light Mode, bei dem Spieler eine Flagge durch intelligente Pixel-Überlagerung in maximal 5 Versuchen erraten müssen.

## 🎮 Spielprinzip

1. **Ziel**: Errate die versteckte Flagge in maximal 5 Versuchen
2. **Mechanik**: 
   - Am Anfang ist das Spielfeld leer (weiß)
   - Bei jedem Rateversuch wird die geratene Flagge mit der Zielflagge verglichen
   - Nur Pixel, die exakt übereinstimmen, werden im Spielfeld angezeigt
   - Nach jedem Versuch werden mehr Teile der Flagge sichtbar
3. **Gewinn**: Richtige Flagge erraten oder nach 5 Versuchen die Auflösung sehen

## ✨ Features

### 🎨 Design & UI
- **Professionelles Design** mit modernem, minimalistischem Interface
- **Dark/Light Mode Toggle** - Wechsel zwischen hellem und dunklem Theme
- **Dark Mode als Standard** - Startet automatisch im Dark Mode
- **Theme-Persistenz** - Ihre Theme-Wahl wird gespeichert
- **Vollständig Responsive** - Optimiert für Desktop, Tablet und Mobile
- **Smooth Animations** - Flüssige Übergänge und Hover-Effekte

### 🎯 Gameplay
- **70+ Länder** zur Auswahl
- **Intelligente Autocomplete-Eingabe** mit Länderliste
- **Pixel-genaue Überlagerung** für faire Hinweise
- **Visuelle Feedback-Systeme** mit Notifications
- **Versuchszähler** mit klarem Progress-Tracking
- **Vollständige Modal-Anzeige** am Spielende

### 🔧 Technisch
- **Canvas-basierte Bildverarbeitung** für präzise Pixel-Vergleiche
- **CORS-kompatible Flaggen** von flagcdn.com
- **LocalStorage für Theme** - Theme-Präferenz bleibt erhalten
- **Optimierte Performance** mit willReadFrequently Canvas-Kontext
- **Error Handling** für Netzwerkfehler

## 🚀 Deployment auf Cloudflare Pages

### Voraussetzungen
- Cloudflare Account (kostenlos)
- Git Repository (GitHub, GitLab, etc.)

### Setup-Schritte

1. **Repository erstellen & pushen**
   ```bash
   cd /Users/karol/Desktop/Laufende_Projekte/WerbungWebseites/flagguess
   git init
   git add .
   git commit -m "Initial commit: FlagGuess mit Dark/Light Mode"
   git branch -M main
   git remote add origin <your-repo-url>
   git push -u origin main
   ```

2. **Cloudflare Pages einrichten**
   - Gehe zu [Cloudflare Dashboard](https://dash.cloudflare.com) → Pages
   - Klicke auf "Create a project"
   - Verbinde dein Git-Repository
   - **Build-Einstellungen:**
     - Framework preset: `None`
     - Build command: (leer lassen)
     - Build output directory: `/`
     - Root directory: (leer lassen oder vollständiger Pfad)
   - Klicke auf "Save and Deploy"

3. **Custom Domain (Optional)**
   - In Cloudflare Pages → Custom domains
   - Füge deine eigene Domain hinzu
   - DNS wird automatisch konfiguriert

4. **Fertig! 🎉**
   - Deine App ist jetzt unter `https://dein-projekt.pages.dev` live
   - Automatisches Deployment bei jedem Git Push

## 📁 Dateistruktur

```
flagguess/
├── index.html      # Haupt-HTML mit Canvas, Theme-Toggle & UI
├── style.css       # CSS mit Dark/Light Mode Variablen
├── theme.js        # Theme-Management mit LocalStorage
├── countries.js    # Länderdatenbank (70+ Länder)
├── game.js         # Spiellogik mit Pixel-Vergleich
└── README.md       # Diese Datei
```

## 🎨 Theme System

### Dark Mode (Standard)
- Dunkler Hintergrund: `#0f172a`
- Primärer Background: `#1e293b`
- Akzentfarben: Indigo/Purple Gradient
- Optimiert für lange Spielsessions

### Light Mode
- Heller Hintergrund: `#f8fafc`
- Primärer Background: `#ffffff`
- Kontrastreiche Farben für Tageslicht
- Klare, saubere Ästhetik

### Theme Toggle
```javascript
// Theme wird automatisch im LocalStorage gespeichert
localStorage.getItem('flagguess-theme') // 'dark' oder 'light'
```

## 🔧 Anpassungen

### Weitere Länder hinzufügen
In `countries.js` weitere Einträge zum `COUNTRIES`-Array hinzufügen:
```javascript
{ name: "Landname", code: "iso-code" }
```
ISO-Codes: [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)

### Schwierigkeitsgrad ändern
In `game.js` die `maxAttempts` Eigenschaft anpassen:
```javascript
maxAttempts: 5  // Standard: 5 Versuche (empfohlen: 3-7)
```

### Theme-Farben anpassen
In `style.css` die CSS-Variablen ändern:
```css
:root {
    --accent-primary: #6366f1;  /* Hauptakzent */
    --accent-secondary: #8b5cf6; /* Sekundärakzent */
    /* ... weitere Farben ... */
}

[data-theme="dark"] {
    /* Dark Mode spezifische Farben */
}
```

### Standard-Theme ändern
In `theme.js` den Default-Wert ändern:
```javascript
getInitialTheme() {
    const savedTheme = localStorage.getItem('flagguess-theme');
    return savedTheme || 'light'; // Hier 'light' für Light Mode Standard
}
```

## 🔬 Technische Details

### Pixel-Überlagerungs-Algorithmus
```javascript
// Vergleicht RGB-Werte Pixel für Pixel
for (let y = 0; y < height; y++) {
    for (let x = 0; x < width; x++) {
        // Toleranz von ±5 für JPEG-Artefakte
        if (Math.abs(targetR - guessR) <= 5 && 
            Math.abs(targetG - guessG) <= 5 && 
            Math.abs(targetB - guessB) <= 5) {
            // Pixel übernehmen
        }
    }
}
```

### Performance-Optimierungen
- `willReadFrequently: true` für Canvas-Kontext
- Temporäre Canvas für Bildverarbeitung
- Debounced Input Events
- CSS Hardware Acceleration für Animationen

### Browser-Kompatibilität
- ✅ Chrome/Edge 90+
- ✅ Firefox 88+
- ✅ Safari 14+
- ✅ Mobile Browsers (iOS Safari, Chrome Mobile)

## 📱 Responsive Breakpoints

```css
/* Desktop */
@media (min-width: 769px) { /* Volle Features */ }

/* Tablet */
@media (max-width: 768px) { /* Angepasstes Layout */ }

/* Mobile */
@media (max-width: 480px) { /* Optimierte Mobile-UI */ }
```

## 🐛 Bekannte Einschränkungen

1. **Komplexe Wappen**: Flaggen mit detaillierten Wappen (z.B. Spanien, Mexiko) sind schwieriger zu erraten
2. **CORS-Abhängigkeit**: Benötigt CORS-fähige Flaggen-Quelle
3. **Canvas-Limitierungen**: Sehr große Flaggen könnten Performance beeinträchtigen
4. **Browser-Support**: LocalStorage muss aktiviert sein für Theme-Persistenz

## 🎯 Best Practices

### Für Spieler
- Starten Sie mit einfachen Flaggen (Streifen-Designs)
- Nutzen Sie die Autocomplete-Funktion
- Beachten Sie Farbkombinationen aus vorherigen Versuchen

### Für Entwickler
- Testen Sie neue Flaggen vor dem Hinzufügen
- Validieren Sie ISO-Codes gegen flagcdn.com
- Nutzen Sie Browser DevTools für Canvas-Debugging
- Beachten Sie CORS-Policies bei eigenen Flaggen-Quellen

## 📊 Statistiken & Analytics (Optional)

Um Cloudflare Web Analytics hinzuzufügen:
1. Gehe zu Cloudflare Dashboard → Web Analytics
2. Erstelle eine neue Site
3. Füge den Analytics-Tag in `index.html` ein:
```html
<script defer src='https://static.cloudflareinsights.com/beacon.min.js' 
        data-cf-beacon='{"token": "YOUR_TOKEN"}'></script>
```

## 🤝 Contributing

Verbesserungsvorschläge und Bug-Reports sind willkommen!
- Neue Länder hinzufügen
- UI/UX Verbesserungen
- Performance-Optimierungen
- Accessibility-Features

## 📄 Lizenz

MIT License - Frei verwendbar für private und kommerzielle Projekte

## 🙏 Credits

- **Flaggen**: [flagcdn.com](https://flagcdn.com) - Kostenlose Flaggen-API
- **Icons**: Inline SVG Icons
- **Hosting**: Cloudflare Pages

---

**Viel Spaß beim Spielen! 🎮🎯**
