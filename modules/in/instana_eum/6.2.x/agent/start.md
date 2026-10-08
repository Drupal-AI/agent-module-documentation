<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Instana EUM (instana_eum) — agent index
**Injects the Instana End User Monitoring beacon (`eum.instana.io/eum.min.js`) on every page and reports real-user performance/error data to an Instana server.**

**Version:** 6.2.x  ·  **Core:** ^9 || ^10 || ^11  ·  **Package:** Monitoring  ·  **Configure:** `/admin/config/services/instana_eum`
- **Route:** `instana_eum.settings` (`_permission: configure instana`, `_admin_route`).
- **Permission:** `configure instana` (`restrict access: true`).
- **Behaviour:** `hook_page_attachments` attaches `instana_eum/instana_eum_config` + `drupalSettings` when enabled and an API key is set; the library pulls the external `https://eum.instana.io/eum.min.js`.
- **Security:** SUPPLY-CHAIN — external agent JS loaded on every page with `crossorigin=anonymous` but **no SRI integrity hash**. The EUM `key` is emitted in `drupalSettings` (client-side by design) and the admin form forces it into the `value` attribute of a `password` field (masking defeated). `js/instana_config.js` runs the admin-entered `advanced_settings` through **`eval()`** in every visitor's browser → admin-gated but persistent site-wide arbitrary JS.

See [configure/instana_eum.md](configure/instana_eum.md)
