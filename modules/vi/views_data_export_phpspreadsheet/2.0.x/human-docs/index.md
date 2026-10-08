# Views Data Export phpspreadsheet — manual setup guide

**Views Data Export phpspreadsheet** (`views_data_export_phpspreadsheet`) lets a
Views "Data export" display produce a real Excel/OpenDocument spreadsheet —
`.xlsx`, `.xls`, or `.ods` — instead of only CSV. It plugs into the
[Views Data Export](https://www.drupal.org/project/views_data_export) module by
adding a new Views **style** ("Xlsx export") and a serialization **encoder**
backed by the PhpSpreadsheet library, so the file that visitors download is a
genuine workbook with formatting rather than comma-separated text.

Because it produces true spreadsheets, it can do things CSV can't: a bold,
merged **print header** row above the data, a **footer** line (optionally with
"Page X of Y" or a formula such as `=sum(D:D)`), **per-column background
colours**, auto-sized columns, clickable **hyperlinks**, embedded **images**
from image fields, and document **metadata** (creator, title, subject, and so
on). It is the tool of choice when you need to hand a native Excel report to
non-technical stakeholders.

This module is a plumbing layer, not a click-around feature: it has no settings
page of its own, no permissions, and no Drush commands. Everything is chosen
per view, inside the Views UI, on a Data Export display. It depends on core
**REST**, **Views**, and the **Views Data Export** module, and it requires the
`phpoffice/phpspreadsheet` library (pulled in automatically by Composer).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   PhpSpreadsheet library with Composer, and enable it.

## Where it lives in the admin menu

There is **no dedicated settings page**. Once enabled, the module surfaces
itself only inside **Structure → Views** (`/admin/structure/views`), as an extra
style option on Data Export displays.

## How to use it

You build a spreadsheet export the same way you build any Views Data Export,
then switch its style to the one this module provides:

1. Create (or edit) a View with a **Data export** display — this is the display
   type that Views Data Export adds.
2. Set that display's **Format/Style** to **Xlsx export** (`xls_data_export`).
3. In the style settings, choose one or more output **formats** — `xls`, `xlsx`,
   and/or `ods`. If you pick several, the last one selected is the one used at
   download time.
4. Open the **xlsx Settings** group to fine-tune the workbook. Every option is
   optional:
   - **Header** — a print header row placed above the data. A single value is
     rendered bold and merged across all columns; separate multiple column
     values with semicolons (`;`). Supports Views/Token replacement.
   - **Footer** — a footer line, also `;`-separated for multiple columns. A
     single value becomes a merged bold row and the page footer with
     `Page P of N`. It can contain a spreadsheet formula, e.g.
     `Total;;;=sum(D:D)`.
   - **Row Color** — a comma-separated list of **row numbers** (e.g. `1,2`) to
     colour, when you want to highlight specific rows rather than whole columns.
   - **Color** (per field) — pick a background colour for each column/field.
     Pure black (`#000` / `#000000`) is treated as "no colour". Colouring a
     column also auto-sizes it.
   - **Metadata** — document properties written into the file: creator, title,
     subject, description, keywords, category, manager, and company.
5. Save the view. The export downloads through Views Data Export's normal export
   path — this module adds no separate URL or permission, so access is whatever
   you already set on the Data Export display.

A few behaviours worth knowing: the worksheet is named after the View's title
(trimmed to letters, numbers and spaces, 31 characters max); linked field values
and bare `http(s)://` URLs become real clickable hyperlinks; an **image field**
can embed its picture directly into a cell (one image per field, limited to
`png`/`jpg`/`bmp`/`gif` files stored under the site); and in the Views **live
preview** the output falls back to CSV so you can check the data quickly.
Developers can also adjust the finished worksheet through two hooks,
`hook_xls_encoder_header_alignment()` and `hook_xls_encoder_data()`.
