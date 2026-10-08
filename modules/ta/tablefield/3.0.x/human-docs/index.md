# TableField — manual setup guide

**TableField** (`tablefield`) adds a new field type that stores a grid of text
cells — rows and columns, like a small spreadsheet — directly on any content
type, taxonomy term, or other fieldable entity. Instead of building a separate
entity or embedding an HTML table by hand, editors fill in a simple grid of
inputs, and the field renders it as a proper HTML `<table>` on display.

Each table can carry a caption (helpful for screen readers), treat its first row
as a header and/or its first column as row headers, and be filled in a few ways:
type into the cells directly, add rows on the fly, paste tab‑ or comma‑separated
data straight from Excel, or upload a CSV file. On the display side you can offer
an "Export Table Data" link that streams the table back out as a CSV.

Because it is a standard Field API field, a table is automatically revisioned
with its host entity, can hold multiple values, and works with Views like any
other field. TableField depends only on Drupal core's Field module and ships two
optional submodules — **Tablefield Cellspan** and **Tablefield Required**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and choose the submodules you need.
2. [Configuration](configuration/index.md) — the module settings form plus the
   per‑field, widget, and formatter options, field by field.

## Where it lives in the admin menu

The module has a small global settings form at **Configuration → Content
authoring → Tablefield** (`/admin/config/content/tablefield`) where you set the
CSV separator and the default table size. The real work, though, happens on
individual fields: you add a **Table Field** to a content type under
**Structure → Content types → (your type) → Manage fields**, and set its display
under **Manage display**.

## How to use it

1. Add a field of type **Table Field** to a content type (or any fieldable
   entity) under **Manage fields**.
2. In the field settings, optionally set a default number of rows and columns and
   turn on options like CSV export or locked default values.
3. When creating content, editors fill in the grid, add rows, paste data, or
   import a CSV, then save.
4. Under **Manage display**, choose the **Tabular View** formatter and decide
   whether the first row is a header, the first column holds row headers, and
   whether to show the CSV export link.

See [Configuration](configuration/index.md) for every setting explained.
