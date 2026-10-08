# CKEditor 5 Table Colors — manual setup guide

**CKEditor 5 Table Colors** (`ckeditor5_table_colors`) gives editors
customizable colour palettes for CKEditor 5 tables. With it, the table and
table-cell property dialogs offer your own colour schemes for backgrounds and
borders, so editors can style tables consistently — branded data tables,
colour-coded documentation, structured educational content — without typing hex
codes or hand-editing markup.

The module lets you define custom palettes (with optional descriptive labels),
choose whether to keep CKEditor 5's built-in default colours alongside yours,
turn an optional colour picker on or off for free-form choices, control how many
columns the colour grid uses, and show recently used "document colours". It is
part of the **CKEditor 5 Plugin Pack** family and pairs well with that project
for additional table features.

Two practical notes. The colours are applied as inline style on the table markup,
so make sure the text format's allowed tags and attributes permit that styling or
it will be stripped on save. And this is purely a content-editing feature — it
has no access-control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set up the colour palettes and
   related options per text format.

## Where it lives in the admin menu

Table Colors adds no standalone admin page. You configure it per text format at
**Administration → Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`) — see [Configuration](configuration/index.md).
Once set up, the colours appear in the table and table-cell properties dropdowns
while editing content.
