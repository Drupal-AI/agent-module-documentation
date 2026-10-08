# Configuration

Setup has three steps: create a Google service account, store its credentials in a
Key entity, and point the module at that Key. Then you add the field and share your
spreadsheets with the service account.

## 1. Create a Google service account

1. In the [Google Cloud console](https://console.cloud.google.com/), create (or
   select) a project and enable the **Google Sheets API** and the **Google Drive
   API**.
2. Create a **user-managed service account**.
3. Create a **key** for that service account, choosing **JSON**, and download the
   JSON file.

The service account is what the module authenticates as. Because the module only
requests read-only scopes (`DRIVE_READONLY` and `SPREADSHEETS_READONLY`), it can
read the sheets you share with it but can never write to them.

## 2. Store the credentials JSON in a Key

The credentials JSON is a secret — do not commit it to Git or paste it into plain
configuration. Store it with the **Key** module:

1. Go to **Configuration → System → Keys** (`/admin/config/system/keys`) and click
   **Add key**.
2. Give the key a label and store the JSON contents (Key supports multi-value /
   file-backed secrets suited to a credentials JSON). For the most secure setup,
   keep the JSON in a location outside the web root or in an environment variable
   and use the matching Key provider rather than pasting the value into the
   database.
3. Save the key.

## 3. Point the module at the Key

1. Go to **Configuration → Web services → Google Sheets Table**
   (`/admin/config/services/google-sheets-table`) — you need the *administer
   google_sheets_table* permission.
2. Choose the **Key** you just created as the Google Sheets API key (stored as
   `google_sheets_table.settings:credentials`).
3. Save.

## 4. Add the field and share your spreadsheets

1. Add a **Google sheets table** field (`google_sheets_table_field`) to a content
   type or other entity bundle.
2. When creating content, editors paste the **spreadsheet ID** — the string in the
   sheet's URL after `/spreadsheets/d/` (for example, in
   `https://docs.google.com/spreadsheets/d/1BxiMVs0.../edit` the ID is
   `1BxiMVs0...`).
3. In Google Sheets, **share each spreadsheet with the service account's email
   address** (read access is enough) so the read-only scopes can see it.

## Refreshing and rendering

A cron task scans entities holding a spreadsheet ID and queues them for refresh;
the queue worker refetches and re-caches the HTML, using the Drive `modifiedTime`
to skip sheets that have not changed. The rendered table runs through a
configurable text format, so you can strip any tags you do not want.

## A note on data flow

All requests go to Google's official API endpoints over HTTPS with TLS
verification on. The spreadsheet ID is passed to the Sheets/Drive API — it is not
an arbitrary URL fetched server-side — so there is no request-supplied-URL risk,
and credentials stay in the Key module rather than in exported config.
