# Webform Google Sheets — manual setup guide

**Webform Google Sheets** (`webform_googlesheets`) appends every new webform
submission as a new row in a Google Sheet. It's the fastest way to get form entries
in front of people who don't live in Drupal — drop the sheet URL into a webform
handler and each submission lands in the spreadsheet, ready for filtering, pivot
tables, or downstream tools like Looker Studio, Apps Script, or Zapier.

It works by adding one **Webform handler** called *Google Sheets*. There's no
site-wide settings page — you add and configure the handler on each individual
webform under its *Emails / Handlers* tab. You paste the target Google Sheet URL,
pick your Google credentials, and choose how columns are laid out. Delivery can be
immediate or queued for cron (with retries), and you can attach several handlers to
one form to write to multiple sheets.

Authentication goes through the **Google API Client** module, which the handler
relies on for credentials — either an **OAuth 2.0 client** or a **service account**.
The credential needs the Google Sheets service and the `spreadsheets` scope, and (for
a service account) the target sheet must be shared with the service account's email.
Because it talks to Google, this module needs a Google Cloud project with the Sheets
API enabled; keep the actual credential secrets out of version control and in
environment variables / a Key entity.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and the Google Cloud prerequisites.
2. [Configuration](configuration/index.md) — adding the Google Sheets handler to a
   webform, every setting, and how delivery works.

## Where it lives in the admin menu

There's no global config page. You work per form: **Structure → Webforms → *(your
form)* → Settings → Emails / Handlers**
(`/admin/structure/webform/manage/<webform>/handlers`), then **Add handler → Google
Sheets**. Your Google credentials are managed separately in the **Google API Client**
module's admin area.
