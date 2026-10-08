<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Spreadsheets — agent index

Reads data from a **Google Spreadsheet** into Drupal for display / lightweight data sourcing.
Configure at `spreadsheets.google_sheets_config` (spreadsheet ID + Google API credentials — store as
secrets). Version **2.0.5**. Core `^8.8||^9||^10||^11`.

Fetches rows from Google at read time (caching + Google availability matter). Provides admin
permissions. Treat sheet data as external input — validate/escape on output.
