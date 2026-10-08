# Google Sheets Table — manual setup guide

**Google Sheets Table** (`google_sheets_table`) adds a field type that turns a
Google spreadsheet into an auto-updating HTML table on your site. An editor enters
a spreadsheet ID into the field; the module reads the sheet through the official
Google Sheets/Drive API and stores the resulting HTML in the database, ready to be
rendered like any other text — on a page, in a decoupled app, or wherever you like.

A cron task keeps the tables fresh: it checks whether the linked Google sheets have
new revisions (using the Drive API's `modifiedTime` so it only refetches when
something actually changed) and updates the cached HTML accordingly. Large numbers
of sheet-backed entities are handled through a queue so the work happens in the
background.

Authentication uses a Google **service account**: you download the account's
credentials JSON, store it in a [Key](https://www.drupal.org/project/key) entity,
and point the module at that Key. The module only ever *reads* — it requests
read-only Sheets and Drive scopes — so it can never modify your spreadsheets. It
converts formatted cell values (currency, bold, italics, links) into HTML;
charts, images, fonts, colours and alignment are not carried over, and the output
runs through a configurable text format so you can strip any tags you do not want.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and the Key dependency.
2. [Configuration](configuration/index.md) — set up the service account, store the
   credentials in a Key, and add the field.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → Google Sheets Table**
(`/admin/config/services/google-sheets-table`), gated by the *administer
google_sheets_table* permission. That is where you choose which Key holds the
service-account credentials.

## How to use it

Add a **Google sheets table** field to a content type, and have editors paste the
spreadsheet ID (the string in the sheet's URL after `/spreadsheets/d/`). Share the
spreadsheet with the service account's email address so it can read it, and the
module will render — and keep refreshing — the table.
