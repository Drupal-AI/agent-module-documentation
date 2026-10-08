# Migrate Google Sheets — manual setup guide

**Migrate Google Sheets** (`migrate_google_sheets`) lets you use a **Google Sheet** as
the data source for a Drupal migration. It provides a
[Migrate Plus](https://www.drupal.org/project/migrate_plus) data parser plugin,
`google_sheets`, that reads a Google Sheets API v4 JSON feed and maps the sheet's
first row to column headers — so a spreadsheet becomes rows you import into nodes,
taxonomy terms, or any entity.

This is handy when non‑developers maintain the source content in a familiar
spreadsheet: an editor updates the sheet, and you re‑run the migration to sync the
changes in. The rest — how columns map to fields, what transforms run, and the
destination — is ordinary Migrate / Migrate Plus configuration.

The module adds one small settings form for storing a **Google API key**, which the
parser appends to its requests automatically. A key is only needed for sheets that
require one; a fully published ("Anyone with the link can view", or File → Publish to
the web) sheet may be readable without it.

This guide is written for a **human** setting it up. If you want terse, token‑cheap
references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Migrate Plus.
2. [Configuration](configuration/index.md) — store the Google API key, and reference
   the `google_sheets` parser in a migration.

## Where it lives in the admin menu

The Google API key form is at **Configuration → Web services → Google Sheets**
(`/admin/config/services/google_sheets`), gated by the core **Administer site
configuration** permission. The actual migrations are defined as configuration (in
your own module or via Migrate Plus), not through an admin screen.
