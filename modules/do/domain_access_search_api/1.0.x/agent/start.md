# Domain Access Search API — agent index

Brings Domain Access's "current domain" filtering to **Search API index-based views**. Adds a
Views filter + an index processor. No config UI (`configure` null), no permissions, no schema,
no Drush. Depends on `search_api`, `domain`, `domain_access`.

- **The `current_all` Views filter, the all-affiliates index processor, and the required
  index fields / how to wire it into a view** → [configure/filter.md](configure/filter.md)

Key facts:
- `hook_views_data_alter` (`DomainAccessSearchApiHooks::viewsDataAlter`) registers filter
  `domain_access_search_api_current_all_filter` as `current_all` on each `search_api_index_<id>`
  table (group "Domain"), field `field_domain_access`; removes that field's stale relationship.
- Filter class `DomainAccessSearchApiCurrentAllFilter` (extends `BooleanOperator`): when value
  is truthy, `addWhere(field_domain_access = domain.negotiator active domain id)`; cache
  context `url.site`.
- Processor `domain_access_search_all_affiliates_processor` (stage `preprocess_index`): if an
  item's `field_domain_all_affiliates` is TRUE, sets its `field_domain_access` to ALL domain ids.
- Requires `field_domain_access` (string) — and `field_domain_all_affiliates` for the processor
  — to be added to the Search API index. Filter is opt-in per view.
- Not a security surface: it is a query/display filter, not enforced access control (see filter.md).
