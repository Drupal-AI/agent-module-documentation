<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pigeon Paywall (pigeon_paywall) — agent index
**Wraps flagged content with the hosted Pigeon (Sabramedia) JavaScript paywall via a boolean-field formatter.**

- **Version:** 1.1.x (dev-1.1.x)
- **Core:** ^9 || ^10 || ^11
- **Package:** Commerce
- **Configure:** `pigeon_paywall.settings` (`/admin/config/services/pigeon-paywall`, perm `administer pigeon paywall`)
- **Formatter:** `pigeon_paywall_checkbox` (CheckboxPaywall) on boolean fields, full view mode.
- **Library:** external `pigeon.js` loaded from the configured subdomain (`hook_library_info_alter`).
- **Settings:** subdomain, fingerprint, idp, published_only, bypass_query_arg.

**Security:** Admin route permission-gated. The paywall is enforced ONLY CLIENT-SIDE — `CheckboxPaywall::viewElements()` (src/Plugin/Field/FieldFormatter/CheckboxPaywall.php ~L200) renders full content and merely attaches JS/drupalSettings; protected content ships in the HTML and is hidden by `pigeon.js`, so view-source / JS-off trivially bypasses it. Per-entity bypass code compared with loose `==` (~L232). Not a server-side access control.

See [configure/paywall.md](configure/paywall.md)
