#!/bin/bash
# Flag Country Pages Generator
# Generates individual SEO pages for each country

# Create countries directory
mkdir -p countries

# Sample country data (you can expand this with all 195 countries)
declare -A COUNTRIES=(
    ["germany"]="Deutschland|Germany|Europe|Schwarz-Rot-Gold|Black-Red-Gold|Die deutsche Flagge zeigt drei horizontale Streifen in Schwarz, Rot und Gold.|The German flag shows three horizontal stripes in black, red, and gold."
    ["usa"]="USA|United States|North America|Stars and Stripes|Stars and Stripes|Die amerikanische Flagge zeigt 50 Sterne und 13 Streifen.|The American flag shows 50 stars and 13 stripes."
    ["france"]="Frankreich|France|Europe|Blau-Weiß-Rot|Blue-White-Red|Die französische Trikolore zeigt drei vertikale Streifen.|The French tricolor shows three vertical stripes."
    ["japan"]="Japan|Japan|Asia|Rote Sonne|Red Sun|Die japanische Flagge zeigt eine rote Sonne auf weißem Hintergrund.|The Japanese flag shows a red sun on a white background."
    ["canada"]="Kanada|Canada|North America|Ahornblatt|Maple Leaf|Die kanadische Flagge zeigt ein rotes Ahornblatt auf weißem Hintergrund.|The Canadian flag shows a red maple leaf on a white background."
)

# Template function
generate_country_page() {
    local slug=$1
    local de_name=$2
    local en_name=$3
    local continent=$4
    local de_colors=$5
    local en_colors=$6
    local de_desc=$7
    local en_desc=$8
    
    cat > "countries/${slug}-flag.html" <<EOF
<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${de_name} Flagge Quiz – ${de_name}flagge erraten | FlagGuess</title>
    <meta name="description" content="Lerne die ${de_name} Flagge kennen. ${de_desc} Teste dein Wissen im kostenlosen Flaggen Quiz.">
    
    <!-- Open Graph -->
    <meta property="og:title" content="${de_name} Flagge | FlagGuess">
    <meta property="og:description" content="${de_desc}">
    <meta property="og:image" content="https://flaggues.pages.dev/assets/og-image.svg">
    <meta property="og:url" content="https://flaggues.pages.dev/countries/${slug}-flag.html">
    
    <!-- Canonical -->
    <link rel="canonical" href="https://flaggues.pages.dev/countries/${slug}-flag.html">
    
    <!-- Favicon -->
    <link rel="icon" type="image/svg+xml" href="/assets/favicon.svg">
    
    <link rel="stylesheet" href="../style.css">
    <link rel="stylesheet" href="../library.css">
    <link rel="stylesheet" href="../content-pages.css">
    
    <!-- Structured Data -->
    <script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@type": "WebPage",
      "name": "${de_name} Flagge",
      "description": "${de_desc}",
      "breadcrumb": {
        "@type": "BreadcrumbList",
        "itemListElement": [{
          "@type": "ListItem",
          "position": 1,
          "name": "Home",
          "item": "https://flaggues.pages.dev/"
        }, {
          "@type": "ListItem",
          "position": 2,
          "name": "${de_name} Flagge",
          "item": "https://flaggues.pages.dev/countries/${slug}-flag.html"
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
                    <a href="../library.html">Bibliothek</a>
                </div>
            </nav>
        </header>

        <main class="content-page">
            <div class="page-hero">
                <h1>🚩 ${de_name} Flagge</h1>
                <p class="hero-subtitle">Lerne alles über die ${de_name}flagge – Farben, Bedeutung und Geschichte</p>
            </div>

            <div class="content-wrapper">
                <section class="seo-content">
                    <h2>Die ${de_name} Flagge – Übersicht</h2>
                    <p>${de_desc} Die <strong>${de_name} Flagge</strong> gehört zu ${continent} und ist ein wichtiges Nationalsymbol des Landes.</p>
                    
                    <h3>Farben der ${de_name} Flagge</h3>
                    <p>Die Hauptfarben der <strong>${de_name}flagge</strong> sind: <strong>${de_colors}</strong></p>
                    
                    <h3>${de_name} Flagge im Quiz</h3>
                    <p>Kannst du die ${de_name} Flagge im Quiz erkennen? Teste dein Wissen über die <strong>${de_name}flagge</strong> in unserem kostenlosen <strong>Flaggen Quiz</strong>. Die ${de_name} Flagge ist eine der bekanntesten Flaggen aus ${continent}.</p>
                    
                    <h3>Warum die ${de_name} Flagge lernen?</h3>
                    <ul>
                        <li><strong>Geografie-Wissen:</strong> Lerne ${de_name} und seine Position in ${continent} kennen</li>
                        <li><strong>Quiz-Vorbereitung:</strong> Die ${de_name} Flagge ist ein Klassiker in jedem Flaggen Quiz</li>
                        <li><strong>Allgemeinbildung:</strong> Wichtiges Grundwissen über ${de_name}</li>
                        <li><strong>Reisevorbereitung:</strong> Perfekt wenn du nach ${de_name} reisen möchtest</li>
                    </ul>

                    <h3>Interessante Fakten zur ${de_name} Flagge</h3>
                    <p>Die <strong>${de_name} Flagge</strong> ist nicht nur ein Symbol für ${de_name}, sondern auch ein Zeugnis der Geschichte und Kultur des Landes. Jede Farbe und jedes Symbol auf der ${de_name}flagge hat eine besondere Bedeutung.</p>

                    <div class="cta-box">
                        <h3>Bereit die ${de_name} Flagge im Quiz zu erraten?</h3>
                        <p>Teste dein Wissen über die ${de_name} Flagge und über 190 weitere Länderflaggen!</p>
                        <a href="../index.html" class="cta-button">🚩 Quiz starten</a>
                    </div>

                    <h3>Häufig gestellte Fragen zur ${de_name} Flagge</h3>
                    <div class="faq">
                        <div class="faq-item">
                            <h4>Wie sieht die ${de_name} Flagge aus?</h4>
                            <p>${de_desc}</p>
                        </div>
                        <div class="faq-item">
                            <h4>Welche Farben hat die ${de_name} Flagge?</h4>
                            <p>Die ${de_name} Flagge hat die Farben: ${de_colors}.</p>
                        </div>
                        <div class="faq-item">
                            <h4>Wo liegt ${de_name}?</h4>
                            <p>${de_name} liegt in ${continent}.</p>
                        </div>
                        <div class="faq-item">
                            <h4>Wie schwer ist die ${de_name} Flagge im Quiz?</h4>
                            <p>Die ${de_name} Flagge ist eine bekannte Flagge und eignet sich gut für Anfänger und Fortgeschrittene im Flaggen Quiz.</p>
                        </div>
                    </div>

                    <h3>Mehr über ${de_name} lernen</h3>
                    <p>Die <strong>${de_name} Flagge</strong> ist nur der Anfang. In unserem Flaggen Quiz kannst du auch die Geografie, Hauptstadt und weitere Fakten über ${de_name} lernen. Die ${de_name}flagge ist ein wichtiger Teil der nationalen Identität und Geschichte des Landes.</p>
                </section>

                <aside class="related-pages">
                    <h3>Mehr Flaggen</h3>
                    <div class="continent-grid">
                        <a href="../library.html" class="continent-card">
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
                <p>&copy; 2026 FlagGuess. Lerne die ${de_name} Flagge und 195+ weitere Länderflaggen!</p>
                <div class="footer-links">
                    <a href="../index.html">Quiz spielen</a>
                    <a href="../library.html">Flaggen Bibliothek</a>
                    <a href="../hardest-flags.html">Schwerste Flaggen</a>
                    <a href="../similar-flags.html">Ähnliche Flaggen</a>
                    <a href="../impressum.html">Impressum</a>
                    <a href="../datenschutz.html">Datenschutz</a>
                </div>
            </div>
        </footer>
    </div>
</body>
</html>
EOF

    echo "✅ Generated: countries/${slug}-flag.html"
}

# Generate pages for sample countries
for slug in "${!COUNTRIES[@]}"; do
    IFS='|' read -r de_name en_name continent de_colors en_colors de_desc en_desc <<< "${COUNTRIES[$slug]}"
    generate_country_page "$slug" "$de_name" "$en_name" "$continent" "$de_colors" "$en_colors" "$de_desc" "$en_desc"
done

echo ""
echo "✅ Country pages generated successfully!"
echo "📍 Location: countries/"
echo ""
echo "💡 Next steps:"
echo "1. Add more countries to the COUNTRIES array (all 195)"
echo "2. Run this script to generate all pages"
echo "3. Update sitemap.xml with all generated pages"
echo "4. Push to GitHub and deploy to Cloudflare Pages"