<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Indexing API (indexing_api) — agent index

**Pushes Google Indexing API url-notifications (`URL_UPDATED`/`URL_DELETED`) when configured content entities are created, updated, or deleted.**

- **Version:** 1.0.x (beta) · **Core:** ^10.2 || ^11 · **Package:** SEO
- **Configure:** `indexing_api.index_settings_form` → `/admin/config/services/indexing-api`
- **Assign bundles:** `indexing_api.assign_form` → `/admin/config/services/indexing-api/entity-assign/{entity_type_id}`
- **Route access:** both require permission `administer google index api`
- **Permission declared:** `configure indexing api` (NOTE: mismatch — routes reference the undeclared `administer google index api`; fail-closed to user 1)
- **Service:** `indexing_api.index` (`IndexService`) — `performRequest()`, `isIndexable()`, `isEntityTypeSupported()`
- **State keys:** `i_hostname`, `i_end_point`, `i_scope`, `i_json` (managed file in `private://indexing-api/`), `i_entities`
- **Hooks:** entity insert/update/delete call the Google API for indexable entities

**Security:** Admin-only; no anonymous or index-serving endpoint (the module only calls out to Google). Service-account key kept in the private filesystem. Endpoint/scope are admin config, not request-derived (no SSRF); TLS uses Google client defaults. The permission-name mismatch is fail-closed, not an exposure.

See [configure/google-indexing.md](configure/google-indexing.md).
