# Term CSV Export/Import — manual setup guide

**Term CSV Export/Import** (`term_csv_export_import`) adds two admin forms for
moving taxonomy terms in and out of Drupal as CSV. You can bulk-**import** terms
by pasting CSV text, and **export** a vocabulary's terms to CSV — in both cases the
parent/child hierarchy is preserved. It's the quick way to seed a category tree
from a spreadsheet, back up a vocabulary, or migrate terms between two sites.

The **Import** form is a short three-step flow: paste your CSV and choose a target
vocabulary (or create a new one inline), fill in the new vocabulary's details if
needed, then confirm the term count and import. The **Export** form is two steps:
pick a vocabulary and a few options, then copy the generated CSV from a textarea.
Hierarchy is expressed with a `parent_name` (or `parent_tid`) column, and a term
can have multiple parents by separating them with a semicolon.

Options give you control over round-trips and migrations: you can include or omit
term IDs, include a header row, and include extra taxonomy fields (encoded into a
trailing column). Import options let you **preserve existing terms** (skip rather
than overwrite on an ID clash — useful when importing from another install) and
**preserve vocabularies** for terms that already exist elsewhere. A bundled
`d7exportview.txt` Views export helps pull terms out of a Drupal 7 site. The module
depends on core's **Taxonomy** and **System** modules, and everything is gated by a
single permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the permission.
2. [Configuration](configuration/index.md) — the import and export forms, the CSV
   column format, and every option.

## Where it lives in the admin menu

The two forms live under **Configuration → Content authoring**: the Import form at
`/admin/config/content/term-csv-import` and the Export form at
`/admin/config/content/term-csv-export`. Both are reached by users with the
**Administer CSV Term Import** permission.
