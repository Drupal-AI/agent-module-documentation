# Entities Import — manual setup guide

**Entities Import** (`entities_import`) gives you a point-and-click way to import
data from **Excel or CSV files** into Drupal entities — content and taxonomy — 
without writing a migration. You define an *import type* that describes which
entity to create and how the spreadsheet maps to it, then upload a file to create
or update entities in bulk. It uses the `phpoffice/phpspreadsheet` library, so it
must be installed with Composer.

It handles the common field types you would expect in a spreadsheet import: plain
text, references to content or taxonomy, numbers, dates and date ranges, files and
images, and even paragraph fields. It can create new entities or update existing
ones (matched on the "unique value" fields you nominate), and it supports
multilingual imports when you include a `langcode` column. For file and image
fields you list the filename in the spreadsheet and then move the actual files to
the configured folder on the server after import.

> **Treat importing as a privileged operation.** Because it creates and updates
> entities, restrict the import permission to trusted users, and remember that
> spreadsheet content is **untrusted input that becomes site content** — validate
> and sanitize it, and be careful with mappings that could overwrite existing
> entities. The import acts with the importer's own privileges.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (required, for
   the spreadsheet library) and enable the module.
2. [Configuration](configuration/index.md) — create an import type and run an
   import.

## Where it lives in the admin menu

Import types are managed at **Structure → Entities Import**
(`/admin/structure/entities-import`), where you add and edit import types and
launch imports. The module also provides its own permissions, set under **People →
Permissions**.
