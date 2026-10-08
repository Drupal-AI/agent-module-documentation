<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Nonce Piwik Plugin (nonce_piwik_plugin) — agent index
**Renders Piwik PRO tracking with a fresh per-request CSP nonce via the Nonce Generator plugin system.**

- **Version:** 1.0.x  **Core:** ^10 || ^11  **Depends:** nonce_generator, path_alias
- **Config route:** `nonce_piwik_plugin.settings` (`/admin/config/security/nonce-piwik-plugin`) — perm `administer site configuration`.
- **Plugin:** `Drupal\nonce_piwik_plugin\Plugin\NonceScript\PiwikScript` (a `NonceScript` provided by nonce_generator).
- **Config:** container URL, site id, data-layer name, secure/SameSite cookies, path/role/content-type filters.
- **Security:** single admin config route, permission-gated; no anonymous or mutating endpoints. The module's purpose is CSP-safe inline script delivery. Sound.
