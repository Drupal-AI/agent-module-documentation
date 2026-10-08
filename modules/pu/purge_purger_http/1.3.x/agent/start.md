<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Generic HTTP Purger — agent index

Provides two Purge purger plugins that clear an external cache by HTTP request:
`http` (one request per invalidation) and `httpbundled` (one request for a batch). Each
configured instance is stored in a `httppurgersettings` config entity
(`purge_purger_http.settings.<id>`). Depends on **purge** and **purge_tokens**. No admin
route of its own (edit via Purge's purgers UI), no permissions, no Drush.

- **Purger plugins, the settings entity and all its fields, how to add/edit an instance** →
  [configure/purger.md](configure/purger.md)
- **Tokenised path / headers / body and the request URL format** →
  [configure/tokens-and-request.md](configure/tokens-and-request.md)

Key facts:
- Config entity id: `httppurgersettings` (config prefix `settings` → `purge_purger_http.settings.<id>`).
  Defaults: `request_method: BAN`, `invalidationtype: tag`, `scheme: http`, `hostname: localhost`,
  `port: 80`, `path: /`, `verify: TRUE`, `timeout: 1.0`, `max_requests: 100`, `http_errors: TRUE`.
- `httpconfiguration` diagnostic check validates enabled HTTP purgers.
- Submodule **purge_purger_http_tagsheader** (docs at
  `modules/pu/purge_purger_http/modules/purge_purger_http_tagsheader/1.3.x/`) emits the
  `Purge-Cache-Tags` response header for tag-aware proxies.
