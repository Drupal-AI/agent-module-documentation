<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Edit Redirect (entity_edit_redirect) — agent index
**A response subscriber that 301-redirects `entity.{type}.edit_form` routes to a configured external editing server.**

- **Version:** 8.x-1.x
- **Core:** ^8 || ^9 || ^10
- **Configure:** `/admin/config/content/entity_edit_redirect` (route `entity_edit_redirect.admin_form`)
- **Permission (route):** `admininister entity edit redirect configuration` (sic — misspelled in the module)
- **Key class:** `src/EventSubscriber/EntityEditRedirectSubscriber.php` (KernelEvents::RESPONSE, prio 1000)
- **Settings:** `base_redirect_url`, `append_destination`, `destination_querystring`, `entity_edit_path_patterns`
- **Security:** admin config route permission-gated. Redirect target host is the admin-set `base_redirect_url` (not request-controlled) and uses `TrustedRedirectResponse`; the appended `destination` is validated same-origin via `UrlHelper::externalIsLocal` — no open-redirect observed.

See [configure/settings.md](configure/settings.md).