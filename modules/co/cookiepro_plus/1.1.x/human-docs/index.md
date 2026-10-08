# CookiePro Plus — manual setup guide

**CookiePro Plus** (`cookiepro_plus`) connects your Drupal 11 site to
[CookiePro by OneTrust](https://www.cookiepro.com/), a hosted cookie-consent
platform. Once you paste in your OneTrust "Script ID", the module injects the
CookiePro consent banner and preference center into your front-end pages, so you
can offer GDPR/ePrivacy-style cookie consent backed by OneTrust's cookie scanning
and category data — without hand-coding any script tags.

Beyond the basic banner, it wires up the pieces most sites actually need:
**Auto-Blocking™** (so third-party cookies stay blocked until the visitor
consents), **Google Consent Mode** (emitting the default "denied" storage states),
and automatic page-language detection so the banner shows in the right language. It
is careful about *where* the script runs — never on admin pages (so editors are
never nagged), and you can further limit it to specific paths, exclude paths, or
whitelist internal/QA IP ranges that should bypass consent entirely.

For editors, the module ships three embeddable controls — the **OneTrust cookie
list**, an **"open cookie preferences" button**, and an inline **"cookie settings"
link** — each available both as a block and as a token you can drop into content.
There is also a "pause mode" for temporarily switching the banner off without
losing your settings, and per-language configuration overrides for multi-domain
multilingual sites.

All configuration is gated behind a dedicated, restricted permission, and the
central logic is exposed as a service with an event that lets other modules swap
the active script at runtime.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead — they cover every config key, the
service API, the event, and the blocks/tokens in depth.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and note the suggested companion modules.
2. [Configuration](configuration/index.md) — the settings form field by field,
   including the important security note about the shipped IP whitelist.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → CookiePro Plus**
(`/admin/config/system/cookiepro-plus`). Access is controlled by the **Administer
CookiePro Plus configuration** permission (a restricted permission — grant it only
to trusted administrators).

## How to use it

1. Get your **Script ID** (the `data-domain-script` value) from your OneTrust /
   CookiePro account.
2. Enter it on the CookiePro Plus settings form, choose your CDN domain, and turn
   on Auto-Blocking and/or Google Consent Mode if you use them.
3. **Review the shipped IP whitelist** — the module installs with a default IP
   range that should be cleared or replaced (see
   [Configuration](configuration/index.md#ip-whitelist-important-security-note)).
4. Optionally, place the cookie-list, preferences-button, or settings-link blocks
   (or their tokens) wherever you want visitors to review or change their choices.

Full field-by-field details are in [Configuration](configuration/index.md).
