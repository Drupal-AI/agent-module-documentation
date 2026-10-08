<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setting up Google Sheets Table

1. Create a Google Cloud service account, enable the Sheets and Drive APIs, and download its credentials JSON.
2. Store that JSON in a **Key** entity (Key module is a dependency).
3. Visit `/admin/config/services/google-sheets-table` (permission `administer google_sheets_table`) and select the Key holding the credentials (config `google_sheets_table.settings:credentials`).
4. Add a **Google Sheets Table** field (`google_sheets_table_field`) to an entity bundle; editors supply the spreadsheet id.
5. Share the target spreadsheet with the service account's email (read access) so the read-only scopes can see it.

Refresh: `google_sheets_table_cron()` scans entities with a non-empty `spreadsheet_id` and enqueues them; the `google_sheets_table_update_queue` worker re-fetches and re-caches. `GoogleSheetsApi::getSpreadsheetLastModified()` uses the Drive `modifiedTime` to avoid needless refetches.
