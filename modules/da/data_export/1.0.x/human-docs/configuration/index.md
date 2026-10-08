# Configuration

Data Export has no global "settings" page — you configure each export at the
moment you run it, on one of two forms. This page walks through both, field by
field, and finishes with the permissions that decide who may use them.

## Before you start: permissions

Exports produce raw data files, so decide who can create them **first**. On
**People → Permissions**, grant the module's export permissions only to trusted
roles. Keep in mind:

- The "Export Using Code" form runs arbitrary SQL, so it is especially powerful.
  Reserve it for administrators or developers.

## Export Using Table Name

Reach it at **Export Data → Export Using Table Name**. Use this when you want
everything (or selected columns) from one database table.

- **Table name** — type the name of the database table to export from.
- **Columns** — choose the columns you want. If you leave this empty, **all**
  columns are included.
- **Format** — pick **CSV**, **XLSX**, **DOCX**, or **PDF**. Remember that
  XLSX/DOCX/PDF each need their PHP library installed (see
  [Installation](../installation/index.md)); CSV always works.
- **Export** — click to generate and download the file.

## Export Using Code

Reach it at **Export Data → Export Using Code**. Use this when a single table is
not enough — for example a join across tables or a filtered query.

- **SQL query** — enter a valid SQL query for the data you want.
- **Show Records** — click to preview the query result before exporting, so you
  can confirm you are pulling the right rows.
- **Format** — choose **CSV**, **XLSX**, **DOCX**, or **PDF**.
- **Export** — click to generate and download the file.

Because this form executes the SQL you type, treat access to it as you would
database access: keep it restricted to people you trust.

## For developers

If you would rather generate files from your own code than from these forms, the
module exposes helper methods that each take a `$headers` array (the column
titles) and a `$data` array (one sub‑array per row): `exportCsv()`,
`exportXlsx()`, `exportDocx()`, and `exportPdf()`. They validate that the number
of header columns matches the number of data columns and return an error —
"The number of columns in headers and data does not match." — if they do not.
