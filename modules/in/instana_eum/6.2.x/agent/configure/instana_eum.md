<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# instana_eum — configuration

## Settings form (`/admin/config/services/instana_eum`, `InstanaConfigForm`)
Config object `instana_eum.settings`:
- `enabled` (checkbox) — master on/off without uninstalling.
- `api_key` (password field, required) — Instana beacon key. NB the form sets `#attributes['value']` to the stored key, so it renders in cleartext in the form HTML.
- `reporting_url` (textfield, required) — Instana reporting endpoint (default `https://eum-green-saas.instana.io`).
- `track_pages` (checkbox) — call `ineum('page', location.pathname)`.
- `track_admin` (checkbox) — when off, `ineum('ignoreUrls', [/.*\/admin\/.*/])`.
- `advanced_settings` (textarea) — free-text JS run via `eval()` client-side.

## Injection (`instana_eum_page_attachments`)
Only attaches when `api_key !== ''` **and** `enabled === TRUE`. Pushes all settings into `drupalSettings.instana_eum` and attaches library `instana_eum/instana_eum_config`, which loads local `js/instana_config.js` plus external `https://eum.instana.io/eum.min.js` (external, `defer`, `crossorigin=anonymous`, no SRI).

## Client bootstrap (`js/instana_config.js`)
Initialises the `ineum` queue, sets `reportingUrl` and `key` from drupalSettings, calls `trackSessions`, conditionally ignores `/admin/*` and tracks the page, then `eval(advancedSettings)` inside a try/catch.

## Hardening tips
- Treat `configure instana` as high-privilege (arbitrary JS via `advanced_settings` → `eval`). Keep it on admins only.
- Consider pinning an SRI hash for the external agent if serving it locally is not an option.
- The EUM key is a public client-side key by design, but avoid exposing the admin config form to semi-trusted roles.
