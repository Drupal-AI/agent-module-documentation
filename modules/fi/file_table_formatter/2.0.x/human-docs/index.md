# File Table Formatter — manual setup guide

**File Table Formatter** (`file_table_formatter`) is a **field formatter** that
displays the *contents* of an uploaded file as an HTML table. Point it at a file
field holding **CSV-formatted files** and, instead of rendering a download link,
it reads the file and renders its rows and columns as a table right on the page.
This lets you display — and update — tabular data on a site simply by editing and
re-uploading a CSV, without importing the data as nodes or other entities.

It currently supports **CSV files only**. Optionally, it integrates with the
[DataTables](https://www.drupal.org/project/datatables) module to add JavaScript
client-side sorting to the generated tables.

The module is configured entirely from a field's **Manage display** — it has no
settings page of its own. Its per-field options (whether the CSV has a header row,
and whether to use DataTables sorting) live behind the formatter's gear icon there.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and (optionally) add DataTables for client-side sorting.

There is **no separate configuration page** for this module. Everything is set up
on your field's display, described in "How to use it" below.

## Where it lives in the admin menu

File Table Formatter adds no admin settings page. You use it from **Structure →
Content types → *(content type)* → Manage display**, where you choose the "Display
file contents as a table" format for your file field.

## How to use it

1. On the content type that has (or will have) a file field, open **Manage fields**
   and add a **file field** if you don't already have one.
2. Click **Manage display** for that content type.
3. In the **Format** dropdown next to your file field, choose **Display file
   contents as a table**.
4. If your CSV files include a header row, click the field's **gear icon** and tick
   the header-row option so the first line is rendered as table headings.
5. Click **Save** at the bottom of the page.
6. Create a node of that type and upload a CSV file to the field. When you view the
   node, the file's contents appear as a table in place of a download link.

To give a table a heading, use the file's **Description** field — it becomes the
table's title.

### Optional: client-side sorting with DataTables

1. Download and install the **DataTables** module.
2. Return to **Manage display**, click the **gear** next to the field, and tick
   **Use javascript sortable data tables**.
3. Save.

Note that DataTables tables produced by this formatter default to disabling
pagination and default sorting. To enable those, override the
`theme_file_table_formatter_table()` function in your theme.
