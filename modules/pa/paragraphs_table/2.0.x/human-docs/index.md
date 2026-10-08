# Paragraphs table — manual setup guide

**Paragraphs table** (`paragraphs_table`) displays and edits multi-value
Paragraphs fields as a **spreadsheet-style table** — one paragraph per row, its
sub-fields as columns — instead of the usual stack of separate paragraph forms.
It is ideal for tabular data such as team members, price rows, specifications, or
plan-comparison tables, where a grid is far easier to scan and fill in than a
tall column of forms.

It gives you two things for a Paragraphs reference field: a **display formatter**
that renders the paragraphs as an HTML table, and an **editing widget** that lets
content editors fill the paragraphs in a compact grid. The table can be
horizontal (a row per paragraph) or vertical (fields down the side), and the
formatter can optionally layer in JavaScript table libraries — **DataTables** for
sorting and search, **Bootstrap Table** for responsive styling, or **Google
Charts** to visualise numeric data as a chart. The widget adds conveniences like
paste-from-spreadsheet, showing all rows at once, and per-row duplicate.

There is also a JSON formatter for outputting the paragraphs as JSON to a
decoupled front end, and per-row edit / duplicate / delete operations backed by
dedicated paragraph-item pages. It requires the **Paragraphs** module and works
well alongside Display Suite and Field Permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — the Paragraphs dependency and
   installing with Composer.
2. [Configuration](configuration/index.md) — applying the formatter and widget
   to a field, their settings, and the permission.

## Where it lives in the admin menu

There is no central settings page. You enable the table **per field**, on the
host entity's **Manage display** (for the formatter) and **Manage form display**
(for the widget) — for example under **Structure → Content types → (type)**. The
field must be a Paragraphs reference field.
