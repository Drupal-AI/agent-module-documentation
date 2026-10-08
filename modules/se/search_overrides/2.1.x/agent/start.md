<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API Solr Overrides — agent index

Manually elevate/exclude nodes in Search API **Solr** results per exact query string. Adds a
`search_override` entity + a `PreQueryEvent` subscriber that injects Solr `elevateIds`/`excludeIds`.
Requires `search_api` + `search_api_solr`. Config UI at `admin/config/search/search_override`
(`configure` = `search_override.settings`).

- **How overrides alter the Solr query, entity fields, `?ignore_overrides`, id building** →
  [api/query-alter.md](api/query-alter.md)
- **Settings form keys, entity CRUD routes, autocomplete endpoint, permissions** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Override entity `search_override`: `query` (string), `elnid` (elevated node refs), `exnid` (excluded node refs).
- Subscriber `SolrQueryAlterEventSubscriber` on `SearchApiSolrEvents::PRE_QUERY` adds `elevateIds` + `excludeIds` params.
- `?ignore_overrides=1` on a search URL returns unmodified results.
- Settings config `search_overrides.settings`: `path`, `parameter`, `match_entire_string`, `content_match`, `search_index`.
- Permissions: `add`/`edit`/`delete`/`administer search overrides` (grantable), `configure search overrides` (`restrict access: true`).
- No Drush, no plugin types, no config schema shipped.
