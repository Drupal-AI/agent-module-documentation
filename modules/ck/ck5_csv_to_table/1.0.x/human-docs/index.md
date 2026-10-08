# CKEditor 5 CSV to Table — manual setup guide

**CKEditor 5 CSV to Table** (`ck5_csv_to_table`) adds a toolbar button to CKEditor 5
that turns a **CSV file into an editable HTML table** in one click. Instead of
building a table cell-by-cell or pasting HTML, an editor clicks the button, selects a
CSV file, and the module generates a clean, formatted table right in the editor. The
first row becomes the table header automatically, and the result is a standard
CKEditor table — so all the native table tools (add/remove rows, styling, merging)
work on it afterwards.

It is aimed at data-heavy content that changes regularly: pricing tables, reports,
comparisons, schedules, spec sheets, and anything a team maintains in Excel or Google
Sheets and needs to publish. It handles large files (up to 50MB) with chunked,
asynchronous processing and a live progress bar so the browser stays responsive even
with thousands of rows.

Security is a stated focus. The plugin strips scripts, iframes, event handlers and
dangerous protocols from cell content (XSS protection), blocks CSV-injection formulas
and executable content, validates the file's MIME type and extension, and enforces
DoS safety limits (roughly 6,000 rows, 100 columns, 10,000 characters per cell) with
a confirmation dialog before processing oversized files. Access is gated by a **Use
CSV Importer** permission, so you control exactly who can upload files. The module
depends on core **CKEditor 5** and supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no standalone settings page. You enable the button per text format at
**Administration → Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), and grant the import permission at **People →
Permissions**.

## How to enable the button in a text format

1. Go to **Configuration → Content authoring → Text formats and editors** and edit
   the format your editors use (for example *Full HTML*).
2. In the CKEditor 5 toolbar configuration, drag the **CSV** (CSV to Table) icon up
   into the active toolbar, then save.
3. At **People → Permissions**, grant the **Use CSV Importer** permission to the
   roles that should be allowed to upload CSV files. Only users with this permission
   see and use the button.

Editors with the permission can then click the CSV icon, choose a file, and watch the
table appear — fully editable with CKEditor's normal table tools.
