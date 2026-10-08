# The `google_sheets` data parser

Migrate Plus data parser plugin `google_sheets` (class `GoogleSheets`, extends Migrate Plus
`Json`). Use it on a `url` source migration to read a **Google Sheets API v4** JSON `values` feed.

## Source configuration

```yaml
source:
  plugin: url
  data_fetcher_plugin: http
  data_parser_plugin: google_sheets
  # v4 endpoint: /spreadsheets/<SHEET_ID>/values/<TAB or range>?key=<KEY>
  urls: 'https://sheets.googleapis.com/v4/spreadsheets/<SHEET_ID>/values/Game'
  # cache_lifetime: 3600     # optional; seconds to cache the decoded response
  fields:
    - { name: id,    label: 'Unique identifier', selector: 'id' }
    - { name: title, label: 'Title',             selector: 'title' }
    - { name: body,  label: 'Body',              selector: 'body' }
  ids:
    id:
      type: integer
process:
  # source field names above map to destination fields as usual
  title: title
  body/value: body
destination:
  plugin: entity:node
```

`process`, `ids`, `destination`, `migration_dependencies` are ordinary Migrate/Migrate Plus config.

## How it maps data (important)

- The endpoint must return JSON with a top-level **`values`** array (rows-of-cells, the Sheets v4
  `spreadsheets.values.get` shape).
- **The first row is treated as the header row.** `getSourceData()` shifts it off and lowercases
  each cell to build `$headers`.
- Each field's `selector` is matched (case-insensitively) against those headers; the cell at that
  column index becomes the field value (`fetchNextRow()`). Missing column → empty string.
- So `selector` values must equal the sheet's first-row column names (lowercased). This differs
  from the old gviz/`gsx:` XML feed; here selectors are plain header names.

## API key & caching (`fetchSourceData()`)

- If `migrate_google_sheets.settings:api_key` is set **and** the URL has no `key` query param, the
  key is appended as `?key=<API_KEY>`. Include `key=` directly in `urls` to override per migration.
  See [../configure/settings.md](../configure/settings.md).
- With `cache_lifetime` (per-source, default `0` = off) the decoded response is stored in
  `cache.default` under `migrate_google_sheets:<md5(url)>` and reused until expiry.
- If `json_decode` returns null, the raw response is re-encoded to UTF-8 and decoded again.

## Requirements

The sheet must be readable by the request — either public / "Anyone with the link can view", or
accessible with the provided API key. Run the migration with core Migrate or Migrate Tools
(`drush migrate:import <id>`); this module adds no Drush of its own.
