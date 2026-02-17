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
