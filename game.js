// Schwierigkeitseinstellungen
const DIFFICULTY = {
    easy: {
        colorTolerance: 50,
        maxAttempts: 8,
        name: { de: 'Einfach', en: 'Easy' }
    },
    medium: {
        colorTolerance: 30,
        maxAttempts: 5,
        name: { de: 'Mittel', en: 'Medium' }
    },
    hard: {
        colorTolerance: 15,
        maxAttempts: 3,
        name: { de: 'Schwer', en: 'Hard' }
    }
};

// Game State
const game = {
    targetCountry: null,
    previousCountry: null,
    attempts: 0,
    maxAttempts: 5,
    guesses: [],
    gameOver: false,
    targetImageData: null,
    currentImageData: null,
    startTime: null,
    timerInterval: null,
    difficulty: localStorage.getItem('flagguess-difficulty') || 'medium'
};

// Canvas Elemente
const canvas = document.getElementById('flagCanvas');
const ctx = canvas.getContext('2d', { willReadFrequently: true });

// UI Elemente
const elements = {
    input: document.getElementById('countryInput'),
    guessBtn: document.getElementById('guessBtn'),
    newGameBtn: document.getElementById('newGameBtn'),
    attemptCounter: document.getElementById('attemptCounter'),
    guessList: document.getElementById('guessList'),
    timer: document.getElementById('timer'),
    difficultySelect: document.getElementById('difficultySelect'),
    resultModal: document.getElementById('resultModal'),
    resultTitle: document.getElementById('resultTitle'),
    resultText: document.getElementById('resultText'),
    resultCanvas: document.getElementById('resultCanvas'),
    playAgainBtn: document.getElementById('playAgainBtn'),
    aboutModal: document.getElementById('aboutModal'),
    aboutLink: document.getElementById('aboutLink'),
    previousPopup: document.getElementById('previousCountryPopup'),
    howToPlayToggle: document.querySelector('.how-to-play-toggle')
};

// Initialisierung
document.addEventListener('DOMContentLoaded', () => {
    setTimeout(initGame, 100); // Kurze Verzögerung für langManager
    setupEventListeners();
});

function setupEventListeners() {
    elements.guessBtn.addEventListener('click', handleGuess);
    elements.input.addEventListener('keypress', (e) => {
        if (e.key === 'Enter') handleGuess();
    });
    elements.newGameBtn.addEventListener('click', initGame);
    elements.playAgainBtn.addEventListener('click', () => {
        hideModal(elements.resultModal);
        initGame();
    });
    elements.difficultySelect.addEventListener('change', changeDifficulty);
    
    // About Modal (optional)
    if (elements.aboutLink) {
        elements.aboutLink.addEventListener('click', (e) => {
            e.preventDefault();
            showModal(elements.aboutModal);
        });
    }
    
    const aboutClose = elements.aboutModal ? elements.aboutModal.querySelector('.modal-close') : null;
    const aboutOverlay = elements.aboutModal ? elements.aboutModal.querySelector('.modal-overlay') : null;
    if (aboutClose) aboutClose.addEventListener('click', () => hideModal(elements.aboutModal));
    if (aboutOverlay) aboutOverlay.addEventListener('click', () => hideModal(elements.aboutModal));
    
    // Result Modal Overlay
    const resultOverlay = elements.resultModal.querySelector('.modal-overlay');
    if (resultOverlay) {
        resultOverlay.addEventListener('click', () => {
            hideModal(elements.resultModal);
            initGame();
        });
    }
    
    // How to Play Toggle
    if (elements.howToPlayToggle) {
        elements.howToPlayToggle.addEventListener('click', () => {
            const instructions = document.querySelector('.instructions');
            const isCollapsed = instructions.classList.contains('collapsed');
            instructions.classList.toggle('collapsed');
            elements.howToPlayToggle.setAttribute('aria-expanded', isCollapsed);
        });
    }
}

// Spiel initialisieren
function initGame() {
    // Vorheriges Land anzeigen
    if (game.targetCountry) {
        showPreviousCountry(game.targetCountry);
        game.previousCountry = game.targetCountry;
    }
    
    // Schwierigkeitseinstellungen laden
    const settings = DIFFICULTY[game.difficulty];
    game.maxAttempts = settings.maxAttempts;
    
    // Spiel zurücksetzen
    game.targetCountry = getRandomCountry();
    game.attempts = 0;
    game.guesses = [];
    game.gameOver = false;
    game.targetImageData = null;
    game.currentImageData = null;
    
    // Canvas leeren
    ctx.fillStyle = 'white';
    ctx.fillRect(0, 0, canvas.width, canvas.height);
    
    // UI zurücksetzen
    elements.input.value = '';
    elements.input.disabled = false;
    elements.guessBtn.disabled = false;
    updateAttemptCounter();
    clearGuessList();
    
    // Timer starten
    startTimer();
    
    // Focus auf Input
    setTimeout(() => elements.input.focus(), 100);
}

// Timer-Funktionen
function startTimer() {
    game.startTime = Date.now();
    if (game.timerInterval) clearInterval(game.timerInterval);
    
    game.timerInterval = setInterval(() => {
        const elapsed = Math.floor((Date.now() - game.startTime) / 1000);
        const mins = Math.floor(elapsed / 60);
        const secs = elapsed % 60;
        elements.timer.textContent = `${mins}:${secs.toString().padStart(2, '0')}`;
    }, 100);
}

function stopTimer() {
    if (game.timerInterval) {
        clearInterval(game.timerInterval);
        game.timerInterval = null;
    }
    return Math.floor((Date.now() - game.startTime) / 1000);
}

function getTimeString(seconds) {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins}:${secs.toString().padStart(2, '0')}`;
}

// Schwierigkeit ändern
function changeDifficulty() {
    game.difficulty = elements.difficultySelect.value;
    localStorage.setItem('flagguess-difficulty', game.difficulty);
    
    const settings = DIFFICULTY[game.difficulty];
    const lang = langManager ? langManager.currentLang : 'de';
    const diffName = settings.name[lang];
    
    showNotification(
        (langManager ? langManager.get('difficultyChanged') : 'Schwierigkeit:') + ' ' + diffName,
        'info'
    );
    
    initGame();
}

// Guess verarbeiten
function handleGuess() {
    if (game.gameOver) return;
    
    const inputValue = elements.input.value.trim();
    if (!inputValue) {
        showNotification(langManager ? langManager.get('enterCountry') : 'Bitte Land eingeben!', 'error');
        return;
    }
    
    const lang = langManager ? langManager.currentLang : 'de';
    const guessCountry = findCountryByName(inputValue, lang);
    
    if (!guessCountry) {
        showNotification(langManager ? langManager.get('countryNotFound') : 'Land nicht gefunden!', 'error');
        return;
    }
    
    if (game.guesses.some(g => g.code === guessCountry.code)) {
        showNotification(langManager ? langManager.get('alreadyGuessed') : 'Bereits geraten!', 'error');
        return;
    }
    
    game.attempts++;
    game.guesses.push(guessCountry);
    
    // Flagge laden und vergleichen
    loadAndCompareFlag(guessCountry);
    
    // UI aktualisieren
    updateAttemptCounter();
    addGuessToList(guessCountry);
    elements.input.value = '';
    elements.input.focus();
    
    // Prüfen ob gewonnen oder verloren
    if (guessCountry.code === game.targetCountry.code) {
        setTimeout(() => endGame(true), 500);
    } else if (game.attempts >= game.maxAttempts) {
        setTimeout(() => endGame(false), 500);
    }
}

// Flagge laden und vergleichen
function loadAndCompareFlag(guessCountry) {
    // Zielflagge laden (falls noch nicht geladen)
    if (!game.targetImageData) {
        loadTargetFlag(() => {
            loadGuessFlag(guessCountry);
        });
    } else {
        loadGuessFlag(guessCountry);
    }
}

function loadTargetFlag(callback) {
    const img = new Image();
    img.crossOrigin = 'anonymous';
    img.onload = () => {
        const tempCanvas = document.createElement('canvas');
        tempCanvas.width = canvas.width;
        tempCanvas.height = canvas.height;
        const tempCtx = tempCanvas.getContext('2d');
        
        tempCtx.drawImage(img, 0, 0, canvas.width, canvas.height);
        game.targetImageData = tempCtx.getImageData(0, 0, canvas.width, canvas.height);
        
        // Aktuelles Bild initialisieren (weiß)
        game.currentImageData = ctx.createImageData(canvas.width, canvas.height);
        const data = game.currentImageData.data;
        for (let i = 0; i < data.length; i += 4) {
            data[i] = data[i + 1] = data[i + 2] = 255; // Weiß
            data[i + 3] = 255; // Alpha
        }
        
        callback();
    };
    img.onerror = () => {
        console.error('Fehler beim Laden der Zielflagge');
        initGame();
    };
    img.src = getFlagUrl(game.targetCountry.code);
}

function loadGuessFlag(guessCountry) {
    const img = new Image();
    img.crossOrigin = 'anonymous';
    img.onload = () => {
        const tempCanvas = document.createElement('canvas');
        tempCanvas.width = canvas.width;
        tempCanvas.height = canvas.height;
        const tempCtx = tempCanvas.getContext('2d');
        
        tempCtx.drawImage(img, 0, 0, canvas.width, canvas.height);
        const guessImageData = tempCtx.getImageData(0, 0, canvas.width, canvas.height);
        
        // Pixel vergleichen und überschreiben
        compareAndOverlay(guessImageData);
        
        // Canvas aktualisieren
        ctx.putImageData(game.currentImageData, 0, 0);
    };
    img.onerror = () => {
        console.error('Fehler beim Laden der Guess-Flagge');
    };
    img.src = getFlagUrl(guessCountry.code);
}

function compareAndOverlay(guessImageData) {
    const tolerance = DIFFICULTY[game.difficulty].colorTolerance;
    const targetData = game.targetImageData.data;
    const guessData = guessImageData.data;
    const currentData = game.currentImageData.data;
    
    for (let i = 0; i < targetData.length; i += 4) {
        const diffR = Math.abs(targetData[i] - guessData[i]);
        const diffG = Math.abs(targetData[i + 1] - guessData[i + 1]);
        const diffB = Math.abs(targetData[i + 2] - guessData[i + 2]);
        
        if (diffR <= tolerance && diffG <= tolerance && diffB <= tolerance) {
            currentData[i] = targetData[i];
            currentData[i + 1] = targetData[i + 1];
            currentData[i + 2] = targetData[i + 2];
            currentData[i + 3] = 255;
        }
    }
}

// UI Updates
function updateAttemptCounter() {
    elements.attemptCounter.textContent = `${game.attempts}/${game.maxAttempts}`;
}

function clearGuessList() {
    const noGuesses = langManager ? langManager.get('noGuesses') : 'Noch keine Versuche';
    elements.guessList.innerHTML = `<div class="no-guesses">${noGuesses}</div>`;
}

function addGuessToList(country) {
    // Leere Nachricht entfernen
    const noGuesses = elements.guessList.querySelector('.no-guesses');
    if (noGuesses) noGuesses.remove();
    
    const lang = langManager ? langManager.currentLang : 'de';
    const item = document.createElement('div');
    item.className = 'guess-item';
    item.innerHTML = `
        <img src="${getFlagUrl(country.code)}" class="guess-flag" alt="${getCountryName(country, lang)}">
        <span class="guess-name">${getCountryName(country, lang)}</span>
    `;
    
    elements.guessList.appendChild(item);
    
    // Animation
    setTimeout(() => item.classList.add('show'), 10);
}

// Spiel beenden
function endGame(won) {
    game.gameOver = true;
    const elapsedTime = stopTimer();
    
    elements.input.disabled = true;
    elements.guessBtn.disabled = true;
    
    // Vollständige Flagge im Modal anzeigen
    const resultCtx = elements.resultCanvas.getContext('2d');
    const img = new Image();
    img.crossOrigin = 'anonymous';
    img.onload = () => {
        resultCtx.drawImage(img, 0, 0, elements.resultCanvas.width, elements.resultCanvas.height);
    };
    img.src = getFlagUrl(game.targetCountry.code);
    
    // Texte aktualisieren
    const lang = langManager ? langManager.currentLang : 'de';
    const countryName = getCountryName(game.targetCountry, lang);
    const timeStr = getTimeString(elapsedTime);
    const timeLabel = langManager ? langManager.get('time') : 'Zeit:';
    
    if (won) {
        elements.resultTitle.textContent = langManager ? langManager.get('congratulations') : '🎉 Glückwunsch!';
        elements.resultTitle.style.background = 'linear-gradient(135deg, var(--success), #059669)';
        
        const attemptsWord = game.attempts === 1 ?
            (langManager ? langManager.get('attempt') : 'Versuch') :
            (langManager ? langManager.get('attempts') : 'Versuchen');
        
        let text = langManager ? langManager.get('wonText') : 'Sie haben {country} in {attempts} {attemptsWord} erraten!';
        text = text.replace('{country}', countryName)
                   .replace('{attempts}', game.attempts)
                   .replace('{attemptsWord}', attemptsWord);
        
        elements.resultText.innerHTML = `${text}<br><br><strong style="color: var(--accent-primary);">${timeLabel} ${timeStr} ⏱️</strong>`;
    } else {
        elements.resultTitle.textContent = langManager ? langManager.get('gameOver') : '😔 Spiel vorbei!';
        elements.resultTitle.style.background = 'linear-gradient(135deg, var(--error), #dc2626)';
        
        let text = langManager ? langManager.get('lostText') : 'Die richtige Antwort war {country}.';
        text = text.replace('{country}', countryName);
        
        elements.resultText.innerHTML = `${text}<br><br><strong style="color: var(--text-secondary);">${timeLabel} ${timeStr} ⏱️</strong>`;
    }
    
    elements.resultTitle.style.webkitBackgroundClip = 'text';
    elements.resultTitle.style.webkitTextFillColor = 'transparent';
    elements.resultTitle.style.backgroundClip = 'text';
    
    // Share-Buttons hinzufügen
    addShareButtons(won, elapsedTime, countryName);
    
    showModal(elements.resultModal);
}

// Share-Funktionen
function addShareButtons(won, elapsedTime, countryName) {
    const shareContainer = document.getElementById('shareButtons');
    if (!shareContainer) return;
    
    const timeStr = getTimeString(elapsedTime);
    const shareUrl = window.location.href;
    const attempts = won ? `${game.attempts}/${game.maxAttempts}` : 'X';
    const shareText = `FlagGuess ${attempts} in ${timeStr}!\n\nErraten: ${countryName}\n\n👉 ${shareUrl}`;
    
    const copyText = langManager ? langManager.get('copyLink') : 'Link kopieren';
    const whatsappText = langManager ? langManager.get('shareWhatsApp') : 'WhatsApp';
    const facebookText = langManager ? langManager.get('shareFacebook') : 'Facebook';
    
    shareContainer.innerHTML = `
        <button class="share-btn share-primary" onclick="copyShareLink()">
            📋 ${copyText}
        </button>
        <div style="display: flex; gap: 10px;">
            <button class="share-btn share-secondary" onclick="shareWhatsApp()" style="flex: 1;">
                📱 ${whatsappText}
            </button>
            <button class="share-btn share-secondary" onclick="shareFacebook()" style="flex: 1;">
                👍 ${facebookText}
            </button>
        </div>
    `;
    
    // Globale Funktionen
    window.copyShareLink = async () => {
        try {
            await navigator.clipboard.writeText(shareUrl);
            const msg = langManager ? langManager.get('linkCopied') : '✓ Link kopiert!';
            showNotification(msg, 'success');
        } catch (err) {
            console.error('Fehler beim Kopieren:', err);
        }
    };
    
    window.shareWhatsApp = () => {
        const url = `https://wa.me/?text=${encodeURIComponent(shareText)}`;
        window.open(url, '_blank');
    };
    
    window.shareFacebook = () => {
        const url = `https://www.facebook.com/sharer/sharer.php?u=${encodeURIComponent(shareUrl)}`;
        window.open(url, '_blank', 'width=600,height=400');
    };
}

// Vorheriges Land anzeigen
function showPreviousCountry(country) {
    const lang = langManager ? langManager.currentLang : 'de';
    const text = langManager ? langManager.get('previousGameWas') : 'Das vorherige Land war:';
    
    elements.previousPopup.innerHTML = `
        <div class="popup-content">
            <div class="popup-text">${text}</div>
            <div class="popup-country">
                <img src="${getFlagUrl(country.code)}" class="popup-flag" alt="${getCountryName(country, lang)}">
                <span class="popup-name">${getCountryName(country, lang)}</span>
            </div>
        </div>
    `;
    
    elements.previousPopup.classList.remove('hidden');
    setTimeout(() => elements.previousPopup.classList.add('show'), 10);
    
    setTimeout(() => {
        elements.previousPopup.classList.remove('show');
        setTimeout(() => elements.previousPopup.classList.add('hidden'), 300);
    }, 3000);
}

// Modal-Funktionen
function showModal(modal) {
    modal.classList.remove('hidden');
}

function hideModal(modal) {
    modal.classList.add('hidden');
}

// Benachrichtigungen
function showNotification(message, type = 'info') {
    const notification = document.createElement('div');
    notification.className = `notification notification-${type}`;
    notification.textContent = message;
    
    document.body.appendChild(notification);
    
    setTimeout(() => notification.classList.add('show'), 10);
    
    setTimeout(() => {
        notification.classList.remove('show');
        setTimeout(() => notification.remove(), 300);
    }, 3000);
}

// Read More Button für SEO Content
document.addEventListener('DOMContentLoaded', () => {
    const readMoreBtn = document.getElementById('readMoreBtn');
    const seoContent = document.querySelector('.seo-content');
    const readMoreText = document.getElementById('readMoreText');
    
    if (readMoreBtn && seoContent) {
        readMoreBtn.addEventListener('click', () => {
            seoContent.classList.toggle('expanded');
            
            if (seoContent.classList.contains('expanded')) {
                readMoreText.textContent = 'Weniger lesen';
            } else {
                readMoreText.textContent = 'Mehr lesen';
                // Scroll zurück zum Titel
                seoContent.scrollIntoView({ behavior: 'smooth', block: 'start' });
            }
        });
    }
    
    // About Link im Footer
    const aboutLinkFooter = document.getElementById('aboutLinkFooter');
    const aboutModal = document.getElementById('aboutModal');
    
    if (aboutLinkFooter && aboutModal) {
        aboutLinkFooter.addEventListener('click', (e) => {
            e.preventDefault();
            showModal(aboutModal);
        });
    }
});
