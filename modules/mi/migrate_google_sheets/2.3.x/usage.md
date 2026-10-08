Migrate Google Sheets provides a Migrate Plus `data_parser` plugin (`google_sheets`) that reads a Google Sheets API v4 JSON `values` feed as the source of a migration, mapping the first row to column headers.

---

The module adds one Migrate Plus data parser plugin, `google_sheets` (class `GoogleSheets` extending Migrate Plus's `Json` parser). You reference it as the `data_parser_plugin` on a `migrate_plus` migration whose source is `url`, pointing at a Sheets API v4 `.../values/<range>` endpoint that returns a JSON object with a `values` array. `getSourceData()` shifts the first row off `values` to build lowercase column headers, and `fetchNextRow()` maps each configured field selector to the matching header column by index. `fetchSourceData()` optionally appends the site's stored Google API key as a `key=` query parameter (only if the URL doesn't already contain one), and supports an optional per-source `cache_lifetime` that caches the decoded response in `cache.default` keyed by an md5 of the URL. It falls back to a UTF-8 re-encode if the first `json_decode` yields null. A settings form at `/admin/config/services/google_sheets` (permission `administer site configuration`) stores that API key in `migrate_google_sheets.settings:api_key`. The sheet must be shared/published so the API can read it. The project also ships an `migrate_google_sheets_example` submodule (plus a nested `_setup` module) with a full runnable example migration. The actual field mapping, process pipeline and destination are ordinary Migrate Plus/Migrate API configuration.

---

- Import rows from a Google Sheet into Drupal nodes via a Migrate Plus migration.
- Use a maintained spreadsheet as the editorial source for a content migration.
- Map spreadsheet columns to entity fields by header name using the `google_sheets` parser.
- Pull content from the Google Sheets API v4 `values` endpoint as JSON.
- Append a stored Google API key automatically to the request URL.
- Configure the Google API key once at `/admin/config/services/google_sheets`.
- Cache the fetched sheet response for a number of seconds via `cache_lifetime` to reduce API calls.
- Migrate taxonomy terms, menu links or redirects from tabbed spreadsheet ranges.
- Let non-developers maintain migration source data in a familiar spreadsheet UI.
- Re-run an incremental import when the sheet changes (with Migrate Tools / migrate:import).
- Seed a demo/staging site's content from a shared Google Sheet.
- Combine the parser with standard Migrate process plugins for transforms and lookups.
- Import from multiple sheet ranges by defining several migrations, one URL each.
- Provide a header-driven mapping so column order in the sheet drives field selectors.
- Reuse the shipped `migrate_google_sheets_example` migration as a working template.
- Handle non-UTF-8 responses gracefully via the built-in re-encode fallback.
- Point a migration at a published (File > Publish to the web) sheet readable without auth.
- Override the API key per URL by including `key=` directly in the source URL.
- Drive a one-time bulk content load from a curated spreadsheet.
- Keep source-of-truth data outside Drupal while syncing it in on demand.
