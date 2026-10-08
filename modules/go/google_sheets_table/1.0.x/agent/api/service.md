<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `google_sheets_api` service

Class `Drupal\google_sheets_table\GoogleSheetsApi` (`src/GoogleSheetsApi.php`), args: config.factory, logger.factory, cache.default, key.repository.

- `createClient($credential_key = NULL)` — loads the Key (default from `google_sheets_table.settings:credentials`), `json_decode`s the key value, builds a `Google\Client`, `setAuthConfig()`, and sets read-only scopes `Sheets::DRIVE_READONLY`, `Sheets::SPREADSHEETS_READONLY`. Throws if no/invalid key.
- `getService()` — lazily instantiates `Google\Service\Sheets` and `Google\Service\Drive`; returns the Sheets service or FALSE on error.
- `getSheets(string $spreadsheet_id)` — `spreadsheets->get($id, ['includeGridData' => TRUE])`, returns the sheets array or FALSE.
- `getSpreadsheetLastModified($spreadsheet_id)` — `drive->files->get($id, ['supportsAllDrives' => TRUE, 'fields' => 'modifiedTime'])`, returns a unix timestamp.

Security posture: all calls go through the official Google API client (HTTPS with default Guzzle TLS verification). Inputs are Google spreadsheet **ids** (not URLs), so there is no server-side fetch of user-supplied URLs (no SSRF). Credentials never leave the Key entity in cleartext config.
