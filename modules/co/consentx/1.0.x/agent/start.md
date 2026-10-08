<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ConsentX — agent index

Info.yml name **ConsentX** (`consentx`), version **1.0.1**, package *Privacy & Consent*,
core `^9 || ^10 || ^11`, PHP >=8.1. No dependencies, no submodules, `configure: consentx.settings`.

Thin **connector to the hosted ConsentX CMP** (app.consentx.io) for a cookie-consent banner, Google
Consent Mode v2, and pre-consent script blocking (GDPR/CCPA/DPDPA). The banner, all category/cookie
text, cookie scanning, geo rules and consent logging live in the **remote embed**, not in Drupal — this
module only stores a connection and injects one `<script>`.

## What it actually does

1. **Inject the embed** — `consentx_page_attachments()` (in `consentx.module`) adds, on every
   **non-admin** page once a `site_key` is set:
   - (optional, `consent_mode` on by default) a static Google Consent Mode v2 **denied-by-default**
     `gtag('consent','default',{…})` stub, weight `-1000` so it prints first in `<head>`.
   - the embed ES module `<script type="module" src="{app_url}/api/{site_key}/embed.js" data-consentx="{site_key}">`,
     weight `-900`; adds `data-consentx-block="1"` when `block_scripts` is on.
   - cache tag `config:consentx.settings`. Admin routes are skipped via `router.admin_context`.
2. **1-click Connect handshake** — `ConnectController` (Model A):
   - `start()` mints a 32-byte state (`Crypt::randomBytesBase64(32)`) into the admin's **private
     tempstore**, then `TrustedRedirectResponse` to `{app_url}/admin/connect?client=drupal&redirect_uri=<same-host callback>&state=<state>&domain=<bare host>&site_name=<site name>`. The callback URL's host is forced to the bare `domain` so it always matches.
   - `callback()` reads `?state=&site_key=&token=`, verifies state with `hash_equals()` (constant-time),
     then saves `site_key` + `token` into `consentx.settings` config. Banner goes live immediately.
   - `disconnect()` clears `site_key`/`token` locally (does not revoke the token server-side).
3. **Manual fallback (Model C)** — the settings form's **Site key** textfield lets an admin paste a key
   from the ConsentX dashboard instead of using the handshake.

## Credentials & config

Stored in the **`consentx.settings` config object** (schema `config/schema/consentx.schema.yml`):
`app_url` (default `https://app.consentx.io`), `site_key` (''), `token` ('' — the scoped API token
returned by the handshake), `consent_mode` (true), `block_scripts` (false). Written by the connect
`callback()` and by `ConsentxSettingsForm::submitForm()`. There is no env-variable or Key-module wiring
in this module — the values live in Drupal config.

## Routes / access / permission

`consentx.routing.yml` — all four routes require permission **`administer consentx`** (defined in
`consentx.permissions.yml`, `restrict access: true`):
- `/admin/config/system/consentx` → `ConsentxSettingsForm` (also the admin menu link).
- `/admin/config/system/consentx/connect` → `start()` (`_csrf_token: TRUE`).
- `/admin/config/system/consentx/callback` → `callback()` (validated by the tempstore state, not a route token).
- `/admin/config/system/consentx/disconnect` → `disconnect()` (`_csrf_token: TRUE`).

## Files

- `consentx.module` — `hook_help`, `hook_page_attachments` (embed + Consent Mode injection).
- `src/Controller/ConnectController.php` — `start` / `callback` / `disconnect` handshake.
- `src/Form/ConsentxSettingsForm.php` — `ConfigFormBase`: connection status, Connect/Disconnect links,
  Site key field, `consent_mode` / `block_scripts` checkboxes, Advanced `app_url` override, masked-key display.
- `config/install/consentx.settings.yml`, `config/schema/consentx.schema.yml`, `consentx.links.menu.yml`,
  `consentx.permissions.yml`, `assets/consentx-logo.svg`.

Human setup guide: [`../human-docs/index.md`](../human-docs/index.md). Task list: [`../usage.md`](../usage.md).
