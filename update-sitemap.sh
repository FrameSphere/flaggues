#!/bin/bash

# ============================================
# SITEMAP UPDATER FOR COUNTRY PAGES
# Automatically adds all country pages from
# /de/countries/ and /en/countries/ to sitemap.xml
# ============================================

echo "🗺️  Sitemap Updater - Country Pages"
echo "===================================="
echo ""

# Configuration
SITEMAP="sitemap.xml"
BASE_URL="https://flaggues.pages.dev"
BACKUP_DIR=".sitemap-backups"
TEMP_FILE="sitemap.tmp.xml"

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Create backup
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
BACKUP_FILE="$BACKUP_DIR/sitemap-backup-$TIMESTAMP.xml"

if [ -f "$SITEMAP" ]; then
    cp "$SITEMAP" "$BACKUP_FILE"
    echo "✅ Backup created: $BACKUP_FILE"
else
    echo "❌ Error: $SITEMAP not found!"
    exit 1
fi

echo ""
echo "📊 Scanning directories..."

# Count files
DE_COUNT=$(find de/countries -name "*.html" 2>/dev/null | wc -l | tr -d ' ')
EN_COUNT=$(find en/countries -name "*.html" 2>/dev/null | wc -l | tr -d ' ')

echo "   Found $DE_COUNT files in de/countries/"
echo "   Found $EN_COUNT files in en/countries/"
echo ""

if [ "$DE_COUNT" -eq 0 ] && [ "$EN_COUNT" -eq 0 ]; then
    echo "⚠️  Warning: No country pages found!"
    echo "   Make sure to run generate-country-pages-FIXED.sh first"
    exit 1
fi

# Start building new sitemap
echo "🔨 Building new sitemap..."

# Write header
cat > "$TEMP_FILE" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
        xmlns:xhtml="http://www.w3.org/1999/xhtml">
  
  <!-- Homepage -->
  <url>
    <loc>https://flaggues.pages.dev/</loc>
    <changefreq>daily</changefreq>
    <priority>1.0</priority>
    <xhtml:link rel="alternate" hreflang="de" href="https://flaggues.pages.dev/de/"/>
    <xhtml:link rel="alternate" hreflang="en" href="https://flaggues.pages.dev/en/"/>
  </url>

  <!-- German Version -->
  <url>
    <loc>https://flaggues.pages.dev/de/</loc>
    <changefreq>daily</changefreq>
    <priority>1.0</priority>
  </url>

  <!-- English Version -->
  <url>
    <loc>https://flaggues.pages.dev/en/</loc>
    <changefreq>daily</changefreq>
    <priority>1.0</priority>
  </url>

  <!-- Library -->
  <url>
    <loc>https://flaggues.pages.dev/library.html</loc>
    <changefreq>weekly</changefreq>
    <priority>0.9</priority>
  </url>

  <!-- German Content Pages -->
  <url>
    <loc>https://flaggues.pages.dev/de/easy-flags.html</loc>
    <changefreq>monthly</changefreq>
    <priority>0.8</priority>
    <xhtml:link rel="alternate" hreflang="de" href="https://flaggues.pages.dev/de/easy-flags.html"/>
    <xhtml:link rel="alternate" hreflang="en" href="https://flaggues.pages.dev/en/easy-flags.html"/>
  </url>

  <url>
    <loc>https://flaggues.pages.dev/de/hardest-flags.html</loc>
    <changefreq>monthly</changefreq>
    <priority>0.8</priority>
    <xhtml:link rel="alternate" hreflang="de" href="https://flaggues.pages.dev/de/hardest-flags.html"/>
    <xhtml:link rel="alternate" hreflang="en" href="https://flaggues.pages.dev/en/hardest-flags.html"/>
  </url>

  <url>
    <loc>https://flaggues.pages.dev/de/similar-flags.html</loc>
    <changefreq>monthly</changefreq>
    <priority>0.8</priority>
    <xhtml:link rel="alternate" hreflang="de" href="https://flaggues.pages.dev/de/similar-flags.html"/>
    <xhtml:link rel="alternate" hreflang="en" href="https://flaggues.pages.dev/en/similar-flags.html"/>
  </url>

  <url>
    <loc>https://flaggues.pages.dev/de/flags-of-europe.html</loc>
    <changefreq>monthly</changefreq>
    <priority>0.8</priority>
    <xhtml:link rel="alternate" hreflang="de" href="https://flaggues.pages.dev/de/flags-of-europe.html"/>
    <xhtml:link rel="alternate" hreflang="en" href="https://flaggues.pages.dev/en/flags-of-europe.html"/>
  </url>

  <url>
    <loc>https://flaggues.pages.dev/de/flags-of-asia.html</loc>
    <changefreq>monthly</changefreq>
    <priority>0.8</priority>
    <xhtml:link rel="alternate" hreflang="de" href="https://flaggues.pages.dev/de/flags-of-asia.html"/>
    <xhtml:link rel="alternate" hreflang="en" href="https://flaggues.pages.dev/en/flags-of-asia.html"/>
  </url>

  <url>
    <loc>https://flaggues.pages.dev/de/flags-of-africa.html</loc>
    <changefreq>monthly</changefreq>
    <priority>0.8</priority>
    <xhtml:link rel="alternate" hreflang="de" href="https://flaggues.pages.dev/de/flags-of-africa.html"/>
    <xhtml:link rel="alternate" hreflang="en" href="https://flaggues.pages.dev/en/flags-of-africa.html"/>
  </url>

  <url>
    <loc>https://flaggues.pages.dev/de/flags-of-americas.html</loc>
    <changefreq>monthly</changefreq>
    <priority>0.8</priority>
    <xhtml:link rel="alternate" hreflang="de" href="https://flaggues.pages.dev/de/flags-of-americas.html"/>
    <xhtml:link rel="alternate" hreflang="en" href="https://flaggues.pages.dev/en/flags-of-americas.html"/>
  </url>

  <url>
    <loc>https://flaggues.pages.dev/de/flags-of-oceania.html</loc>
    <changefreq>monthly</changefreq>
    <priority>0.8</priority>
    <xhtml:link rel="alternate" hreflang="de" href="https://flaggues.pages.dev/de/flags-of-oceania.html"/>
    <xhtml:link rel="alternate" hreflang="en" href="https://flaggues.pages.dev/en/flags-of-oceania.html"/>
  </url>

  <!-- English Content Pages -->
  <url>
    <loc>https://flaggues.pages.dev/en/easy-flags.html</loc>
    <changefreq>monthly</changefreq>
    <priority>0.8</priority>
    <xhtml:link rel="alternate" hreflang="de" href="https://flaggues.pages.dev/de/easy-flags.html"/>
    <xhtml:link rel="alternate" hreflang="en" href="https://flaggues.pages.dev/en/easy-flags.html"/>
  </url>

  <url>
    <loc>https://flaggues.pages.dev/en/hardest-flags.html</loc>
    <changefreq>monthly</changefreq>
    <priority>0.8</priority>
    <xhtml:link rel="alternate" hreflang="de" href="https://flaggues.pages.dev/de/hardest-flags.html"/>
    <xhtml:link rel="alternate" hreflang="en" href="https://flaggues.pages.dev/en/hardest-flags.html"/>
  </url>

  <url>
    <loc>https://flaggues.pages.dev/en/similar-flags.html</loc>
    <changefreq>monthly</changefreq>
    <priority>0.8</priority>
    <xhtml:link rel="alternate" hreflang="de" href="https://flaggues.pages.dev/de/similar-flags.html"/>
    <xhtml:link rel="alternate" hreflang="en" href="https://flaggues.pages.dev/en/similar-flags.html"/>
  </url>

  <url>
    <loc>https://flaggues.pages.dev/en/flags-of-europe.html</loc>
    <changefreq>monthly</changefreq>
    <priority>0.8</priority>
    <xhtml:link rel="alternate" hreflang="de" href="https://flaggues.pages.dev/de/flags-of-europe.html"/>
    <xhtml:link rel="alternate" hreflang="en" href="https://flaggues.pages.dev/en/flags-of-europe.html"/>
  </url>

  <url>
    <loc>https://flaggues.pages.dev/en/flags-of-asia.html</loc>
    <changefreq>monthly</changefreq>
    <priority>0.8</priority>
    <xhtml:link rel="alternate" hreflang="de" href="https://flaggues.pages.dev/de/flags-of-asia.html"/>
    <xhtml:link rel="alternate" hreflang="en" href="https://flaggues.pages.dev/en/flags-of-asia.html"/>
  </url>

  <url>
    <loc>https://flaggues.pages.dev/en/flags-of-africa.html</loc>
    <changefreq>monthly</changefreq>
    <priority>0.8</priority>
    <xhtml:link rel="alternate" hreflang="de" href="https://flaggues.pages.dev/de/flags-of-africa.html"/>
    <xhtml:link rel="alternate" hreflang="en" href="https://flaggues.pages.dev/en/flags-of-africa.html"/>
  </url>

  <url>
    <loc>https://flaggues.pages.dev/en/flags-of-americas.html</loc>
    <changefreq>monthly</changefreq>
    <priority>0.8</priority>
    <xhtml:link rel="alternate" hreflang="de" href="https://flaggues.pages.dev/de/flags-of-americas.html"/>
    <xhtml:link rel="alternate" hreflang="en" href="https://flaggues.pages.dev/en/flags-of-americas.html"/>
  </url>

  <url>
    <loc>https://flaggues.pages.dev/en/flags-of-oceania.html</loc>
    <changefreq>monthly</changefreq>
    <priority>0.8</priority>
    <xhtml:link rel="alternate" hreflang="de" href="https://flaggues.pages.dev/de/flags-of-oceania.html"/>
    <xhtml:link rel="alternate" hreflang="en" href="https://flaggues.pages.dev/en/flags-of-oceania.html"/>
  </url>

  <!-- Legal Pages -->
  <url>
    <loc>https://flaggues.pages.dev/impressum.html</loc>
    <changefreq>yearly</changefreq>
    <priority>0.3</priority>
  </url>

  <url>
    <loc>https://flaggues.pages.dev/datenschutz.html</loc>
    <changefreq>yearly</changefreq>
    <priority>0.3</priority>
  </url>

  <!-- ================================ -->
  <!-- COUNTRY PAGES (AUTO-GENERATED)   -->
  <!-- ================================ -->

EOF

# Add country pages
echo "  📝 Adding country pages..."

# Get list of unique country slugs from DE directory
if [ -d "de/countries" ]; then
    country_count=0
    
    for file in de/countries/*.html; do
        if [ -f "$file" ]; then
            # Extract filename without path and extension
            slug=$(basename "$file" .html)
            
            # Add URL entry with hreflang
            cat >> "$TEMP_FILE" << EOF
  <url>
    <loc>${BASE_URL}/de/countries/${slug}.html</loc>
    <changefreq>monthly</changefreq>
    <priority>0.7</priority>
    <xhtml:link rel="alternate" hreflang="de" href="${BASE_URL}/de/countries/${slug}.html"/>
    <xhtml:link rel="alternate" hreflang="en" href="${BASE_URL}/en/countries/${slug}.html"/>
  </url>

EOF
            ((country_count++))
            
            # Progress indicator
            if [ $((country_count % 20)) -eq 0 ]; then
                echo "     Added $country_count countries..."
            fi
        fi
    done
    
    echo "  ✅ Added $country_count country pages"
else
    echo "  ⚠️  Directory de/countries/ not found"
fi

# Close urlset
echo "" >> "$TEMP_FILE"
echo "</urlset>" >> "$TEMP_FILE"

# Replace old sitemap with new one
mv "$TEMP_FILE" "$SITEMAP"

echo ""
echo "✨ Sitemap updated successfully!"
echo ""
echo "📊 Statistics:"
echo "   - Backup: $BACKUP_FILE"
echo "   - Total country pages: $country_count"
echo "   - German pages: $DE_COUNT"
echo "   - English pages: $EN_COUNT"
echo ""
echo "💡 Next steps:"
echo "   1. Review the sitemap: cat sitemap.xml | head -n 50"
echo "   2. Validate: https://www.xml-sitemaps.com/validate-xml-sitemap.html"
echo "   3. Submit to Google Search Console"
echo "   4. git add sitemap.xml && git commit -m 'Update sitemap with country pages' && git push"
echo ""