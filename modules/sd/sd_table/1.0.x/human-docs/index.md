# SD Table — manual setup guide

**SD Table** (`sd_table`), or "Super Dynamic Table", provides a new field type for
building rich, dynamic HTML tables directly in the content edit form. Instead of
juggling sub-fields, paragraph types per row, or hand-written table markup, an
editor builds the whole table — caption, an optional header column/row, and the
full grid of cells — right there on the node form. The entire table is stored as a
single JSON value.

Cells are rich: the field integrates with **CKEditor 5**, so editors can format
cell contents and include media. This makes it a good fit for editorial data tables
where a plain text field is too limited and a full spreadsheet import is overkill.

Because editors build **HTML tables that are then rendered on the page**, there is a
security consideration to keep in mind: the table content is subject to the
**text format's filtering**, so make sure the text format used sanitises input
(preventing any table markup from introducing cross-site scripting), and restrict
the field and its format to **trusted editors**. The module itself has no
access-control role — it adds a field type, not permissions or a settings form.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

SD Table has no central settings page; you use it by adding an **SD Table** field to
a content type (or other fieldable entity):

1. Go to **Structure → Content types → (your type) → Manage fields**.
2. Click **Create a new field** and choose the **SD Table** field type.
3. Configure the field like any other (label, cardinality), then save.
4. On the entity's **Manage form display** and **Manage display** tabs, confirm the
   SD Table widget and formatter are selected.

Editors will then see the dynamic table builder on the edit form, where they can add
the caption, mark a header, and fill in cells with CKEditor 5-formatted content.
Make sure the text format available to those editors sanitises HTML, as noted above.
