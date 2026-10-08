# Select With Search — manual setup guide

**Select With Search** (`selectwithsearch`) adds a new field widget that turns an
ordinary HTML `<select>` drop‑down into a searchable, type‑to‑filter list. Instead
of scrolling through hundreds of options — think a taxonomy of countries, a long
list of referenced entities, or any big select list — an editor starts typing and
the options filter down to what they're looking for. A label sits alongside the
search box so the field stays clear.

The widget is powered by a bundled copy of the Select2 jQuery library (CSS and
JavaScript ship with the module, so there are no external downloads or CDN calls),
and it keeps the standard select semantics and stored values intact — nothing
changes about how the data is saved. Early versions only handled single‑value
fields, but from 1.0.2 onward it also supports fields set to unlimited values.

It is purely a front‑end editing‑experience enhancement: no routes, no
permissions, and no server‑side data handling beyond the normal field widget. You
switch it on per field through the entity's form display. It runs on Drupal 9 and
10, and is not covered by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Select With Search has no central settings page — you apply it field by field.
Go to **Structure → Content types → [your type] → Manage form display**
(`/admin/structure/types/manage/[type]/form-display`), find a field that renders
as a select list, and change its **Widget** to **Select With Search**. Save the
form display.

From then on, the content edit form shows that field as a searchable drop‑down:
click it, start typing, and the options filter live. The saved value is exactly
what a normal select would store, so you can switch the widget on or off at any
time without affecting existing content.
