# Search Exclusion by Node id — agent index

Excludes chosen nodes from **core Search** node results by NID. Depends on core `search`. No plugins, no config
schema, no Drush. The exclusion list lives in **State**, not config.

- **Admin form, storage key, the query alter that does the filtering** → [configure/exclude.md](configure/exclude.md)

Key facts:
- Form `SearchExcludeNidForm` at `admin/config/search/search_exclude_nid` (route `search_exclude_nid.form`,
  perm `administer search exclude nid`).
- Stored in `\Drupal::state()->get('search_exclude_nid.excluded_nids')` as an array of validated int NIDs.
- `hook_query_search_node_search_alter()` adds `n.nid NOT IN (...excluded)` to the core node-search query.
- Only affects core Search's `node_search`; does not change node access or hide nodes from direct URL/Views/Search API.
