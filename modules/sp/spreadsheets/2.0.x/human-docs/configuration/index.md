# Configuration

Setting up Spreadsheets is a two‑part job: first give Drupal permission to talk to
Google, then tell it which sheet to read.

## Step 1 — enable Google Sheets API access

Follow the *"Set up your environment"* section of Google's
[Sheets API quickstart](https://developers.google.com/sheets/api/quickstart/js) to
enable the API for a Google Cloud project. Then create a **Service Account** and
generate a **key** for it, downloading the JSON key file.

## Step 2 — upload the service‑account key

1. Log in as an administrator (you need the module's permission to administer the
   Google Sheets configuration).
2. Go to `/admin/config/spreadsheets/spreadsheetscredentials`.
3. Upload the JSON key file you downloaded from Google.

The key is stored in Drupal's private file system, so make sure that is configured
(see [Installation](../installation/index.md)). Treat the key as a secret — it
grants access to your Google data.

## Step 3 — point the module at a sheet

1. Go to `/admin/config/services/googlesheets` (config
   `spreadsheets.google_sheets_config`).
2. Set:
   - **Sheet ID** — the identifier of the Google Spreadsheet to read.
   - **Range** — the cell range to extract (for example a column/row range).
   - **Sheet** — the tab (worksheet) within the spreadsheet to read from.
3. Save.

## Retrieving the data

With credentials and a sheet configured, retrieve the rows in code with
`\Drupal::service('spreadsheets_sheets.base')->getData()`. You can also change the
target programmatically using the service's `setSheetId(string $id)`,
`setRange(string $range)` and `setSheetName(string $name)` methods.

## Things to keep in mind

- The module fetches from Google **at read time**, so cache the results where you
  can and be aware that Google's availability affects your site.
- Treat the sheet contents as **external input**: validate and escape the values
  on output as you would any imported data.
