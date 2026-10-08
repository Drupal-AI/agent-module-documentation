<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Google Sheets Table (google_sheets_table) — agent index
**A field type rendering a Google Sheet as an auto-updating HTML table via the Google Sheets/Drive API, credentials held in a Key entity.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10 · **Depends:** key
- **Configure:** `/admin/config/services/google-sheets-table` (route `google_sheets_table.config_form`, permission `administer google_sheets_table`)
- **Services:** `google_sheets_api` (`src/GoogleSheetsApi.php`), `google_sheets_table_converter`.
- **Refresh:** `hook_cron` + `google_sheets_table_update_queue` QueueWorker; change detection via Drive `modifiedTime`.
- **Security:** admin config route permission-gated. Credentials = service-account JSON in a **Key** entity; API scopes are read-only (`DRIVE_READONLY`, `SPREADSHEETS_READONLY`). Fetches use the official `Google\Client` (HTTPS, TLS verify on) against a Google **spreadsheet id**, not a request-supplied URL — no SSRF, no disabled TLS. No security findings.

See [configure/setup.md](configure/setup.md) and [api/service.md](api/service.md).