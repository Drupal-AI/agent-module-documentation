<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Google Sheets Table provides a field type that pulls a Google Spreadsheet through the Google Sheets/Drive API and renders it as an HTML table that refreshes automatically.
---
Editors enter a spreadsheet id (and options) into a `google_sheets_table_field` field; the `GoogleSheetsApi` service authenticates the official `Google\Client` with a service-account credentials JSON stored in a **Key** entity (read-only scopes `DRIVE_READONLY` + `SPREADSHEETS_READONLY`), fetches the sheet grid data, and a converter turns it into a render array. `hook_cron()` queues entities whose fields hold a spreadsheet id and a QueueWorker refreshes cached table data, using the Drive API's `modifiedTime` to detect changes. The admin form at `/admin/config/services/google-sheets-table` (permission `administer google_sheets_table`) selects which Key holds the credentials.

Because it uses the official Google API client, requests go to Google's endpoints over HTTPS (Guzzle TLS verification on by default) and the "id" is a Google spreadsheet id passed to `spreadsheets->get()` / `files->get()` — not an arbitrary URL fetched server-side, so there is no request-supplied-URL SSRF surface. Credentials are held in a Key entity rather than plain config, and the scopes are read-only. No security findings.
---
- Add a Google Sheets Table field to a content type.
- Display a live spreadsheet as an HTML table.
- Store the Google service-account JSON in a Key entity.
- Select the credentials Key on the settings form.
- Auto-refresh table data on cron.
- Detect sheet changes via Drive `modifiedTime`.
- Cache converted table data for performance.
- Restrict a sheet to read-only API scopes.
- Show tabular data maintained by non-Drupal editors in Sheets.
- Embed a pricing/roster/schedule sheet on a page.
- Queue large numbers of sheet-backed entities for background update.
- Configure per-field spreadsheet id and range.
- Keep credentials out of exported config (Key module).
- Administer the module behind the `administer google_sheets_table` permission.
- Share a spreadsheet with the service account for read access.
- Present data maintained in Sheets without granting CMS access.
- Convert sheet grid data into a themed render array.
- Avoid manual re-entry by syncing tabular content from Sheets.