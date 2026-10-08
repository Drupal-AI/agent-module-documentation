# Migrate Google Sheets — agent index

Provides a Migrate Plus **`data_parser` plugin `google_sheets`** to use a Google Sheets API v4
JSON `values` feed as a migration source (first row = column headers). Plus a settings form that
stores a Google API key. Depends on `migrate_plus`.

- **Use the parser in a migration (source config, headers, `cache_lifetime`, example)** →
  [plugins/data_parser.md](plugins/data_parser.md)
- **Set the Google API key (settings form, config key)** → [configure/settings.md](configure/settings.md)

Key facts:
- Parser id `google_sheets`, class `GoogleSheets` extends Migrate Plus `Json`. Reference it as
  `data_parser_plugin: google_sheets` on a `url` source migration.
- First row of the sheet's `values` array becomes lowercase headers; field selectors match by header.
- API key stored in `migrate_google_sheets.settings:api_key`; appended as `?key=` unless the URL
  already has a `key` param. Config UI `/admin/config/services/google_sheets` (perm `administer
  site configuration`).
- Ships `migrate_google_sheets_example` (+ nested `_setup`) submodule: a runnable example migration
  (demo fixture; requires `migrate_tools` + `redirect`). Not separately documented here.
