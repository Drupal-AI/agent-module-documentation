# Blizz Table Field — manual setup guide

**Blizz Table Field** (`blizz_table_field`) adds a **table field type** to Drupal,
edited through a spreadsheet-like grid powered by
[Handsontable](https://handsontable.com/). Editors enter rows and columns in a
familiar grid, the data is stored on the entity, and it is rendered back out as a
table.

Reach for it wherever content needs editable tables — specifications, feature
comparisons, schedules — and you'd rather give editors a comfortable spreadsheet
experience than have them hand-build HTML table markup. Because the field builds on
core's Field, File, Filter, and Image modules, cell content can include formatted
text and media, and Drupal's text formats apply to cell contents like anywhere
else.

This is a fields/content feature. It plays no role in access control — table data
is authored and rendered through Drupal's normal layers, and the field respects
whatever access applies to the entity that holds it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add a table field, set its widget and
   display, and adjust the module settings.

## Where it lives in the admin menu

You add and configure the table field through **Field UI** — for example
**Structure → Content types → [type] → Manage fields**, then **Manage form display**
and **Manage display**. The module also has its own settings form
(`blizz_table_field.settings_form`).

## How to use it

1. Add a new field of the **Blizz Table** type to a content type (or other
   fieldable entity).
2. On **Manage form display**, the field uses the Handsontable spreadsheet widget —
   editors fill in rows and columns in the grid.
3. On **Manage display**, choose the table formatter so the stored data renders as
   a table on the entity.

See [Configuration](configuration/index.md) for the details.
