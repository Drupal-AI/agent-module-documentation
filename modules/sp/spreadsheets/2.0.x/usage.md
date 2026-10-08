<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Spreadsheets reads data from a Google Spreadsheet and makes it available in Drupal, for displaying or importing sheet-backed data.

---

Spreadsheets provides the ability to read data from a Google Spreadsheet and surface it in Drupal.
After configuring Google Sheets access (at `spreadsheets.google_sheets_config`) — typically the
spreadsheet identifier and the Google API credentials — the module fetches rows from the sheet so they
can be displayed or used as a lightweight, non-authoritative data source that content editors maintain
in a familiar spreadsheet UI.

Use it when a small dataset is more convenient to maintain in Google Sheets than in Drupal content —
price lists, schedules, directories — and you want it rendered on the site without a full migration.
Because it authenticates to Google's API, store the Google credentials/API key as secrets, and note
that the connection reaches out to Google Sheets at read time (so caching and Google availability
matter). It provides permissions to administer the Google Sheets configuration. Treat sheet data as
externally-maintained input: validate/escape it on output as you would any imported content.

---

- Read data from a Google Spreadsheet in Drupal.
- Display sheet rows on the site.
- Maintain a small dataset in Google Sheets.
- Configure Google Sheets access and credentials.
- Store Google API credentials as secrets.
- Render a price list from a spreadsheet.
- Show a schedule maintained in Sheets.
- Use a sheet as a lightweight data source.
- Fetch rows at read time from Google.
- Administer Google Sheets config via permission.
- Configure at spreadsheets.google_sheets_config.
- Cache sheet reads for performance.
- Treat sheet data as external input to escape.
- Avoid a full migration for small datasets.
- Let editors update data in a familiar UI.
- Point Drupal at a specific spreadsheet ID.
- Handle Google API authentication.
- Depend on Google Sheets availability.
- Surface a directory from a spreadsheet.
- Validate/escape imported sheet values on output.
