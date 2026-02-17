# FlagGuess 2.0 - Verbessertes Flaggen Quiz Spiel

Eine komplett neu aufgebaute Version des FlagGuess Spiels mit sauberer Codebasis und erweiterten Features.

## 🎯 Features

### Kernfunktionen
- **3 Schwierigkeitsgrade**: Einfach (8 Versuche), Mittel (5 Versuche), Schwer (3 Versuche)
- **Timer-Funktion**: Miss deine Zeit für jedes Spiel
- **Dark/Light Mode**: Mit Dark Mode als Standard
- **Mehrsprachig**: Deutsch und Englisch
- **190+ Länder**: Alle Länderflaggen weltweit

### Spielmechanik
- Pixelgenaue Farb-Überlagerung basierend auf Schwierigkeitsgrad
- Progressive Enthüllung der Flagge mit jedem Versuch
- Vorheriges Land wird beim neuen Spiel angezeigt
- Share-Funktionalität am Ende (WhatsApp, Facebook, Link kopieren)

### Technisch
- Saubere, modulare Code-Struktur
- SEO-optimiert mit Schema.org Markup
- Mobile-first Design
- Keine Fehler aus Version 1
- Performant und schnell ladend

## 📁 Dateistruktur

```
flagguess2/
├── index.html          # Hauptseite
├── style.css           # Alle Styles
├── countries.js        # Länderdaten (190+ Länder)
├── translations.js     # Mehrsprachigkeit (DE/EN)
├── theme.js           # Dark/Light Mode
├── game.js            # Spiellogik
├── impressum.html     # Impressum
├── datenschutz.html   # Datenschutz
├── robots.txt         # SEO
├── sitemap.xml        # SEO
├── ads.txt            # AdSense
└── assets/
    └── favicon.svg    # Favicon
```

## 🎮 Schwierigkeitsgrade

| Modus   | Farb-Toleranz | Max. Versuche |
|---------|---------------|---------------|
| Einfach | 50            | 8             |
| Mittel  | 30            | 5             |
| Schwer  | 15            | 3             |

## 🌍 Länder

Alle 190+ UN-Mitgliedsstaaten plus:
- Taiwan, Hongkong, Macau
- Kosovo
- Vatikanstadt
- Und viele weitere

## 🎨 Design

- **Modern & Clean**: Modernes UI mit Tailwind-inspiriertem Design
- **Dark Mode First**: Dark Mode als Standard
- **Mobile Responsive**: Optimiert für alle Bildschirmgrößen
- **Animationen**: Smooth Transitions und Mikroanimationen

## 🔧 Technische Details

### Canvas-Rendering
- 600x400px Canvas
- Lazy Loading der Flaggen
- Pixelgenaue RGB-Vergleiche
- Schwierigkeitsabhängige Farb-Toleranz

### LocalStorage
- `flagguess-theme`: Theme-Einstellung
- `flagguess-language`: Spracheinstellung
- `flagguess-difficulty`: Schwierigkeitsgrad

### Performance
- Flaggen von flagcdn.com (CDN)
- Preconnect für schnelleres Laden
- Lazy Loading wo möglich
- Optimierte DOM-Operationen

## 📱 Browser-Kompatibilität

- Chrome/Edge: ✅
- Firefox: ✅
- Safari: ✅
- Mobile Browser: ✅

## 🚀 Deployment

Bereit für Deployment auf:
- Cloudflare Pages
- Netlify
- Vercel
- GitHub Pages

## 📝 Changelog

### Version 2.0 (Aktuell)
- Kompletter Neuaufbau des Codes
- 3 Schwierigkeitsgrade implementiert
- Timer-Funktion hinzugefügt
- Share-Funktionalität verbessert
- Previous Country Popup
- Bessere Mehrsprachigkeit
- Mobile-Optimierung
- Keine Fehler mehr aus Version 1

## 🎯 Unterschiede zu Version 1

| Feature | Version 1 | Version 2 |
|---------|-----------|-----------|
| Code-Struktur | Durcheinander | Clean & Modular |
| Schwierigkeitsgrade | Buggy | Perfekt funktionierend |
| Timer | Vorhanden | Verbessert |
| Share | Basis | Mit Modal & Buttons |
| Previous Country | Fehlerhaft | Popup mit Animation |
| Mobile | Okay | Optimiert |
| SEO | Basis | Vollständig |

## 👨‍💻 Entwickelt von

Karol Paschek / FrameSphere
© 2026 FlagGuess

## 📄 Lizenz

Alle Rechte vorbehalten.
