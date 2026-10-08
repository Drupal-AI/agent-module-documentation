<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cookie Compliance (cookie_compliance) — agent index

**Injects the hosted hu-manity.co cookie-consent banner (remote CDN script) into the page head, keyed by an App ID.**

- **Version:** 1.0.x
- **Core:** ^10 || ^11
- **Config object:** `cookie_compliance.settings` (`enabled`, `app_id`, `app_secret_key`)
- **Route:** `cookie_compliance.cookie_compliance_settings` → `/admin/config/system/cookie-compliance-settings` (permission `administer site configuration`)
- **Mechanism:** `hook_page_attachments_alter()` in `.module` adds inline `huOptions` + `https://cdn.hu-manity.co/hu-banner.min.js` to `html_head` when enabled and App ID set.
- **Security:** admin-only config route; no anonymous or mutating endpoints. Loads a third-party script from cdn.hu-manity.co on every page (client-side external dependency); no server-side callback. App ID/secret validated against `^[a-z0-9-]+$`.

See [configure/settings.md](configure/settings.md).