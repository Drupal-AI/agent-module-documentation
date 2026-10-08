# Options Table — manual setup guide

**Options Table** (`options_table`) gives you a new field widget called
**Draggable Table** for options-style fields. It does the same job as Drupal
core's *Check boxes/radio buttons* widget — letting an editor tick which of a
fixed set of values apply — but it adds one thing core cannot do on its own: a
drag-and-drop **Weight** column, so the selected values are stored in an order
the editor chooses.

That matters whenever the *sequence* of selected values carries meaning. Think
of an ordered list of "sections to display", a ranked set of related articles,
tiers, steps, or featured tags. With the standard checkboxes widget the values
come back as an unordered set; with the Draggable Table widget the editor ticks
the rows they want and drags them up or down, and that order is saved as the
field's delta order for a template or view to render.

The widget applies to core List fields (`list_string`, `list_integer`,
`list_float`) and to `entity_reference` fields. On a multi-value field it shows
checkboxes and lets you reorder; on a single-value field it shows radio buttons
(there is nothing to reorder, but the look stays consistent). It has just one
setting of its own — an optional heading for the toggle column — and it adds no
admin page, no permissions, and no Drush commands. Its only requirement is
core's **Options** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Options Table has **no settings page of its own**. Everything happens on the
form-display configuration of whichever entity you are working with. You choose
the widget per field, per form mode, on that bundle's **Manage form display**
tab — for example an Article at
**Structure → Content types → Article → Manage form display**
(`/admin/structure/types/manage/article/form-display`).

## How to use it

1. Make sure the field you want to use it on is an options field —
   a List field (`list_string`, `list_integer`, `list_float`) or an
   `entity_reference` field.
2. Go to the bundle's **Manage form display** tab (the example above uses
   Article; any entity type with a form display works, including users and
   media).
3. Find your field's row. In the **Widget** column, choose **Draggable Table**.
4. *(Optional)* Click the gear/cog icon at the end of that row to open the
   widget settings. The only option is **Toggle label** — a heading shown above
   the checkbox/radio column (for example "Show?"). Leave it blank and the
   summary simply reads "No toggle label". Click **Update** when you are done.
5. Click **Save**.

From then on, editors filling in that field see a table with a drag handle and a
**Weight** column. They tick the rows they want and drag them into the order
they prefer. For multi-value fields, that drag order becomes the order the values
are stored in — so anything that renders the field (a view, a Twig template)
gets them in the editor's chosen sequence. No field storage or field type
changes are needed, so you can switch an existing options field from plain
checkboxes to the Draggable Table widget at any time.
