# Configuration

Before anyone imports a spreadsheet, you decide **which content types** may be imported
into and **who** is allowed to run imports. Both are quick, but the permissions in
particular deserve care.

## Open the settings form

1. Log in as a user with the **administer excel_importer** permission (see below).
2. Go to **Configuration → Content authoring → Excel Importer**
   (`/admin/config/content/excel_importer`).

## Settings

- **Introductory text** — free text shown on the import page (`/excel-import`). Use it
  to give importers instructions, and to link to template files or documentation so they
  build their spreadsheet correctly.
- **Content types** — tick the content types that may be imported into. Only these types
  are available to importers, and the template spreadsheet must include at least one of
  them as a sheet (named to match the content type's machine name).

Click **Save configuration**.

## Permissions — both are restricted

Excel Importer defines two permissions, and **both are marked "restrict access"** on the
permissions page because both are powerful:

- **use excel_importer** — lets a user open `/excel-import` and run imports. This
  creates content in bulk, bypassing normal authoring review, so grant it only to
  trusted roles.
- **administer excel_importer** — lets a user change these settings (which content types
  can be imported into).

Grant these at **People → Permissions** (`/admin/people/permissions`). Keep the "use"
permission narrow in particular: it decides who may hand arbitrary uploaded files to the
PhpSpreadsheet parser.

## Preparing the spreadsheet

For an import to succeed, the file must be structured to match your site:

- **One sheet per content type**, with each sheet **named exactly** like the content
  type's machine name.
- **Column headings** matching the **field machine names** of that content type.
- For entity-reference fields (e.g. taxonomy terms), use the referenced item's
  **name/title** — and make sure those terms already exist, since the importer does not
  create them on the fly.
- **No column named "type"**, and remember multi-value fields are not handled. Watch for
  stray empty rows in files exported from Google Sheets or Numbers.

## Running an import

Once configured, importers go to **`/excel-import`**, read the introductory text you
set, choose their file, and click **Save** to create the nodes.
