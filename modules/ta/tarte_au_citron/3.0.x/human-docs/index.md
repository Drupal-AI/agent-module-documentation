# Tarte au citron — manual setup guide

**Tarte au citron** (`tarte_au_citron`) is a Drupal integration for the popular
[tarteaucitron.js](https://github.com/AmauriC/tarteaucitron.js) cookie-consent library.
It renders the GDPR/RGPD consent banner and preference manager, and — crucially — keeps
third-party services (analytics, ads, social widgets, embedded videos, maps, APIs) from
loading until the visitor has explicitly opted in. Consent is opt-in by default, so no
tracking scripts run for a visitor who has not agreed.

The module does **not** bundle the JavaScript library. You download tarteaucitron.js
yourself into `web/libraries/tarteaucitron/`, and the module reads the files that are
present to discover which services, options, texts, and languages are available. Because
of this, the admin forms are generated dynamically from the exact library version you
installed — what you see reflects the catalog that version ships.

Two admin forms drive everything: one configures the banner's behavior and which services
to enable, and the other manages the banner's text (default library text, a forced
language, or your own custom overrides). Three permissions gate the module: one for the
settings, one for the texts, and one that lets a role bypass the banner entirely.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable it,
   and download the tarteaucitron.js library into `/libraries`.
2. [Configuration](configuration/index.md) — the two admin forms (services/options and
   texts), the text strategies, and the permissions.

## Where it lives in the admin menu

The configuration lives under **Configuration → Tarte au citron**. The main JS/services
form is at `/admin/config/tarte_au_citron/js` and the texts form at
`/admin/config/tarte_au_citron/texts`.
