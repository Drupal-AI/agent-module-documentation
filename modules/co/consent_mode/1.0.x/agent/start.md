<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Consent Mode (consent_mode) — agent index

Emits `gtag('consent','default', …)` with configurable values ahead of other Google tags.
Core `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version **1.0.6**. No module dependencies
(library depends on `core/drupalSettings`). No plugins, no entities, no services, no Drush, no
config schema (install defaults only).

- **Install, the one config object + all keys, the form/route/permission, and how the script is
  injected and reaches gtag** → [config/settings.md](config/settings.md)

## What it actually is

- One hook: `consent_mode_page_attachments_alter()` in `consent_mode.module`. When
  `consent_mode_enabled` is set it coerces each of the six signal booleans to the string
  `'granted'`/`'denied'`, puts them under `drupalSettings['consent_mode']`, and attaches library
  `consent_mode/consent_mode`.
- One library: `consent_mode` (`consent_mode.libraries.yml`, **`header: true`**) loading the static
  file `js/consent_mode.js`, which calls `gtag('consent','default', {...})` reading
  `drupalSettings.consent_mode.*` (plus fixed `security_storage:'granted'`, `wait_for_update:500`,
  `ads_data_redaction:true`, `url_passthrough:false`).
- One form: `\Drupal\consent_mode\Form\ConsentModeConfigForm` (`ConfigFormBase`), seven checkboxes,
  editing config `consent_mode.consent_mode_config`.
- One route: `consent_mode.consent_mode_config_form` at **`/admin/config/consent_mode`**, permission
  **`access consent mode config`**, `_admin_route: TRUE`. Menu link under
  *Configuration → System* (`consent_mode.links.menu.yml`).
- One permission: `access consent mode config` (`consent_mode.permissions.yml`) — no
  `restrict access`, so it is delegable.

## Config object `consent_mode.consent_mode_config`

All booleans, **all consent signals denied by default** except the master switch (from
`config/install/consent_mode.consent_mode_config.yml`):
`consent_mode_enabled: 1`, `ad_personalization: 0`, `ad_storage: 0`, `ad_user_data: 0`,
`analytics_storage: 0`, `functionality_storage: 0`, `personalization_storage: 0`.
There is **no `config/schema/`** — nothing types these keys.

## The one thing to always say

**This module sets defaults only.** It does not collect consent and never sends
`gtag('consent','update')`. A CMP or banner must send the update, or the site denies forever —
compliant, but analytics will read near zero. Say this whenever recommending it standalone.
