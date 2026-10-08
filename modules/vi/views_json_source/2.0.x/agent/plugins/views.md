<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views plugins & the `apath` syntax

All handlers live on the `json` base table (declared in `views_json_source.views.inc`).

## Query — `views_json_source_query` (`ViewsJsonQuery`)

Fetches `json_file` (Guzzle GET/POST, or `file_get_contents` under `DRUPAL_ROOT` for local
paths), caches remote responses (`views_json_source_<md5(uri)>` in `cache.default` for
`cache_ttl`), decodes, and extracts rows with `apath(row_apath)`. Filters/sorts are applied
in PHP; rows are then **flattened** so nested keys become `parent/child` (see `parseRow`).
`single_payload` returns the whole extracted structure as one row.

## `apath` mini-syntax

`apath($path, $array)` walks the decoded document by `/`-separated segments:

- `data/records` — descend object keys `data` then `records`.
- `nid=2/related` — within the current array, pick the element whose `nid` equals `2`, then
  its `related`.
- `%` — wildcard replaced by the **next** contextual-filter value (Apath Replacement).
- Plain integer segments index array positions.

`row_apath` must resolve to the array (or single object, with `single_payload`) that becomes
the rows.

## Field — `views_json_source_field` (`ViewsJsonField`)

Options: `key` (apath into each flattened row, required), `trusted_html` (bool). Renders the
value HTML-escaped, or as raw `Markup` when `trusted_html = 1` (use with caution). Supports
click-sort. In a stored View a field component sets `field: value`,
`plugin_id: views_json_source_field`, and its own `key`.

## Filter — `views_json_source_filter` (`ViewsJsonFilter`)

Options: `key`. Operators (evaluated in PHP after transliteration, in
`ViewsJsonQuery::ops()`): `=`, `!=`, `contains`, `starts`, `not_starts`, `ends`, `not_ends`,
`not` (does not contain), `shorterthan`, `longerthan`, `regular_expression`. Can be exposed.
Multiple filters combine with the display's filter-group AND/OR operator.

## Sort — `views_json_source_sort` (`ViewsJsonSort`)

Options: `key`. Natural, case-insensitive comparison (`strnatcasecmp`), ASC/DESC.

## Arguments / contextual filters

- `views_json_source_argument` (`ViewsJsonArgument`) — argument on a row value.
- `views_json_source_parameter` (`ViewsJsonParameter`) — "Apath Replacement": fills a `%` in
  `row_apath`. Views data key `parameter`.
- `views_json_source_uri_param` (`ViewsJsonUriParam`) — "URL Parameter": fills a `%` in the
  request URL. Views data key `param`.

Contextual filter values are consumed in order (`getCurrentContextualFilter`,
`getUrlParam`).
