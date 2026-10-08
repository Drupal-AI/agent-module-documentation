<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Site (site) — agent index

**Revisionable, fieldable Site entity that records a site's health/state and shares it over JSON:API.**

- **Version:** 2.2.x (2.2.0-rc3)
- **Core:** >=8 — deps include `key_auth`, `rest`, `jsonapi`, `eva`, `field_ui`, `admin_toolbar_tools`.
- **UI routes:** `/admin/site/about|history|edit|save`, settings `/admin/about/settings` — each permission-gated.
- **API routes:** `/jsonapi/self` (perm `access site data api`), `POST /jsonapi/action/{plugin_id}` (perm `access site actions pages`); `_auth`: basic_auth, cookie, key_auth, ip_consumer_auth.
- **Services:** `site.self`, `site.remote`, SiteProperty + SiteAction plugin managers, event/redirect subscribers, breadcrumb builder.
- **Drush:** set site state/reason (`src/Drush/Commands/SiteCommands.php`). **Permissions:** many (restricted where sensitive).

**Security:** UI and API routes are each permission-gated; the Site API requires explicit permissions and supports token/key auth. Note `bypass site action user login password requirement` exists for the User Login site action — grant sparingly. No disabled-TLS/anon-mutation findings. See [api.md](api.md) and [drush.md](drush.md).
