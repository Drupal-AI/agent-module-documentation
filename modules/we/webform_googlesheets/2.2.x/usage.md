Webform Google Sheets provides a Webform handler that appends each new form submission as a row in a Google Sheets spreadsheet, authenticating through the Google API Client module using either an OAuth 2.0 client or a service account.

---

The module depends on Webform and Google API Client and adds one Webform handler plugin, `googlesheets` (`WebformGoogleSheetsHandler`, category *External*, unlimited cardinality). You attach it to a webform under *Emails / Handlers*, paste the target Google Sheet URL (parsed to a spreadsheet ID + sheet gid, validated to `docs.google.com/spreadsheets/d/...`), and pick a credential: an OAuth 2.0 client (`GoogleApiClient` entity) or a Service Account (`GoogleApiServiceClient` entity) that must have the Google Sheets service and the `spreadsheets` scope. On a new submission (`postSave`, create only) the handler either appends immediately or, if *Use queue* is on, enqueues an item processed by a cron QueueWorker (`webform_googlesheets_submission`, 60s/run) with configurable max attempts and a 300s retry delay (delivery is at-least-once, so a timed-out-but-accepted append can duplicate a row). Submission data is flattened by `getData()` — composites and multi-valued fields are expanded into columns (with limits and optional empty padding or comma-joining), timestamps (`created`/`completed`/`changed`) optionally reformatted, managed-file values sent as file URIs, and an *included/excluded columns* selector plus a *sort metadata first* toggle control column layout. Rows are written with the Sheets API `batchUpdate` (`AppendCells`, growing the sheet with `AppendDimension` when needed); cell types are set per PHP type (bool/number/string). Success and failure each dispatch an event (`WebformGoogleSheetsSuccessEvent` / `WebformGoogleSheetsErrorEvent`) you can subscribe to, and both paths log to the `webform_submission` channel. Config schema is provided for the handler settings; there are no permissions, no Drush commands, and no runtime submodules (the `tests/modules` fixture is test-only).

---

- Append every new webform submission as a row in a Google Sheet.
- Collect contact/lead form entries into a shared spreadsheet for non-Drupal users.
- Authenticate with a Google service account for unattended server-to-server delivery.
- Authenticate with an OAuth 2.0 client where a user grants access interactively.
- Target a specific tab (sheet gid) within a spreadsheet via the sheet URL fragment.
- Queue deliveries for cron processing to keep form submission fast and resilient to API latency.
- Retry failed deliveries up to a configured maximum number of attempts.
- Choose exactly which submission columns are exported (included/excluded data selector).
- Put submission metadata (sid, created, completed, changed) before or after the field values.
- Convert Unix timestamps to a chosen site date format (or a custom PHP date string).
- Expand multi-value fields into multiple columns, with a configurable value limit.
- Pad empty multi-value slots so columns stay aligned across submissions.
- Alternatively comma-join multi-value answers into a single column.
- Flatten composite fields (e.g. address, name) into per-subfield columns.
- Export managed-file uploads as their file URI.
- Attach multiple Google Sheets handlers to one webform (unlimited cardinality) to write several sheets.
- React to successful deliveries in custom code via `WebformGoogleSheetsSuccessEvent` (get the API response).
- React to delivery errors via `WebformGoogleSheetsErrorEvent` (get the error message) for alerting.
- Mirror form data into a spreadsheet for lightweight reporting or pivot tables.
- Feed a spreadsheet that other tools (Looker Studio, Apps Script, Zapier) consume.
- Log delivery outcomes to the `webform_submission` log channel for troubleshooting.
- Automatically widen the sheet (add columns) when a submission has more columns than the sheet.
