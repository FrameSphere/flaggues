// Country code to slug mapping
function getCountrySlug(code) {
    const codeToSlug = {
        // Europe
        'de': 'germany', 'fr': 'france', 'it': 'italy', 'es': 'spain', 'pt': 'portugal',
        'nl': 'netherlands', 'be': 'belgium', 'at': 'austria', 'ch': 'switzerland', 'pl': 'poland',
        'cz': 'czech-republic', 'hu': 'hungary', 'ro': 'romania', 'bg': 'bulgaria', 'gr': 'greece',
        'se': 'sweden', 'no': 'norway', 'dk': 'denmark', 'fi': 'finland', 'is': 'iceland',
        'ie': 'ireland', 'gb': 'united-kingdom', 'hr': 'croatia', 'si': 'slovenia', 'sk': 'slovakia',
        'rs': 'serbia', 'ua': 'ukraine', 'ru': 'russia', 'ee': 'estonia', 'lv': 'latvia',
        'lt': 'lithuania', 'lu': 'luxembourg', 'mc': 'monaco', 'mt': 'malta', 'cy': 'cyprus',
        'al': 'albania', 'mk': 'north-macedonia', 'ba': 'bosnia-herzegovina', 'me': 'montenegro',
        'xk': 'kosovo', 'ad': 'andorra', 'li': 'liechtenstein', 'sm': 'san-marino',
        'va': 'vatican', 'md': 'moldova', 'by': 'belarus', 'ge': 'georgia', 'am': 'armenia', 'az': 'azerbaijan',
        
        // Asia
        'cn': 'china', 'jp': 'japan', 'kr': 'south-korea', 'in': 'india', 'th': 'thailand',
        'vn': 'vietnam', 'id': 'indonesia', 'my': 'malaysia', 'ph': 'philippines', 'sg': 'singapore',
        'pk': 'pakistan', 'bd': 'bangladesh', 'lk': 'sri-lanka', 'mm': 'myanmar', 'kh': 'cambodia',
        'la': 'laos', 'bn': 'brunei', 'tl': 'east-timor', 'mn': 'mongolia', 'np': 'nepal',
        'bt': 'bhutan', 'mv': 'maldives', 'af': 'afghanistan', 'kz': 'kazakhstan', 'uz': 'uzbekistan',
        'tm': 'turkmenistan', 'kg': 'kyrgyzstan', 'tj': 'tajikistan', 'kp': 'north-korea',
        'tw': 'taiwan', 'hk': 'hong-kong', 'mo': 'macau', 'ir': 'iran', 'iq': 'iraq',
        'kw': 'kuwait', 'bh': 'bahrain', 'om': 'oman', 'ye': 'yemen', 'sy': 'syria',
        'lb': 'lebanon', 'jo': 'jordan', 'ps': 'palestine', 'tr': 'turkey', 'il': 'israel',
        'sa': 'saudi-arabia', 'ae': 'united-arab-emirates', 'qa': 'qatar',
        
        // Africa
        'za': 'south-africa', 'eg': 'egypt', 'ma': 'morocco', 'ng': 'nigeria', 'ke': 'kenya',
        'dz': 'algeria', 'tn': 'tunisia', 'ly': 'libya', 'sd': 'sudan', 'ss': 'south-sudan',
        'et': 'ethiopia', 'so': 'somalia', 'ug': 'uganda', 'tz': 'tanzania', 'gh': 'ghana',
        'ci': 'ivory-coast', 'sn': 'senegal', 'cm': 'cameroon', 'ao': 'angola', 'mz': 'mozambique',
        'zw': 'zimbabwe', 'zm': 'zambia', 'na': 'namibia', 'bw': 'botswana', 'mg': 'madagascar',
        'mu': 'mauritius', 'rw': 'rwanda', 'bj': 'benin', 'tg': 'togo', 'ml': 'mali',
        'bf': 'burkina-faso', 'ne': 'niger', 'td': 'chad', 'ga': 'gabon', 'cg': 'congo',
        'cd': 'dr-congo', 'bi': 'burundi', 'cf': 'central-african-republic', 'km': 'comoros',
        'dj': 'djibouti', 'er': 'eritrea', 'sz': 'eswatini', 'gm': 'gambia', 'gn': 'guinea',
        'gw': 'guinea-bissau', 'gq': 'equatorial-guinea', 'ls': 'lesotho', 'lr': 'liberia',
        'mw': 'malawi', 'mr': 'mauritania', 'sc': 'seychelles', 'sl': 'sierra-leone',
        'st': 'sao-tome-principe', 'cv': 'cape-verde',
        
        // Americas
        'us': 'usa', 'ca': 'canada', 'mx': 'mexico', 'br': 'brazil', 'ar': 'argentina',
        'cl': 'chile', 'co': 'colombia', 'pe': 'peru', 've': 'venezuela', 'uy': 'uruguay',
        'py': 'paraguay', 'ec': 'ecuador', 'bo': 'bolivia', 'pa': 'panama', 'cr': 'costa-rica',
        'gt': 'guatemala', 'hn': 'honduras', 'ni': 'nicaragua', 'sv': 'el-salvador',
        'cu': 'cuba', 'jm': 'jamaica', 'ht': 'haiti', 'do': 'dominican-republic',
        'tt': 'trinidad-tobago', 'bs': 'bahamas', 'bb': 'barbados', 'bz': 'belize',
        'gy': 'guyana', 'sr': 'suriname', 'ag': 'antigua-barbuda', 'dm': 'dominica',
        'gd': 'grenada', 'kn': 'saint-kitts-nevis', 'lc': 'saint-lucia', 'vc': 'saint-vincent-grenadines',
        
        // Oceania
        'au': 'australia', 'nz': 'new-zealand', 'pg': 'papua-new-guinea', 'fj': 'fiji',
        'sb': 'solomon-islands', 'ws': 'samoa', 'vu': 'vanuatu', 'to': 'tonga',
        'pw': 'palau', 'fm': 'micronesia', 'ki': 'kiribati', 'mh': 'marshall-islands',
        'nr': 'nauru', 'tv': 'tuvalu'
    };
    
    return codeToSlug[code.toLowerCase()] || code.toLowerCase();
}

// Library Main Script
document.addEventListener('DOMContentLoaded', () => {
    // Initialize Language Manager
    libraryLangManager = new LibraryLanguageManager();
    libraryLangManager.updatePage();
    
    // Elements
    const libraryGrid = document.getElementById('libraryGrid');
    const searchInput = document.getElementById('searchInput');
    const filterButtons = document.querySelectorAll('.filter-btn');
    const totalCountriesEl = document.getElementById('totalCountries');
    const displayedCountEl = document.getElementById('displayedCount');
    const langSelect = document.getElementById('languageSelect');
    
    // State
    let currentFilter = 'all';
    let searchQuery = '';
    
    // Initialize
    renderAllCards();
    updateStats();
    
    // Event Listeners
    langSelect.addEventListener('change', (e) => {
        libraryLangManager.setLanguage(e.target.value);
        renderAllCards();
        updateStats();
    });
    
    searchInput.addEventListener('input', (e) => {
        searchQuery = e.target.value.toLowerCase().trim();
        filterCards();
    });
    
    filterButtons.forEach(btn => {
        btn.addEventListener('click', () => {
            // Update active state
            filterButtons.forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            
            // Update filter
            currentFilter = btn.dataset.continent;
            filterCards();
        });
    });
    
    // Render all cards
    function renderAllCards() {
        libraryGrid.innerHTML = '';
        
        COUNTRIES.forEach((country, index) => {
            const card = createFlagCard(country, index);
            libraryGrid.appendChild(card);
        });
    }
    
    // Create a flag card
    function createFlagCard(country, index) {
        const card = document.createElement('div');
        card.className = 'flag-card';
        card.style.animationDelay = `${index * 0.02}s`;
        
        const data = COUNTRY_DATA[country.code] || {};
        const countryName = getCountryName(country, libraryLangManager.currentLang);
        const continentName = libraryLangManager.getContinentName(data.continent || 'unknown');
        const capital = data.capital || '—';
        const population = data.population || '—';
        
        card.innerHTML = `
            <div class="flag-image-wrapper">
                <img 
                    src="${getFlagUrl(country.code)}" 
                    alt="${countryName}"
                    class="flag-image"
                    loading="lazy"
                >
            </div>
            <div class="flag-info">
                <h3 class="flag-name">${countryName}</h3>
                <div class="flag-details">
                    <div class="flag-detail">
                        <span class="detail-icon">${CONTINENTS[data.continent]?.emoji || '🌍'}</span>
                        <span class="detail-label">${libraryLangManager.get('continentLabel')}</span>
                        <span class="detail-value">${continentName}</span>
                    </div>
                    <div class="flag-detail">
                        <span class="detail-icon">🏛️</span>
                        <span class="detail-label">${libraryLangManager.get('capitalLabel')}</span>
                        <span class="detail-value">${capital}</span>
                    </div>
                    <div class="flag-detail">
                        <span class="detail-icon">👥</span>
                        <span class="detail-label">${libraryLangManager.get('populationLabel')}</span>
                        <span class="detail-value">${population}</span>
                    </div>
                </div>
            </div>
        `;
        
        // Store data for filtering
        card.dataset.continent = data.continent || 'unknown';
        card.dataset.name = countryName.toLowerCase();
        card.dataset.code = country.code;
        
        // Make card clickable and link to country page
        card.style.cursor = 'pointer';
        card.addEventListener('click', () => {
            // Convert country code to slug
            const slug = getCountrySlug(country.code);
            const lang = libraryLangManager.currentLang || 'de';
            const countryPageUrl = `/${lang}/countries/${slug}.html`;
            window.location.href = countryPageUrl;
        });
        
        return card;
    }
    
    // Filter cards based on search and continent
    function filterCards() {
        const cards = libraryGrid.querySelectorAll('.flag-card');
        let visibleCount = 0;
        
        cards.forEach(card => {
            const matchesFilter = currentFilter === 'all' || card.dataset.continent === currentFilter;
            const matchesSearch = !searchQuery || 
                                 card.dataset.name.includes(searchQuery) ||
                                 libraryLangManager.getContinentName(card.dataset.continent).toLowerCase().includes(searchQuery);
            
            if (matchesFilter && matchesSearch) {
                card.classList.remove('hidden');
                visibleCount++;
            } else {
                card.classList.add('hidden');
            }
        });
        
        // Show no results message if needed
        const existingNoResults = libraryGrid.querySelector('.no-results');
        if (existingNoResults) {
            existingNoResults.remove();
        }
        
        if (visibleCount === 0) {
            showNoResults();
        }
        
        // Update displayed count
        displayedCountEl.textContent = visibleCount;
    }
    
    // Show no results message
    function showNoResults() {
        const noResults = document.createElement('div');
        noResults.className = 'no-results';
        noResults.innerHTML = `
            <div class="no-results-icon">🔍</div>
            <div class="no-results-text">${libraryLangManager.get('noResultsText')}</div>
            <div class="no-results-hint">${libraryLangManager.get('noResultsHint')}</div>
        `;
        libraryGrid.appendChild(noResults);
    }
    
    // Update statistics
    function updateStats() {
        totalCountriesEl.textContent = COUNTRIES.length;
        displayedCountEl.textContent = COUNTRIES.length;
    }
    
    // Smooth scroll to top button (optional)
    let scrollTopBtn;
    
    window.addEventListener('scroll', () => {
        if (window.scrollY > 500) {
            if (!scrollTopBtn) {
                scrollTopBtn = createScrollTopButton();
                document.body.appendChild(scrollTopBtn);
            }
            scrollTopBtn.style.opacity = '1';
            scrollTopBtn.style.pointerEvents = 'auto';
        } else if (scrollTopBtn) {
            scrollTopBtn.style.opacity = '0';
            scrollTopBtn.style.pointerEvents = 'none';
        }
    });
    
    function createScrollTopButton() {
        const btn = document.createElement('button');
        btn.className = 'scroll-top-btn';
        btn.innerHTML = `
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <polyline points="18 15 12 9 6 15"></polyline>
            </svg>
        `;
        btn.style.cssText = `
            position: fixed;
            bottom: 40px;
            right: 40px;
            width: 56px;
            height: 56px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--accent-primary), var(--accent-secondary));
            border: none;
            color: white;
            cursor: pointer;
            box-shadow: 0 4px 12px var(--shadow-lg);
            transition: all 0.3s ease;
            opacity: 0;
            pointer-events: none;
            z-index: 100;
            display: flex;
            align-items: center;
            justify-content: center;
        `;
        
        btn.addEventListener('click', () => {
            window.scrollTo({ top: 0, behavior: 'smooth' });
        });
        
        btn.addEventListener('mouseenter', () => {
            btn.style.transform = 'translateY(-4px)';
        });
        
        btn.addEventListener('mouseleave', () => {
            btn.style.transform = 'translateY(0)';
        });
        
        return btn;
    }
});
