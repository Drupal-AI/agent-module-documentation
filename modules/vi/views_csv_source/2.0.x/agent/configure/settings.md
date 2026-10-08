<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the CSV source and query options

Two layers of configuration: the per-view **Query settings** (the CSV source + how it is fetched)
and one **module settings form** (remote cache duration).

## Per-view Query settings

Build a View, choose **"CSV"** in the "Show" field, then in Advanced → Query settings click
"Settings". Options (defined in `ViewsCsvQuery::defineOptions()` / `buildOptionsForm()`):

| Option key | Type | Default | Meaning |
|---|---|---|---|
| `csv_file` | entity_autocomplete (`file`) | `''` | The CSV source URI. Required. Autocomplete is restricted to `text/csv` files (selection handler `default:views_csv_source_file_entity_selection`). You may instead type an internal path (`/files/data/example.csv`) or an external URL. Tokens allowed. |
| `header_index` | number ≥ 0 | `0` | Rows to skip before the header row (League\Csv header offset). |
| `headers` | textfield | `''` | JSON string of HTTP headers for the REST call, e.g. `{"Authorization":"Basic xxxxx","Content-Type":"application/csv"}`. Empty ⇒ `Content-Type: application/csv`. |
| `request_method` | select `get`/`post` | `get` | HTTP method for remote URLs. |
| `request_body` | textarea (visible when POST) | `''` | JSON array decoded as a Guzzle `multipart` body. |
| `show_errors` | checkbox | `TRUE` | Show CSV parse errors in the view (leave on during development). |

### Source URI forms (resolved in `src/UriParserTrait.php`)
- `entity:file/{fid}` — a managed file; resolved via file storage to a real path (the safe form).
- `internal:/path` — read from `DRUPAL_ROOT . path`. A scheme-less string typed in the field is
  mapped to `internal:` automatically; `validateCsvFileUriElement()` requires it to start with `/`.
- `http(s)://…` — fetched with Guzzle (GET, or POST with `request_body`). Response is cached.

### Tokens in the URI
`csv_file` runs through `applyTokenReplacements()`: Drupal global tokens (`[...]`), Views tokens
(`{{ ... }}`) including `{{ arguments.x }}` / `{{ raw_arguments.x }}` for contextual filters, and
`%` placeholders replaced positionally from `$view->args`. Use this to point one view at a
per-request file, e.g. `/sites/default/files/my_file__{{ raw_arguments.value }}.csv`.

## Module settings form

Route `views_csv_source.settings` → `/admin/config/user-interface/views-csv-source-settings`
(permission `administer site configuration`). Config object `views_csv_source.settings`:

| Key | Default | Meaning |
|---|---|---|
| `cache_ttl` | `86400` | Seconds to cache a **remote** CSV response. `0` disables caching (use for very large files). Local/entity files are never cached here. |

Set it with drush: `drush config:set views_csv_source.settings cache_ttl 0`.

## Altering CSV content before caching
Subscribe to the event `views_csv_source.pre_cache`
(`Drupal\views_csv_source\Event\PreCacheEvent::VIEWS_CSV_SOURCE_PRE_CACHE`). The event exposes
`getCacheId()`, `getData()`, and `setData($string)` — call `setData()` to rewrite the raw CSV body
before it is written to cache. Only fires for cached remote fetches (`cache_ttl > 0`).
