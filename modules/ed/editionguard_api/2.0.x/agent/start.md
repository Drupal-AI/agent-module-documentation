<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EditionGuard API (editionguard_api) — agent index

**Provides a service-based client for the EditionGuard ebook-DRM REST API v2, with each operation modelled as a discoverable endpoint plugin.**

- **Version:** 2.0.x (from `2.0.0-rc1`)
- **Core:** ^10 || ^11
- **Configure:** /admin/config/services/editionguard-api (`editionguard_api.settings`)
- **Services:** `editionguard_api.client`, `editionguard_api.endpoint_plugin_manager`
- **Routes:** settings, test, test/endpoint/{endpoint_id} — all `_permission: 'administer site configuration'`.
- **Auth:** admin creds POSTed to obtain-auth-token; token cached; sent as `Authorization: Token`.
- **Security:** all routes admin-gated; HTTPS with default TLS verification (not disabled); no anonymous/mutating public endpoints. Note: EditionGuard email+password stored in plaintext config.

See [api/client.md](api/client.md) and [configure/settings.md](configure/settings.md).
