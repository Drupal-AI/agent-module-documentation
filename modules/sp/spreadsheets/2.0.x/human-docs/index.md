# Spreadsheets — manual setup guide

**Spreadsheets** (`spreadsheets`) reads data from a **Google Spreadsheet** and
makes it available inside Drupal. Once you point it at a sheet and give it Google
API access, it fetches the rows so they can be displayed on the site or used as a
lightweight data source — data that content editors go on maintaining in the
familiar Google Sheets UI rather than in Drupal itself.

This is handy when a small, frequently‑changing dataset is simply easier to keep
in a spreadsheet than to model as Drupal content: a price list, a schedule, a
directory. Compared with uploading and parsing a file, keeping the data in Google
Sheets has two nice properties — you can define validation rules on the sheet so
the data stays well‑formed, and Google tracks the revision history for you. A
typical example is a products sheet with prices and descriptions that you then use
to build nodes or other entities.

Getting it working takes two configuration steps: uploading a Google service‑
account key so Drupal can authenticate, and telling the module which sheet, range
and tab to read. After that, code on your site retrieves the data through the
module's service (`Drupal::service('spreadsheets_sheets.base')->getData()`), and
the sheet ID, range and sheet name can also be set programmatically.

The module provides its own permission to administer the Google Sheets
configuration and runs on Drupal 8.8 through 11. A few things to keep in mind:
store the Google API credentials as secrets; the module reaches out to Google at
read time, so caching and Google's availability matter; and treat the sheet
contents as external input — validate and escape it on output as you would any
imported data.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module, add the Google API
   client, and enable the private file system.
2. [Configuration](configuration/index.md) — upload your service‑account key and
   set the sheet, range and tab to read.

## Where it lives in the admin menu

- **Upload service‑account credentials:**
  `/admin/config/spreadsheets/spreadsheetscredentials`.
- **Set the sheet ID, range and tab:** `/admin/config/services/googlesheets`
  (config `spreadsheets.google_sheets_config`).
