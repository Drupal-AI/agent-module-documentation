<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views CSV Source (views_csv_source) — agent index

A Views **query backend** that reads rows from a CSV file instead of the SQL database, so a
spreadsheet (uploaded managed file, local path, or a remote HTTP(S) endpoint) can be listed,
sorted, filtered, related and themed with the normal Views UI. Parses with `league/csv ^9.27`.
Depends on core `views`. Core: `^8.8 || ^9 || ^10 || ^11`.

Settings page: `/admin/config/user-interface/views-csv-source-settings` (route
`views_csv_source.settings`) — a single cache-duration field for remote files. No permissions,
no drush commands. Provides one config object and a set of Views plugins (query/field/filter/
sort/argument/relationship/EntityReferenceSelection).

- **Build a CSV-backed view and point it at a file/URL (the query settings)** → [views/query.md](views/query.md)
- **The field, filter, sort, argument, relationship and constant handlers** → [views/handlers.md](views/handlers.md)
- **The remote-cache duration setting + config object** → [configure/settings.md](configure/settings.md)
- **Altering CSV content before it is cached (PreCacheEvent)** → [events/pre_cache.md](events/pre_cache.md)

Key facts:
- Views base table: **`csv`**; query plugin id **`views_csv_source_query`** (query_id in
  `hook_views_data`). Choosing "CSV" in a view's *Show* + `hook_view_presave`
  (`ViewsCsvSourceHooks::viewPresave`) sets the display's query type.
- Query options (config `views.query.views_csv_source_query`): `csv_file`, `header_index`,
  `headers`, `request_method` (`get`/`post`), `request_body`, `show_errors`.
- Source URI forms: `entity:file/{fid}` (managed file, csv mime only), `internal:/path`
  (docroot-relative), or `http(s)://…` (Guzzle GET/POST). Scheme-less input is treated as
  `internal:`. Drupal `[…]` tokens, Views `{{ arguments.X }}` tokens and `%` positional args
  are substituted into the path.
- Service `views_csv_source.connection` (`Query\Connection`) fetches + caches remote CSVs;
  logger channel `logger.channel.views_csv_source`.
- Config object `views_csv_source.settings` → `cache_ttl` (int seconds, default `86400`;
  `0` disables remote caching). Settings route permission: `administer site configuration`.
- Handlers (`hook_views_data`, table `csv`): field `views_csv_source_field` +
  `csv_constant`; filters `views_csv_source_filter`, `_filter_select`, `_filter_numeric`,
  `_filter_datetime`, `_filter_combine`; sort `views_csv_source_sort`; argument
  `views_csv_source_argument`; relationship `views_csv_relationship`.
- Entity-reference selection `default:views_csv_source_file_entity_selection` (limits the file
  autocomplete to `text/csv`). Event id `views_csv_source.pre_cache`.
