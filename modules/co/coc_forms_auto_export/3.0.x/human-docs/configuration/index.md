# Configuration

Webform Auto Exports is configured **per form**, not in a single site-wide
settings page. This means you decide form by form what exports, where it goes,
and on what schedule.

## Open the export settings for a form

1. Go to **Structure → Webforms** and open the form you want to export.
2. Go to its **Results → Downloads** tab (the same page you would use for a
   manual CSV download).
3. Find the **Automatic CSV Export** section on that page.

## Turn on automatic export

Enable **Automatic Export** for this form. Everything below only applies once it
is on.

## Choose where results are delivered

You can use either or both delivery methods:

- **Email** — send the exported CSV to a nominated email address. You can set the
  email **subject** and **body**.
- **SFTP** — transfer the exported CSV to a defined SFTP location. This option
  requires the `phpseclib/phpseclib` library (see
  [Installation](../installation/index.md)).

## Choose what is exported

- **Date range** — export submissions from the previous **day**, **week**,
  **month**, or **year**.
- **Columns** — choose which columns are included in the export file.
- **Delimiters** — set the delimiter used for single-value fields and the one
  used for multi-value fields.

Beyond these, the export uses Webform's standard results-download options, so
the same search/criteria controls you know from manual downloads apply.

## Schedule it

- **Start** — run the export from now, or from a specified future date/time.
- **Stop** — stop on a specific date/time, or keep running indefinitely.

## Handle the exports as sensitive data

The CSV files typically contain **personal data** (names, emails, messages,
uploads). Make sure the destination — the mailbox that receives them or the SFTP
target — is access-controlled and not web-accessible, that files are stored
securely, and that they are retained and disposed of in line with your
data-protection obligations.

## Save

Save the form's settings. The export then runs on schedule; a working Drupal
cron is what drives scheduled runs.
