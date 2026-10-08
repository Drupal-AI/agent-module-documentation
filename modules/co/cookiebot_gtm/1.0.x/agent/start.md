<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cookiebot + GTM (cookiebot_gtm) — agent index

Injects **both** the Cookiebot consent script and the **Google Tag Manager** container loader into
every non-admin page, optionally emitting **Google Consent Mode** defaults so GTM tags respect the
consent categories the visitor chose. Version **1.0.20**, core `^8.8 || ^9 || ^10 || ^11`, no
dependencies, no PHP requirement declared. Config behind the dedicated **`access cookiebot gtm
config`** permission (`restrict access: TRUE`). Configure at `/admin/config/cookiebot_gtm`.

## What it actually does (all in `cookiebot_gtm.module`)
- **`hook_page_attachments_alter()`** — the injection point. Returns early on admin routes
  (`router.admin_context`), and early if `cbid` **or** the resolved GTM id is empty. Otherwise it
  attaches three `html_tag` render elements to `#attached['html_head']`:
  1. **(optional) Consent Mode script** (`cookiebot_gtm_cm`), only when `consent_mode_enabled`. An
     inline `gtag("consent","default",{…})` with each signal (`ad_personalization`, `ad_storage`,
     `ad_user_data`, `analytics_storage`, `functionality_storage`, `personalization_storage`) set to
     `granted`/`denied` from booleans; `security_storage:"granted"`, `wait_for_update:500`,
     `ads_data_redaction`/`url_passthrough` set. Carries `data-cookieconsent="ignore"`.
  2. **GTM loader script** (`cookiebot_gtm_gtm`) — the standard GTM snippet, built as a raw string and
     wrapped in `Markup::create()`. Interpolates `gtm_hostname` (default
     `https://www.googletagmanager.com`), the resolved GTM id, and an optional environment query
     (`&gtm_auth=…&gtm_preview=…&gtm_cookies_win=x`). Tagged `data-cookieconsent="ignore"`.
  3. **Cookiebot script** (`cookiebot_gtm_cbid`) — `<script id="Cookiebot"
     src="https://consent.cookiebot.com/uc.js" data-cbid="…" data-blockingmode="auto|manual">`. When
     Consent Mode is on it also sends `data-consentmode-defaults="disabled"`; when `use_multilingual`
     is on it adds `data-culture="<UPPER LANGID>"`.
- **`hook_preprocess_html()`** — adds the GTM **`<noscript>` iframe** to `page_top` via the
  `cookiebot_gtm_noscript` theme (template `templates/cookiebot-gtm-noscript.html.twig`). Same admin
  early-return. Renders `gtmhostname`, `gtmid`, `gtmparams` — **all with Twig `|raw`**.
- **`hook_theme()`** registers `cookiebot_gtm_declaration` and `cookiebot_gtm_noscript`.
- **`cookiebot_gtm_prepare_query()`** builds the `gtm_auth`/`gtm_preview` query from
  `gtm_environment_id` + `gtm_environment_token` (returns empty string unless **both** are set); the
  values are `json_encode`d then trimmed of surrounding quotes.
- Adds cache tag **`cookiebot_gtm:cbid`** to every page it touches.

## Where the IDs come from / CDN
- All values come from the config object **`cookiebot_gtm.cookiebot_gtm_config`** (see
  `agent/config/settings.md`). **The module ships no config schema and no `config/install`** — the
  object is created only when the form is first saved (`drush cget` errors until then).
- **`cbid`** is the Cookiebot Domain Group Id (UUID form). **`gtm_id`** is the GTM container id,
  pattern-validated `^GTM-[A-Z0-9]{1,8}$`. Scripts load from Cookiebot's CDN
  (`consent.cookiebot.com`) and Google's (`googletagmanager.com`) — expected third-party/supply-chain
  reliance for any consent+tag-manager setup.

## Multilingual
- `use_multilingual` → passes the current language to the Cookiebot banner (`data-culture`) and to the
  `/cookie-declaration` page. `use_multilingual_gtm_id` → uses a per-language container id
  `gtm_id_<langid>` instead of the single `gtm_id`.

## Routes
- `cookiebot_gtm.cookiebot_gtm_config_form` — `/admin/config/cookiebot_gtm`, `_form`, permission
  **`access cookiebot gtm config`**, `_admin_route: TRUE`. Menu link under System.
- `cookiebot_gtm.cookie_declaration_controller_showPage` — **`/cookie-declaration`**, permission
  `access content` (public by design). `CookieDeclarationController::showPage()` renders the
  `cookiebot_gtm_declaration` theme: a `<script id="CookieDeclaration"
  src="https://consent.cookiebot.com/<cbid>/cd.js">` (cbid is Twig-auto-escaped here, not `|raw`).

## Operating cautions (any consent + tag-manager setup)
- **The consent join lives in each GTM tag's trigger / Consent Mode, not in this module.** This module
  loads both scripts and can emit Consent Mode defaults; it does **not** stop a GTM tag that ignores
  consent. Tag inventory is a recurring governance task.
- **The two loader scripts carry `data-cookieconsent="ignore"`** so Cookiebot's auto-blocking does not
  block GTM itself — deliberate; consent is expected to be enforced downstream (per-tag / Consent
  Mode), not by blocking the container.
- **Anything Drupal attaches outside GTM is ungoverned by this.** A module adding an analytics script
  through Drupal's asset system is not subject to any of this.

## Files
- `agent/config/settings.md` — every config key, the form fields, and validation.

Peers in this campaign: `axeptio`, `gdpr_onetrust`, `tealiumiq`.
