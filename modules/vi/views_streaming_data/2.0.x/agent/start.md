<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Streaming Data (views_streaming_data) — agent index

**Streaming CSV and JSON Views formats.** Adds a `streaming_data_export` Views display that returns a
Symfony `StreamedResponse` and writes rows to the client as they are produced, instead of building the
whole response in memory. Design target: export 100k+ rows without exhausting PHP's memory limit.
Version **2.0.0**, core `^10.0 || ^11.0`, PHP `>=8.1`. Depends on `csv_serialization` (^4.0), core
`rest` and `views`. License GPL-2.0-or-later. Provides no permissions, no Drush commands, no config UI
page of its own (all configuration is per-view, in the Views UI).

## What it provides (plugins)

| Plugin | Type | ID | Notes |
|---|---|---|---|
| `StreamingDataExport` | Views display | `streaming_data_export` | `PathPluginBase` subclass; GET-only route, `returns_response`, no pager/AJAX/areas |
| `StreamingCsvSerializer` | Views style | `csv_streaming_data` | CSV/TSV/pipe; delimiter switches mime + extension; default style |
| `StreamingJsonSerializer` | Views style | `json_streaming_data` | flat JSON array of row objects |
| `StreamingSql` | Views query | `streaming_sql_query` | `Sql` subclass; keeps the PDO statement unbuffered, does not fill `$view->result` |
| (row) | Views row | core REST `data_field` | the ONLY allowed row plugin (locked in the UI) |

Non-plugin classes: `StreamingViewExecutable` (`IteratorAggregate` that fetches + renders in chunks),
`ViewExecutableFactory` (service `views_streaming_data.views.executable`).

## How it streams (the mechanism)

1. The display swaps core's `views_query` for `streaming_sql_query` (`StreamingDataExport::getPlugin('query')`).
2. `StreamingSql::execute()` runs the query but sets `$view->result = []` and keeps the PDO `Statement`;
   count queries and the pager are skipped (`usesPager = FALSE`, pager type `none`).
3. `StreamingDataExport::buildResponse()` returns a `StreamedResponse` (`attachment` disposition,
   `set_time_limit(0)`); the callback checks `$view->access($display_id)` then runs the display.
4. `StreamingViewExecutable::getIterator()` fetches rows in `chunk_size` batches (default **50**, options
   5–200), loads entities per chunk, renders, and `yield`s each row to the style plugin.
5. After each chunk it calls `entity.memory_cache->deleteAll()` and reflectively nulls each field
   handler's `entityFieldRenderer` — this is what keeps memory flat.
6. The style's `render()` writes each row straight to `php://output` and returns `''`.

## Configuration surface (per display)

- **Style**: CSV or JSON. CSV options: delimiter (comma / pipe `|` → `.txt` text/plain / tab → `.tsv`),
  strip tags (default on), decode HTML entities (default off), trim (default on).
- **Chunk size**: 5/10/20/50/100/200 (default 50).
- **File name**: from path, a custom string, or auto (`{view}-{display}`); extension from the serializer.
- **Authentication**: optional list of providers (cookie, basic_auth, …) applied as `_auth` on the route.
- **Access**: the view's normal Access section (permission / role / custom) — enforced, see below.

## Gotchas

- Live preview is disabled for this display ("No preview is available for a streaming export").
- Because normal Views result-set hooks are skipped, some contrib that post-processes `$view->result`
  may be incompatible.
- Any output buffering in the chain (reverse proxy, gzip, output filters) defeats the memory benefit.
- An error mid-stream cannot become a clean error page — the file has already begun downloading.

## Sub-guides

- `plugins/streaming-plugins.md` — the display/style/query/executable classes in detail.
- `views/configure-export.md` — how to add and configure a streaming export display on a view.

## Access & data safety

Access **is** enforced: the route is built by `PathPluginBase` (carries the view's `_view_access`
check) and `buildResponse()` re-checks `$view->access($display_id)` inside the streaming callback before
writing any data. The query still applies the base table's access query tag (e.g. node access) unless
`disable_sql_rewrite` is set, and rows render through the standard `data_field` field handlers, so
per-row/field access is respected the same as any view. There is no pager by design, so if an
administrator makes the display public, an anonymous client can pull the entire dataset — that is a
configuration choice, not a bypass.
