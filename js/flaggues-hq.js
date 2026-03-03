// ── FlagGuess HQ Integration ──────────────────────────────────────
// 1) Error Tracking  → POST /api/errors   (site_id = 'flaggues')
// 2) Kontakt-Modal   → POST /api/contact  (site_id = 'flaggues')
// Cooldown: 1 Nachricht alle 24h (localStorage)
(function () {
  var API = 'https://webcontrol-hq-api.karol-paschek.workers.dev';
  var SITE = 'flaggues';
  var COOLDOWN_KEY = 'flaggues_contact_cooldown';
  var COOLDOWN_MS  = 24 * 60 * 60 * 1000; // 24 Stunden

  // ── Sprache erkennen ────────────────────────────────────────────
  function getLang() {
    var saved = localStorage.getItem('flagguess-language');
    if (saved) return saved;
    var html = document.documentElement.lang;
    if (html) return html.substring(0, 2);
    return navigator.language.substring(0, 2) === 'de' ? 'de' : 'en';
  }

  var T = {
    de: {
      link:        'Kontakt',
      title:       'Nachricht senden',
      namePlaceholder: 'Dein Name (optional)',
      msgPlaceholder:  'Deine Nachricht…',
      send:        'Senden',
      sending:     'Wird gesendet…',
      success:     '✓ Nachricht gesendet! Danke.',
      errShort:    'Nachricht zu kurz (min. 10 Zeichen).',
      errCooldown: 'Du hast bereits eine Nachricht gesendet. Bitte warte 24 Stunden.',
      errFail:     'Fehler beim Senden. Bitte versuche es später.',
      close:       'Schließen',
    },
    en: {
      link:        'Contact',
      title:       'Send a message',
      namePlaceholder: 'Your name (optional)',
      msgPlaceholder:  'Your message…',
      send:        'Send',
      sending:     'Sending…',
      success:     '✓ Message sent! Thank you.',
      errShort:    'Message too short (min. 10 characters).',
      errCooldown: 'You already sent a message. Please wait 24 hours.',
      errFail:     'Failed to send. Please try again later.',
      close:       'Close',
    },
  };

  function t(key) {
    var lang = getLang();
    return (T[lang] || T.en)[key] || T.en[key];
  }

  // ── 1) ERROR TRACKING ────────────────────────────────────────────
  var _sent = {};

  function sendError(error_type, message, stack) {
    var msg = String(message || '').slice(0, 500);
    var key = error_type + ':' + msg;
    if (_sent[key]) return;
    _sent[key] = 1;
    fetch(API + '/api/errors', {
      method:      'POST',
      headers:     { 'Content-Type': 'application/json' },
      body:        JSON.stringify({
        site_id:    SITE,
        error_type: error_type,
        message:    msg,
        stack:      stack ? String(stack).slice(0, 2000) : null,
        path:       window.location.pathname,
      }),
      credentials: 'omit',
      keepalive:   true,
    }).catch(function () {});
  }

  window.addEventListener('error', function (e) {
    var msg   = e.message || 'Unknown error';
    var stack = (e.error && e.error.stack)
      ? e.error.stack
      : (e.filename ? e.filename + ':' + e.lineno + ':' + e.colno : null);
    sendError('js_error', msg, stack);
  });

  window.addEventListener('unhandledrejection', function (e) {
    var r = e.reason;
    sendError('unhandled_promise',
      r instanceof Error ? r.message : String(r),
      r instanceof Error ? r.stack   : null);
  });

  var _origError = console.error.bind(console);
  console.error = function () {
    _origError.apply(console, arguments);
    var args   = Array.prototype.slice.call(arguments);
    var msg    = args.map(function (a) { return a instanceof Error ? a.message : String(a); }).join(' ');
    var errObj = null;
    for (var i = 0; i < args.length; i++) { if (args[i] instanceof Error) { errObj = args[i]; break; } }
    sendError('console_error', msg, errObj ? errObj.stack : null);
  };

  // ── 2) KONTAKT-MODAL ────────────────────────────────────────────

  // Modal-Styles (passt zum bestehenden dark-theme)
  var style = document.createElement('style');
  style.textContent = [
    '#fg-contact-overlay{display:none;position:fixed;inset:0;z-index:9999;background:rgba(0,0,0,.7);',
    'align-items:center;justify-content:center;}',
    '#fg-contact-overlay.fg-open{display:flex;}',
    '#fg-contact-box{background:#1a1a2e;border:1px solid rgba(255,255,255,.12);border-radius:14px;',
    'padding:28px 24px;width:100%;max-width:420px;position:relative;box-shadow:0 8px 40px rgba(0,0,0,.5);}',
    '#fg-contact-box h3{margin:0 0 18px;font-size:17px;font-weight:700;color:#f1f1f1;}',
    '#fg-contact-box input,#fg-contact-box textarea{width:100%;box-sizing:border-box;',
    'background:rgba(255,255,255,.07);border:1px solid rgba(255,255,255,.14);border-radius:8px;',
    'color:#f1f1f1;font-size:13px;padding:10px 12px;margin-bottom:10px;outline:none;resize:vertical;',
    'font-family:inherit;}',
    '#fg-contact-box textarea{min-height:90px;}',
    '#fg-contact-box input::placeholder,#fg-contact-box textarea::placeholder{color:rgba(255,255,255,.35);}',
    '#fg-contact-send{width:100%;padding:11px;background:#ef4444;border:none;border-radius:8px;',
    'color:#fff;font-size:13px;font-weight:700;cursor:pointer;transition:opacity .15s;}',
    '#fg-contact-send:hover{opacity:.85;}',
    '#fg-contact-send:disabled{opacity:.5;cursor:default;}',
    '#fg-contact-msg{font-size:12px;margin-top:8px;min-height:18px;text-align:center;}',
    '#fg-contact-close{position:absolute;top:12px;right:14px;background:none;border:none;',
    'color:rgba(255,255,255,.5);font-size:20px;cursor:pointer;line-height:1;padding:2px 6px;}',
    '#fg-contact-close:hover{color:#fff;}',
  ].join('');
  document.head.appendChild(style);

  // Modal HTML
  var overlay = document.createElement('div');
  overlay.id = 'fg-contact-overlay';
  overlay.innerHTML = [
    '<div id="fg-contact-box">',
    '  <button id="fg-contact-close" aria-label="Close">&times;</button>',
    '  <h3 id="fg-contact-title"></h3>',
    '  <input  id="fg-contact-name" type="text" maxlength="60">',
    '  <textarea id="fg-contact-msg-input" maxlength="1000"></textarea>',
    '  <button id="fg-contact-send"></button>',
    '  <div id="fg-contact-msg"></div>',
    '</div>',
  ].join('');
  document.body.appendChild(overlay);

  function updateTexts() {
    var el = function(id) { return document.getElementById(id); };
    el('fg-contact-title').textContent        = t('title');
    el('fg-contact-name').placeholder         = t('namePlaceholder');
    el('fg-contact-msg-input').placeholder    = t('msgPlaceholder');
    el('fg-contact-send').textContent         = t('send');
    el('fg-contact-msg').textContent          = '';
  }

  function openContactModal() {
    updateTexts();
    overlay.classList.add('fg-open');
    document.getElementById('fg-contact-msg-input').focus();
  }
  function closeContactModal() {
    overlay.classList.remove('fg-open');
  }

  document.getElementById('fg-contact-close').addEventListener('click', closeContactModal);
  overlay.addEventListener('click', function (e) { if (e.target === overlay) closeContactModal(); });

  document.getElementById('fg-contact-send').addEventListener('click', function () {
    var name    = (document.getElementById('fg-contact-name').value || '').trim();
    var message = (document.getElementById('fg-contact-msg-input').value || '').trim();
    var msgEl   = document.getElementById('fg-contact-msg');
    var btn     = document.getElementById('fg-contact-send');

    if (message.length < 10) {
      msgEl.style.color = '#f87171';
      msgEl.textContent = t('errShort');
      return;
    }

    // Cooldown prüfen
    var last = parseInt(localStorage.getItem(COOLDOWN_KEY) || '0', 10);
    if (Date.now() - last < COOLDOWN_MS) {
      msgEl.style.color = '#f87171';
      msgEl.textContent = t('errCooldown');
      return;
    }

    btn.disabled    = true;
    btn.textContent = t('sending');
    msgEl.textContent = '';

    fetch(API + '/api/contact', {
      method:      'POST',
      headers:     { 'Content-Type': 'application/json' },
      body:        JSON.stringify({
        site_id:  SITE,
        name:     name || 'Anonym',
        message:  message,
        language: getLang(),
      }),
      credentials: 'omit',
    })
    .then(function (r) { return r.json(); })
    .then(function (data) {
      if (data && data.success) {
        localStorage.setItem(COOLDOWN_KEY, Date.now().toString());
        msgEl.style.color = '#4ade80';
        msgEl.textContent = t('success');
        document.getElementById('fg-contact-name').value = '';
        document.getElementById('fg-contact-msg-input').value = '';
        setTimeout(closeContactModal, 2000);
      } else {
        throw new Error(data && data.error ? data.error : 'error');
      }
    })
    .catch(function () {
      msgEl.style.color = '#f87171';
      msgEl.textContent = t('errFail');
    })
    .finally(function () {
      btn.disabled    = false;
      btn.textContent = t('send');
    });
  });

  // ── Kontakt-Link in alle Footer einbauen ─────────────────────────
  function injectContactLinks() {
    document.querySelectorAll('.footer-links').forEach(function (footerLinks) {
      // Nicht doppelt einfügen
      if (footerLinks.querySelector('.fg-contact-link')) return;

      var sep  = document.createElement('span');
      sep.className = 'footer-separator';
      sep.textContent = '·';

      var link = document.createElement('a');
      link.href = '#';
      link.className = 'footer-link fg-contact-link';
      link.textContent = t('link');
      link.addEventListener('click', function (e) { e.preventDefault(); openContactModal(); });

      footerLinks.appendChild(sep);
      footerLinks.appendChild(link);
    });
  }

  // Nach DOM-Ready ausführen
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', injectContactLinks);
  } else {
    injectContactLinks();
  }

  // Global verfügbar machen (falls manuell aufgerufen werden soll)
  window.openFlagGuessContact = openContactModal;
})();
