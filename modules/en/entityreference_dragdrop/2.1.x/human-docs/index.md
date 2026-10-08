# Entity Reference Drag & Drop — manual setup guide

**Entity Reference Drag & Drop** (`entityreference_dragdrop`) gives entity
reference fields a friendlier editing experience: instead of an autocomplete box
or a long list of checkboxes, editors see two side‑by‑side lists — **available**
entities on one side and **selected** entities on the other — and drag items
between them. Dragging within the selected list reorders it, and that order
becomes the field's stored order (its delta order).

It's a drop‑in **field widget**, chosen per field on an entity's **Manage form
display** tab. It works off the field's allowed‑values option list, so it fits any
entity reference field. Each option can render as just the entity's title (a
compact picker) or in any view mode of the target entity type (so you can preview
cards, thumbnails, or teasers while choosing).

Because it's a widget, there's nothing global to set up — no settings page, no
permissions, no schema, and no dependencies beyond Drupal core. You enable the
module, switch a field's widget to **Drag&Drop**, and you're done.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no dedicated settings page. You turn it on for a specific field at
**Structure → Content types → *(your type)* → Manage form display**
(`admin/structure/…/form-display`): set an Entity reference field's **Widget** to
**Drag&Drop**, then click the cog to configure it.

## How to use it

On **Manage form display**, change the field's widget to **Drag&Drop** and open
the cog. You get four settings:

- **Rendering (view mode)** — show each option as its **Title** (the default,
  compact) or render it in any view mode of the referenced entity type, so editors
  can see images or teaser cards while they choose.
- **Available entities label** and **Selected entities label** — the headings over
  the two columns, so you can relabel them to something like "All tags" / "Chosen
  tags."
- **Show filter** — adds a small client‑side text box above the list so editors
  can quickly find an entity in a long list.

When editing content, drag entities from the available column into the selected
column (and back), and drag within the selected column to set the order. The
chosen entities and their order are what get saved to the field. If the field has
a limited cardinality, the widget shows a "cannot hold more than N values" message
when the editor tries to exceed it. Single‑value reference fields work too — the
widget respects a cardinality of 1.
