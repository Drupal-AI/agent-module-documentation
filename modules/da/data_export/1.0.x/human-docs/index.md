# Data Export — manual setup guide

**Data Export** (`data_export`) turns rows of data into downloadable documents
and spreadsheets. It can export from a named database table or from a custom SQL
query, and it writes the result in any of four formats — **CSV**, **XLSX**,
**PDF**, or **DOCX**. Administrators get two simple forms for this; developers
get a set of hook‑style helper methods (`exportCsv`, `exportXlsx`, `exportPdf`,
`exportDocx`) for generating the same files programmatically from their own code.

The module works on Drupal 10 and 11 and has no other module dependencies, but
each of the richer formats needs a PHP library installed with Composer: XLSX
needs **PhpSpreadsheet**, DOCX needs **PhpWord**, and PDF needs **TCPDF**. CSV
works with no extra library. See [Installation](installation/index.md) for the
exact Composer commands.

Because an export tool turns data into files, treat it as sensitive and restrict
**who** can run exports to trusted roles, through Drupal's normal Permissions page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, add the
   export‑format libraries you need, and enable the module.
2. [Configuration](configuration/index.md) — the two export forms (Export Using
   Table Name and Export Using Code), field by field, plus the permissions to set.

## Where it lives in the admin menu

The export screens live under **Export Data** in the admin menu — **Export Data
→ Export Using Table Name** and **Export Data → Export Using Code**. Assign the
relevant permissions on **People → Permissions** before letting non‑administrators
use them.
