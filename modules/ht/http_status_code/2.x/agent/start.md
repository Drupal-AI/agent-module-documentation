<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTTP Status Code (http_status_code) — agent index

**Maps configured request paths to a chosen HTTP status code (e.g. 410 Gone) applied by a response event subscriber.**

- **Version:** 2.x  ·  **Core:** ^10 || ^11  ·  **Package:** Other
- **Config entity:** `http_status_entity` (id, label, url, status_code); CRUD UI under `/admin/config/http_status_code/http_status_entity`.
- **Runtime:** `HTTPStatusSubscriber::onRespond()` matches `getRequestUri()` and calls `$response->setStatusCode()` — runs a config-entity lookup on every response.
- **Permissions:** `administer http status code` gates the entity CRUD routes (via `AdminHtmlRouteProvider`).
- **Settings form:** `/admin/config/http_status_code/settings` toggles an (unimplemented) `automatic_410` flag.

**Security:** entity CRUD is permission-gated, but the settings-form route (`http_status_code.routing.yml:8`) uses `_access: 'TRUE'` — anonymous users can open and submit it. Impact is low (only writes the inert `automatic_410` config), but it is a genuine missing access check. Also a per-request DB lookup is a performance consideration.

See [configure/mappings.md](configure/mappings.md).