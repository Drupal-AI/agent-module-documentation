# Json table — manual setup guide

**Json table** (`json_table`) is a field for storing and displaying tabular data,
kept in the database as a real JSON data type rather than plain text. Storing it as
JSON means developers can query the data properly in MySQL instead of treating it
as an opaque string. For editors, it turns a field into a friendly spreadsheet‑like
grid; for visitors, it renders that data as a table or a chart.

On the **editing** side, the widget gives you a JSON editor and a table input with
genuine spreadsheet conveniences: you can paste a table straight from Excel or load
a CSV file to auto‑fill it, set default values and lock the table, and use keyboard
shortcuts to work quickly:

- **Ctrl + D** — duplicate the current row
- **Alt + N** — add a new row
- **Ctrl + K** — delete the current row
- **Ctrl + ↑ / ↓** — move the current row up or down
- **Arrow keys** — move between cells

On the **display** side, the formatter can render the data as a **table**
(Bootstrap Table or DataTables) or as a **chart** (Google Charts or Chart.js), so
the same stored data can appear as a sortable grid or a visualization.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no site‑wide configuration page** for this module. All of its options
live on the field's widget and formatter settings, described in "How to use it"
below.

## How to use it

1. Add a **Json table** field to a content type (or other fieldable entity) via
   **Manage fields**.
2. On **Manage form display**, choose the Json table **widget**. In its settings
   you can define a default table, and optionally lock the table and customize cell
   input (text, select, or textarea). Editors can then paste from Excel or load a
   CSV to fill it in.
3. On **Manage display**, choose the Json table **formatter** and pick how the data
   should render — a table (Bootstrap Table or DataTables) or a chart (Google
   Charts or Chart.js).

> **A note on heavy libraries:** the module can integrate several optional
> JavaScript add‑ons. Some don't mix between the widget and the formatter, and
> **LuckySheet** in particular is very heavy and conflicts with the CKEditor
> dialog's jQuery UI — the maintainer recommends **x‑spreadsheet** instead for
> most cases.
