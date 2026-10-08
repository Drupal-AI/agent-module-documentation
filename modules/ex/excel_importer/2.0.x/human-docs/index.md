# Excel Importer — manual setup guide

**Excel Importer** (`excel_importer`) creates Drupal nodes directly from an uploaded
Excel spreadsheet. It is the short path from a client's `.xlsx` file to site content
when building a full migration would be overkill — someone hands you a spreadsheet
once and wants it turned into a couple of hundred nodes, and this module does exactly
that.

It works on **structured** spreadsheets. Each **sheet** in the file must be named after
the **content type** its rows will be imported into, and the **column headings** must
match the **machine names** of that content type's fields. For entity-reference fields
(most often taxonomy terms), you use the referenced item's name/title — the friction
this module removes compared with the CSV Importer module. The parsing itself is done by
the `phpoffice/phpspreadsheet` library.

A few known limitations are worth planning around: there should be **no column named
"type"**; the importer does **not** create taxonomy terms on the fly (the referenced
terms must already exist); it does **not** handle multi-value fields; and XLSX files
exported from Google Sheets or Numbers can have trouble with empty rows.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer (it pulls
   in PhpSpreadsheet) and enable it.
2. [Configuration](configuration/index.md) — choose which content types can be imported
   into, add intro text, and grant the restricted permissions.

## Where it lives in the admin menu

- **Import page:** `/excel-import` — where you upload a spreadsheet and run the import.
  Note this is a front-end path, not under `/admin`, though it is still
  permission-gated.
- **Settings page:** **Configuration → Content authoring → Excel Importer**
  (`/admin/config/content/excel_importer`) — where you choose the allowed content types
  and add introductory text.

## How to use it

1. Configure the allowed content types and permissions — see
   [Configuration](configuration/index.md).
2. Prepare your spreadsheet: one sheet per content type (named to match the content
   type's machine name), with column headings matching the field machine names, and at
   least one of the allowed content types present as a sheet.
3. Go to **`/excel-import`**, read the on-page introductory text to confirm your file's
   structure is what's expected, select your Excel file, and upload it.
4. Click **Save** to run the import and create the nodes.

> **Trust and resources.** Both of this module's permissions are marked *restricted*,
> and rightly so. Importing creates content in bulk, bypassing the pace and review of
> normal authoring — so only trusted roles should have it. Just as important, every
> uploaded file is fed to **PhpSpreadsheet**, a large parser for a complex file format;
> spreadsheet-parsing libraries have a history of security advisories, so keep the
> dependency up to date and keep the "who may upload" permission narrow. Large files can
> also consume significant memory and time to parse.
