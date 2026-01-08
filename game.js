// Spiel-Zustand
let gameState = {
    targetCountry: null,
    attempts: 0,
    maxAttempts: 5,
    guesses: [],
    gameOver: false,
    targetImageData: null,
    currentCanvas: null
};

// Canvas Elemente
const targetCanvas = document.getElementById('targetCanvas');
const targetCtx = targetCanvas.getContext('2d', { willReadFrequently: true });

// UI Elemente
const countryInput = document.getElementById('countryInput');
const guessBtn = document.getElementById('guessBtn');
const newGameBtn = document.getElementById('newGameBtn');
const attemptCounter = document.getElementById('attemptCounter');
const guessList = document.getElementById('guessList');
const resultModal = document.getElementById('resultModal');
const resultTitle = document.getElementById('resultTitle');
const resultText = document.getElementById('resultText');
const playAgainBtn = document.getElementById('playAgainBtn');
const resultCanvas = document.getElementById('resultCanvas');

// Init
document.addEventListener('DOMContentLoaded', () => {
    populateDatalist();
    initGame();
    setupEventListeners();
});

function setupEventListeners() {
    guessBtn.addEventListener('click', handleGuess);
    countryInput.addEventListener('keypress', (e) => {
        if (e.key === 'Enter') handleGuess();
    });
    newGameBtn.addEventListener('click', initGame);
    playAgainBtn.addEventListener('click', () => {
        resultModal.classList.add('hidden');
        initGame();
    });
    
    // Modal Overlay Click zum Schließen
    resultModal.addEventListener('click', (e) => {
        if (e.target === resultModal || e.target.classList.contains('modal-overlay')) {
            resultModal.classList.add('hidden');
            initGame();
        }
    });
}

function initGame() {
    gameState = {
        targetCountry: getRandomCountry(),
        attempts: 0,
        maxAttempts: 5,
        guesses: [],
        gameOver: false,
        targetImageData: null,
        currentCanvas: null
    };

    // Canvas leeren (weißer Hintergrund)
    targetCtx.fillStyle = 'white';
    targetCtx.fillRect(0, 0, targetCanvas.width, targetCanvas.height);

    // Zielflagge laden (aber nicht anzeigen)
    loadTargetFlag();

    // UI zurücksetzen
    countryInput.value = '';
    countryInput.disabled = false;
    guessBtn.disabled = false;
    guessList.innerHTML = '<div style="padding: 20px; text-align: center; color: var(--text-tertiary); font-size: 0.9rem;">Noch keine Versuche</div>';
    updateAttemptCounter();

    // Focus auf Input
    setTimeout(() => countryInput.focus(), 100);

    console.log('🎯 Ziel-Land:', gameState.targetCountry.name);
}

function loadTargetFlag() {
    const img = new Image();
    img.crossOrigin = 'anonymous';
    img.onload = () => {
        // Temporäres Canvas für Ziel-Flagge
        const tempCanvas = document.createElement('canvas');
        tempCanvas.width = targetCanvas.width;
        tempCanvas.height = targetCanvas.height;
        const tempCtx = tempCanvas.getContext('2d', { willReadFrequently: true });
        
        tempCtx.drawImage(img, 0, 0, targetCanvas.width, targetCanvas.height);
        gameState.targetImageData = tempCtx.getImageData(0, 0, targetCanvas.width, targetCanvas.height);

        // Aktuelles Canvas initialisieren (komplett weiß)
        gameState.currentCanvas = targetCtx.createImageData(targetCanvas.width, targetCanvas.height);
        const data = gameState.currentCanvas.data;
        for (let i = 0; i < data.length; i += 4) {
            data[i] = 255;     // R
            data[i + 1] = 255; // G
            data[i + 2] = 255; // B
            data[i + 3] = 255; // A
        }
    };
    img.onerror = () => {
        console.error('Fehler beim Laden der Flagge:', gameState.targetCountry.name);
        alert('Fehler beim Laden der Flagge. Bitte versuchen Sie es erneut.');
        initGame();
    };
    img.src = getFlagUrl(gameState.targetCountry.code);
}

function handleGuess() {
    if (gameState.gameOver) return;

    const guessName = countryInput.value.trim();
    if (!guessName) {
        showNotification('Bitte geben Sie ein Land ein!', 'error');
        return;
    }

    const guessCountry = findCountryByName(guessName);
    if (!guessCountry) {
        showNotification('Land nicht gefunden! Bitte wählen Sie ein Land aus der Liste.', 'error');
        return;
    }

    // Prüfen ob Land schon geraten wurde
    if (gameState.guesses.some(g => g.code === guessCountry.code)) {
        showNotification('Dieses Land haben Sie bereits geraten!', 'error');
        return;
    }

    gameState.attempts++;
    gameState.guesses.push(guessCountry);

    // Leere Meldung entfernen
    const emptyMessage = guessList.querySelector('div[style*="padding"]');
    if (emptyMessage) {
        guessList.innerHTML = '';
    }

    // Flagge laden und vergleichen
    loadAndCompareFlag(guessCountry);

    // UI aktualisieren
    updateAttemptCounter();
    addGuessToList(guessCountry);
    countryInput.value = '';
    countryInput.focus();

    // Prüfen ob richtig geraten
    if (guessCountry.code === gameState.targetCountry.code) {
        setTimeout(() => endGame(true), 500);
    } else if (gameState.attempts >= gameState.maxAttempts) {
        setTimeout(() => endGame(false), 500);
    }
}

function loadAndCompareFlag(guessCountry) {
    const img = new Image();
    img.crossOrigin = 'anonymous';
    img.onload = () => {
        // Guess-Flagge auf temporäres Canvas zeichnen
        const tempCanvas = document.createElement('canvas');
        tempCanvas.width = targetCanvas.width;
        tempCanvas.height = targetCanvas.height;
        const tempCtx = tempCanvas.getContext('2d', { willReadFrequently: true });
        
        tempCtx.drawImage(img, 0, 0, targetCanvas.width, targetCanvas.height);
        const guessImageData = tempCtx.getImageData(0, 0, targetCanvas.width, targetCanvas.height);

        // Pixel-Vergleich und Überlagerung
        overlayGuess(gameState.targetImageData, guessImageData);

        // Aktualisiertes Canvas anzeigen mit Animation
        targetCtx.putImageData(gameState.currentCanvas, 0, 0);
    };
    img.onerror = () => {
        console.error('Fehler beim Laden der Guess-Flagge:', guessCountry.name);
    };
    img.src = getFlagUrl(guessCountry.code);
}

function overlayGuess(targetImageData, guessImageData) {
    const width = targetCanvas.width;
    const height = targetCanvas.height;

    const targetData = targetImageData.data;
    const guessData = guessImageData.data;
    const currentData = gameState.currentCanvas.data;

    for (let y = 0; y < height; y++) {
        for (let x = 0; x < width; x++) {
            const idx = (y * width + x) * 4;

            const tR = targetData[idx];
            const tG = targetData[idx + 1];
            const tB = targetData[idx + 2];

            const gR = guessData[idx];
            const gG = guessData[idx + 1];
            const gB = guessData[idx + 2];

            // Pixel exakt vergleichen (mit kleiner Toleranz für JPEG-Artefakte)
            const tolerance = 5;
            if (Math.abs(tR - gR) <= tolerance && 
                Math.abs(tG - gG) <= tolerance && 
                Math.abs(tB - gB) <= tolerance) {
                
                // Pixel übernehmen
                currentData[idx] = tR;
                currentData[idx + 1] = tG;
                currentData[idx + 2] = tB;
                currentData[idx + 3] = 255;
            }
        }
    }
}

function updateAttemptCounter() {
    attemptCounter.textContent = `${gameState.attempts}/${gameState.maxAttempts}`;
}

function addGuessToList(country) {
    const guessItem = document.createElement('div');
    guessItem.className = 'guess-item';
    guessItem.style.opacity = '0';
    guessItem.style.transform = 'translateY(-10px)';
    
    const flagImg = document.createElement('img');
    flagImg.src = getFlagUrl(country.code);
    flagImg.className = 'guess-flag';
    flagImg.alt = country.name;
    
    const nameSpan = document.createElement('span');
    nameSpan.className = 'guess-name';
    nameSpan.textContent = country.name;
    
    guessItem.appendChild(flagImg);
    guessItem.appendChild(nameSpan);
    guessList.appendChild(guessItem);

    // Animation
    setTimeout(() => {
        guessItem.style.transition = 'all 0.3s ease';
        guessItem.style.opacity = '1';
        guessItem.style.transform = 'translateY(0)';
    }, 10);
}

function endGame(won) {
    gameState.gameOver = true;
    countryInput.disabled = true;
    guessBtn.disabled = true;

    // Vollständige Flagge im Modal anzeigen
    const resultCtx = resultCanvas.getContext('2d');
    const img = new Image();
    img.crossOrigin = 'anonymous';
    img.onload = () => {
        resultCtx.drawImage(img, 0, 0, resultCanvas.width, resultCanvas.height);
    };
    img.src = getFlagUrl(gameState.targetCountry.code);

    if (won) {
        resultTitle.textContent = '🎉 Glückwunsch!';
        resultTitle.style.background = 'linear-gradient(135deg, var(--success), #059669)';
        resultTitle.style.webkitBackgroundClip = 'text';
        resultTitle.style.webkitTextFillColor = 'transparent';
        resultText.textContent = `Sie haben ${gameState.targetCountry.name} in ${gameState.attempts} ${gameState.attempts === 1 ? 'Versuch' : 'Versuchen'} erraten!`;
    } else {
        resultTitle.textContent = '😔 Knapp daneben!';
        resultTitle.style.background = 'linear-gradient(135deg, var(--error), #dc2626)';
        resultTitle.style.webkitBackgroundClip = 'text';
        resultTitle.style.webkitTextFillColor = 'transparent';
        resultText.textContent = `Die richtige Antwort war ${gameState.targetCountry.name}. Versuchen Sie es noch einmal!`;
    }

    resultModal.classList.remove('hidden');
}

function showNotification(message, type = 'info') {
    // Simple inline notification
    const notification = document.createElement('div');
    notification.textContent = message;
    notification.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        padding: 16px 24px;
        background: ${type === 'error' ? 'var(--error)' : 'var(--accent-primary)'};
        color: white;
        border-radius: 12px;
        box-shadow: 0 10px 15px -3px rgba(0,0,0,0.3);
        z-index: 9999;
        font-weight: 600;
        animation: slideIn 0.3s ease;
    `;
    
    document.body.appendChild(notification);
    
    setTimeout(() => {
        notification.style.animation = 'slideOut 0.3s ease';
        setTimeout(() => notification.remove(), 300);
    }, 3000);
}

// CSS für Notifications
const style = document.createElement('style');
style.textContent = `
    @keyframes slideIn {
        from {
            transform: translateX(400px);
            opacity: 0;
        }
        to {
            transform: translateX(0);
            opacity: 1;
        }
    }
    @keyframes slideOut {
        from {
            transform: translateX(0);
            opacity: 1;
        }
        to {
            transform: translateX(400px);
            opacity: 0;
        }
    }
`;
document.head.appendChild(style);
