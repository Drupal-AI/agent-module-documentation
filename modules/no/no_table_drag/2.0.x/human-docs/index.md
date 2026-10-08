# No Table Drag — manual setup guide

**No Table Drag** (`no_table_drag`) lets site builders switch off the tabledrag
(drag-and-drop row reordering) interface on multi-value field widgets where it
gets in the way. Drupal shows those drag handles on every multi-value field by
default, but they aren't always wanted — sometimes order doesn't matter,
sometimes the handles just confuse editors, and on touch devices dragging rows
can be awkward. This module adds a `#nodrag` option so you can turn the
reordering UI off for the fields you choose.

It changes the **widget's reordering control only** — it does not touch your
data or affect access in any way. You toggle it either through the Field UI or
programmatically (the module's `README.md` covers the code path).

One caveat worth knowing before you install: the module **replaces the default
theme registry callback for the tabledrag theme function** with its own. If your
theme or site relies on a custom multi-field theme override, it may conflict with
this module — test on a non-production environment first. The module has no
dependencies beyond Drupal core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no central settings page** for this module — you apply it per field
widget, described in "How to use it" below.

## How to use it

Work from the **Manage form display** screen of the entity bundle whose field
you want to change:

1. Go to **Structure → Content types → *(your type)* → Manage form display**
   (`admin/structure/types/manage/{type}/form-display`).
2. Find your multi-value field and open its widget settings (the gear icon).
3. Enable the **No Table Drag / `#nodrag`** option, then update and save the
   display.

The field's rows will now render without drag handles, so editors add and edit
values without the drag-to-reorder interface. If you manage widgets in code, you
can set the same `#nodrag` flag programmatically — see the module's `README.md`.
