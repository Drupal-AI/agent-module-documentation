# Webform Google Sheets — agent index

Adds a Webform handler that appends new submissions as rows in a Google Sheet, via the Google
API Client module (OAuth 2.0 client OR service account). Depends on `webform` +
`google_api_client`. No global config page (`configure` null — configured per webform), no
permissions, no Drush. Provides a config schema for the handler settings.

- **The `googlesheets` handler: every setting, URL parsing, credentials, delivery/queue, data
  flattening** → [configure/handler.md](configure/handler.md)
- **Success/error events to subscribe to in custom code** → [api/events.md](api/events.md)

Key facts:
- Handler plugin id `googlesheets` (`src/Plugin/WebformHandler/WebformGoogleSheetsHandler.php`),
  category *External*, `CARDINALITY_UNLIMITED`, `tokens = TRUE`. Attach it under a webform's
  *Emails / Handlers*.
- Fires on `postSave()` for **new** submissions only (`$update === FALSE`). Immediate append,
  or enqueue when *Use queue* is on.
- Queue worker `webform_googlesheets_submission`
  (`src/Plugin/QueueWorker/WebformGoogleSheetsSubmission.php`, cron 60s/run): retries with a
  300s delay up to `queue_max_attempts` (0 = unlimited); at-least-once (may duplicate a row).
- Writes via Sheets API `spreadsheets->batchUpdate` with `AppendCells` (+ `AppendDimension` to
  grow columns). Cell value type set by PHP type in `prepareCell()`.
- Sheet URL validated to `docs.google.com/spreadsheets/d/<id>` with optional `gid` (fragment
  wins over query) in `parseSpreadsheetUrl()`.
- Events `webform_googlesheets.success` / `webform_googlesheets.error`
  (`src/Event/*`). Both paths log to the `webform_submission` logger channel.
- Config schema key `webform.handler.googlesheets` (`config/schema/webform_googlesheets.schema.yml`).
- Note: `tests/modules/webform_googlesheets_test` is a TEST fixture, not a shipped submodule.
