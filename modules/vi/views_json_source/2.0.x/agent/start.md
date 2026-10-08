<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views JSON Source — agent index

Adds a Views **query backend** so a View's rows come from a JSON document (remote API or
local file) instead of the database. You build a normal View on the `json` base table and set
the source in *Query settings*.

- **Global settings (`cache_ttl`) + the per-View query options (`json_file`, `row_apath`,
  headers, GET/POST, single payload, errors)** → [configure/settings.md](configure/settings.md)
- **The Views plugins it provides (query, field, filter, sort, arguments) and the `apath`
  mini-syntax** → [plugins/views.md](plugins/views.md)
- **`PreCacheEvent` — rewrite the JSON payload before it is cached** →
  [api/events.md](api/events.md)

Key facts: base table `json` (`hook_views_data`), query plugin id
`views_json_source_query`. To create a View by hand: *Show* → "JSON", then set *Query
settings* → `json_file` + `row_apath`, add fields whose "Key Chooser" is an apath into each
row. Settings form at `/admin/config/user-interface/views-json-source-settings`
(`views_json_source.settings`, permission "administer site configuration"). Responses cached
in `cache.default` for `cache_ttl` seconds (default `86400`). No permission/plugin type of
its own; depends on `views`.
