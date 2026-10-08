# Flag Search API — agent index

Indexes Flag data into Search API: adds per-flag fields (flagging user IDs, and flag counts) via two
Search API processors, a Views field handler for the flag link, a Facets `user_flag` widget for
"flagged by me", and optional reindex-on-flag. Depends on `flag:flag` + `search_api:search_api`
(and `facets` for the widget). `configure` = `flag_search_api.admin`
(`/admin/config/search/flag-search-api`, permission `administer search_api`). No own permissions,
plugin types, or Drush.

- **The reindex-on-flag setting, config key, and how event-driven reindex works** →
  [configure/settings.md](configure/settings.md)
- **The two Search API processors, the `search_api_flag` Views field, and the `user_flag` facet widget**
  → [plugins/processors.md](plugins/processors.md)

Key facts:
- Processor `flag_indexer` adds `flag_<flag_id>` (multi-valued int = uids that flagged the item);
  `flag_count_indexer` adds `flag_<flag_id>_count` (int count).
- Config `flag_search_api.settings:reindex_on_flagging` (bool) enables the event subscriber; no
  `config/install` ships, so it is unset (falsey) until saved.
- `hook_views_data_alter` maps each indexed `flag_<id>` field to the `search_api_flag` Views field.
