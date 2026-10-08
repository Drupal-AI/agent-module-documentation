# Field Group Table — manual setup guide

**Field Group Table** (`field_group_table`) adds a new **"Table"** layout option to
the [Field Group](https://www.drupal.org/project/field_group) module. When you group
a set of fields together, this format renders them as a tidy two‑column table: the
field labels run down the left column and the rendered field values sit in the right
column — the classic "label / value" spec‑sheet layout.

It is perfect for the "at a glance" tables you see all over content sites: product
attributes (SKU, dimensions, weight), profile details, contact and address blocks, or
any comparison/specification section. Instead of building a custom template, you drag
the relevant fields into a group, choose the **Table** format, and Drupal draws the
table for you — on the display, on the edit form, or both.

The format gives you plenty of control over how the table looks: whether and where
the group label shows (including as a proper `<caption>`), custom column headers,
zebra striping, how empty labels and empty fields are handled (keep the cell, merge
the row full‑width, show a placeholder, or hide the whole table), and more. For
developers, a single alter hook (`hook_field_group_table_rows_alter()`) lets you add
or remove rows programmatically. All settings are saved as part of the entity's
display configuration, so they export and deploy like any other display setting.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Field Group.

There is no separate settings page — you configure everything on the entity's Manage
display / Manage form display screens, described below.

## Where it lives in the admin menu

Field Group Table has no admin page of its own. Its **Table** format appears wherever
Field Group does — on a bundle's **Manage display** and **Manage form display**
screens (for example **Structure → Content types → [type] → Manage display**).

## How to use it

1. Go to the bundle's **Manage display** (for the rendered view) or **Manage form
   display** (for the edit form) — for example
   `/admin/structure/types/manage/article/display`.
2. Click **Add field group** (a Field Group button), give it a label and machine name,
   and set its **Format** to **Table**.
3. Drag the fields you want into the new group, and **Save**.
4. Click the group's gear/cog icon to open its **Table format settings**, then tune
   any of the following:
   - **Label visibility** — hide the group label, show it above the table, render it
     as the table's `<caption>`, or place it below.
   - **Description** and its visibility — optional help text above or below the table.
   - **First / second column headers** — custom header text (e.g. "Property" and
     "Value"); a header row appears when you set either.
   - **Empty label behavior** — for rows whose label is empty, either keep the empty
     label cell (to preserve column alignment) or merge the two cells into one
     full‑width row.
   - **Table row striping** — zebra‑stripe alternating rows for readability.
   - **Always show field label** — force every field's label into the first column,
     regardless of the field's own label setting.
   - **Always show field value** (with an **empty field placeholder**) — render a row
     even when a field has no value, showing your placeholder text (like "—") instead.
   - **Hide table if empty** — output no markup at all when the group has no populated
     fields.
5. **Save** the settings.

Each field in the group becomes one table row (a `<th>` label cell plus a value
cell). Because Field Group groups can nest, you can even drop a Table group inside
other Field Group layouts such as tabs or accordions.
