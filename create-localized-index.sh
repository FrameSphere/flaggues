#!/bin/bash

# ============================================
# CREATE LOCALIZED INDEX FILES
# Erstellt /de/index.html und /en/index.html
# ============================================

echo "🌍 Creating localized index.html files..."
echo "=========================================="
echo ""

cd "$(dirname "$0")"

# Check if root index.html exists
if [ ! -f "index.html" ]; then
    echo "❌ Error: index.html not found in root!"
    exit 1
fi

# Create /de/index.html
echo "📝 Creating /de/index.html..."
if [ ! -d "de" ]; then
    mkdir de
fi

# Copy root index.html to /de/
cp index.html de/index.html

# Fix paths in /de/index.html
sed -i.bak 's|href="/css/|href="../css/|g' de/index.html
sed -i.bak 's|src="/js/|src="../js/|g' de/index.html
sed -i.bak 's|href="/assets/|href="../assets/|g' de/index.html

# Fix language links
sed -i.bak 's|<html lang="de">|<html lang="de">|g' de/index.html

# Fix canonical URL
sed -i.bak 's|<link rel="canonical" href="https://flaggues.pages.dev/">|<link rel="canonical" href="https://flaggues.pages.dev/de/">|g' de/index.html

# Fix hreflang tags
sed -i.bak 's|<link rel="alternate" hreflang="de" href="https://flaggues.pages.dev/">|<link rel="alternate" hreflang="de" href="https://flaggues.pages.dev/de/">|g' de/index.html
sed -i.bak 's|<link rel="alternate" hreflang="en" href="https://flaggues.pages.dev/en/">|<link rel="alternate" hreflang="en" href="https://flaggues.pages.dev/en/">|g' de/index.html
sed -i.bak 's|<link rel="alternate" hreflang="x-default" href="https://flaggues.pages.dev/">|<link rel="alternate" hreflang="x-default" href="https://flaggues.pages.dev/de/">|g' de/index.html

# Fix content page links (remove de/ prefix since we're already in /de/)
sed -i.bak 's|href="de/easy-flags.html"|href="easy-flags.html"|g' de/index.html
sed -i.bak 's|href="de/hardest-flags.html"|href="hardest-flags.html"|g' de/index.html
sed -i.bak 's|href="de/similar-flags.html"|href="similar-flags.html"|g' de/index.html
sed -i.bak 's|href="de/flags-of-europe.html"|href="flags-of-europe.html"|g' de/index.html
sed -i.bak 's|href="de/flags-of-asia.html"|href="flags-of-asia.html"|g' de/index.html
sed -i.bak 's|href="de/flags-of-africa.html"|href="flags-of-africa.html"|g' de/index.html
sed -i.bak 's|href="de/flags-of-americas.html"|href="flags-of-americas.html"|g' de/index.html
sed -i.bak 's|href="de/flags-of-oceania.html"|href="flags-of-oceania.html"|g' de/index.html

# Fix library link
sed -i.bak 's|href="library.html"|href="../library.html"|g' de/index.html

# Fix footer links
sed -i.bak 's|href="impressum.html"|href="../impressum.html"|g' de/index.html
sed -i.bak 's|href="datenschutz.html"|href="../datenschutz.html"|g' de/index.html

rm -f de/index.html.bak

echo "✅ Created /de/index.html"

# Create /en/index.html
echo "📝 Creating /en/index.html..."
if [ ! -d "en" ]; then
    mkdir en
fi

# Copy root index.html to /en/
cp index.html en/index.html

# Fix paths in /en/index.html
sed -i.bak 's|href="/css/|href="../css/|g' en/index.html
sed -i.bak 's|src="/js/|src="../js/|g' en/index.html
sed -i.bak 's|href="/assets/|href="../assets/|g' en/index.html

# Change language to EN
sed -i.bak 's|<html lang="de">|<html lang="en">|g' en/index.html

# Fix canonical URL
sed -i.bak 's|<link rel="canonical" href="https://flaggues.pages.dev/">|<link rel="canonical" href="https://flaggues.pages.dev/en/">|g' en/index.html

# Fix hreflang tags
sed -i.bak 's|<link rel="alternate" hreflang="de" href="https://flaggues.pages.dev/">|<link rel="alternate" hreflang="de" href="https://flaggues.pages.dev/de/">|g' en/index.html
sed -i.bak 's|<link rel="alternate" hreflang="en" href="https://flaggues.pages.dev/en/">|<link rel="alternate" hreflang="en" href="https://flaggues.pages.dev/en/">|g' en/index.html
sed -i.bak 's|<link rel="alternate" hreflang="x-default" href="https://flaggues.pages.dev/">|<link rel="alternate" hreflang="x-default" href="https://flaggues.pages.dev/de/">|g' en/index.html

# Fix content page links (change de/ to en/)
sed -i.bak 's|href="de/easy-flags.html"|href="easy-flags.html"|g' en/index.html
sed -i.bak 's|href="de/hardest-flags.html"|href="hardest-flags.html"|g' en/index.html
sed -i.bak 's|href="de/similar-flags.html"|href="similar-flags.html"|g' en/index.html
sed -i.bak 's|href="de/flags-of-europe.html"|href="flags-of-europe.html"|g' en/index.html
sed -i.bak 's|href="de/flags-of-asia.html"|href="flags-of-asia.html"|g' en/index.html
sed -i.bak 's|href="de/flags-of-africa.html"|href="flags-of-africa.html"|g' en/index.html
sed -i.bak 's|href="de/flags-of-americas.html"|href="flags-of-americas.html"|g' en/index.html
sed -i.bak 's|href="de/flags-of-oceania.html"|href="flags-of-oceania.html"|g' en/index.html

# Fix library link
sed -i.bak 's|href="library.html"|href="../library.html"|g' en/index.html

# Fix footer links
sed -i.bak 's|href="impressum.html"|href="../impressum.html"|g' en/index.html
sed -i.bak 's|href="datenschutz.html"|href="../datenschutz.html"|g' en/index.html

# Set default language select to EN
sed -i.bak 's|<select id="languageSelect" class="language-select" aria-label="Sprache wählen">|<select id="languageSelect" class="language-select" aria-label="Choose language">|g' en/index.html

rm -f en/index.html.bak

echo "✅ Created /en/index.html"

# Update root index.html to redirect
echo ""
echo "📝 Updating root index.html..."

# Add language detection script at the beginning of body
cat > /tmp/lang_redirect.txt << 'EOF'
<body data-theme="dark">
    <script>
        // Auto-redirect to language version
        (function() {
            const path = window.location.pathname;
            // Only redirect from exact root
            if (path === '/' || path === '/index.html') {
                const savedLang = localStorage.getItem('flagguess-language');
                const browserLang = navigator.language.substring(0, 2);
                const targetLang = savedLang || (browserLang === 'de' ? 'de' : 'en');
                window.location.href = '/' + targetLang + '/';
            }
        })();
    </script>
EOF

# This is complex to do with sed, so we'll leave root index.html as is
# and add a note for manual update

echo "⚠️  Manual step required:"
echo ""
echo "Add this to root index.html after <body> tag:"
echo ""
cat /tmp/lang_redirect.txt
echo ""

rm -f /tmp/lang_redirect.txt

echo ""
echo "✨ Done!"
echo ""
echo "📋 Created files:"
echo "  ✅ /de/index.html"
echo "  ✅ /en/index.html"
echo ""
echo "🔗 URL Structure:"
echo "  https://flaggues.pages.dev/      → Auto-redirect"
echo "  https://flaggues.pages.dev/de/   → German"
echo "  https://flaggues.pages.dev/en/   → English"
echo ""
echo "⚠️  IMPORTANT: Update root index.html with redirect script (see above)"
echo ""