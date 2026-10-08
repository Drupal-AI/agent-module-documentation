<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Vertex AI Search Recrawl (vertex_search_recrawl, project `vsr`) — agent index

**On node insert/update/delete, calls Google Vertex AI Search Discovery Engine `recrawlUris` to reindex (or drop) the node's URL.**

- **Version:** 10.0.x — core `^10 || ^11`; depends on `node`. Project/dir name `vsr`, module machine name `vertex_search_recrawl`.
- **Trigger:** `vertex_search_recrawl_node_insert/update/delete` → `NodeUpdateSubscriber::handleNode()` (or `hook_event_dispatcher` events) → `VertexRecrawlService::recrawlUris([canonical_url])`, with per-node-type filter.
- **Auth:** service-account JSON → RS256 JWT (`openssl_sign`) → `oauth2.googleapis.com/token` (jwt-bearer) → Bearer POST to `discoveryengine.googleapis.com/.../siteSearchEngine:recrawlUris`.
- **Config:** `/admin/config/search/vertex-search-recrawl` (`administer site configuration`) — project id, data store id, location, key **file path**, enabled, node types.
- **Security:** TLS via Guzzle defaults (verify ON) to Google HTTPS endpoints — no `verify=>false`. Service-account key stored as a **file path**, not in config DB (path validated for existence/readability/`private_key`). No hardcoded secrets. Admin-gated. See [configure/setup.md](configure/setup.md).
