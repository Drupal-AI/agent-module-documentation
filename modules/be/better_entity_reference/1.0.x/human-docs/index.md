# Better Entity Reference — manual setup guide

**Better Entity Reference** (`better_entity_reference`) is a nicer field widget
for entity‑reference fields. Instead of the default stack of autocomplete rows,
the entities you have selected appear as removable tags, and a small popover lets
you add or remove references quickly and visually.

It is aimed at multi‑value reference fields, where the standard "one autocomplete
box per value" arrangement gets tedious. With this widget the current selections
are always visible as tags, and adding another is a matter of opening the popover
rather than adding a new row.

This is purely an editing‑experience enhancement. It has no permissions, routes,
or content of its own, and it renders its output through Drupal's normal escaping,
so there is nothing to lock down. You choose it per field on the form display, and
that is the whole story. It supports Drupal 10.6+, 11.3+, and 12.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no settings page — you switch a field over to the widget on its form
display:

1. Go to the entity's **Manage form display** tab (for example **Structure →
   Content types → Article → Manage form display**).
2. Find your entity‑reference field and, in the **Widget** column, choose the
   Better Entity Reference tag widget.
3. Click **Save**. When editors open the form, that field now shows its selections
   as tags with an add/remove popover.

Repeat for any other entity‑reference field where you want the tag widget.
