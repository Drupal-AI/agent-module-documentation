# Multiple Selects — manual setup guide

**Multiple Selects** (`multiple_selects`) gives you a friendlier way for editors to
fill in multi-value option fields. Normally a field that can hold several values
renders as one native `<select multiple>` box — the kind where you have to
Ctrl/Cmd-click to pick more than one option. That control is awkward, especially on
touch devices. This module replaces it with a stack of ordinary single dropdowns:
one plain `<select>` per value, plus Drupal's familiar **Add another item** button
and drag-to-reorder handles.

It's a single field **widget**, called **"Multiple select list(s)"**, that you
choose on a field's *Manage form display* tab. It applies to multi-value option
fields — **entity reference** (tags, related content, users), and the **List
(text/integer/float)** field types — when their cardinality is greater than one
(either a fixed number, like 3, or unlimited). On a single-value field it just
behaves like a normal dropdown. Switching to it changes only the editing
experience; the stored data and the display are untouched.

If you also have the [Select2](https://www.drupal.org/project/select2) module
installed, the widget can render each row as a searchable Select2 dropdown instead
of a plain one — handy for fields backed by a large vocabulary.

The module needs only core's Field module and works on Drupal 8.8 through 11. There
is no admin settings page — everything is set per field.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

It has no page of its own. You apply the widget on the **Manage form display** tab
of whichever bundle holds your multi-value option field — for example
`/admin/structure/types/manage/article/form-display`.

## How to use it

1. Make sure your field is a multi-value option field: an **entity reference** or
   **List (text/integer/float)** field with **cardinality greater than 1** (a fixed
   number or unlimited). That's set on the field's storage settings.
2. Go to the bundle's **Manage form display** tab.
3. Change that field's **Widget** to **Multiple select list(s)**.
4. Click the gear/cog icon and choose the **Element type**:
   - **Select** — a plain HTML dropdown per row (always available).
   - **Select2** — a searchable dropdown per row (only offered if the *Select2*
     module is installed).
5. Click **Update**, then **Save**.

Editors now see one dropdown per value, an **Add another item** button to add more,
and drag handles to reorder them. If the field is required, Drupal enforces "choose
at least one" across all the rows rather than demanding every row be filled.

> **Upgrading from an older version?** If you used this widget before the Element
> type option existed, run database updates (`drush updb`) after updating the
> module — it backfills the setting on your existing form displays.
