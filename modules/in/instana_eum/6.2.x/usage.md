<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Instana EUM configures and injects the Instana End User Monitoring (EUM) beacon so real-user performance, page-load and JS-error data is reported from visitors' browsers to an Instana server.

---

An administrator supplies an API key and reporting URL on the settings form at `/admin/config/services/instana_eum` (`configure instana` permission, `restrict access: true`); optional flags toggle per-page tracking, admin-page tracking, and a free-text "advanced settings" block. When the module is enabled and an API key is set, `hook_page_attachments` attaches the `instana_eum/instana_eum_config` library and pushes the settings into `drupalSettings` on **every** page. Two supply-chain / exposure points are worth flagging: (1) the library loads the third-party agent `https://eum.instana.io/eum.min.js` on every page with `crossorigin=anonymous` but **no Subresource-Integrity hash**, so the site trusts whatever that host serves; and (2) the beacon `key` (a client-side EUM key, public by design) is emitted in `drupalSettings` in the page source — and the admin form additionally forces the key into the rendered `value` attribute of a `password` field, defeating the masking for anyone viewing the config form. Most notably, the bundled `js/instana_config.js` runs the admin-entered "advanced settings" string through `eval()` in every visitor's browser; this is admin-only input, but it is stored arbitrary JavaScript executed on all pages, so anyone who obtains the `configure instana` permission gains persistent site-wide JS execution.

Typical setup: get the Instana application's reporting URL and key, enter them on the settings form, enable the module, optionally turn on page/admin tracking, then verify beacons arrive in the Instana dashboard.
---
- Enter the Instana API key and reporting URL at `/admin/config/services/instana_eum`.
- Activate or deactivate monitoring without uninstalling via the "enabled" checkbox.
- Grant the `configure instana` permission to trusted administrators only.
- Turn on individual-page tracking to analyse per-page performance.
- Enable admin-page tracking to include `/admin` URLs (off by default).
- Report page views, load times and JS errors as real-user monitoring.
- Add extra `ineum(...)` calls through the advanced settings textarea.
- Set custom metadata (e.g. `ineum('meta', 'version', '1.42.3')`).
- Ignore selected URLs with an `ineum('ignoreUrls', [...])` rule.
- Verify beacons are arriving in the Instana dashboard.
- Point the beacon at a self-hosted / SaaS Instana reporting endpoint.
- Track user sessions (`ineum('trackSessions')` is called automatically).
- Exclude admin traffic from monitoring by leaving admin tracking off.
- Roll out EUM site-wide from a single configuration form.
- Audit the injected script by reviewing `js/instana_config.js`.
- Disable EUM instantly for incident response by unchecking "enabled".
- Rotate the reporting key by updating the API key field.
