# Entity Reference View Mode — manual setup guide

**Entity Reference View Mode** (`entityreference_view_mode`) provides a single
**compound field** that stores both an entity reference *and* a view mode. That
lets an editor reference another piece of content and, in the same field, choose
which view mode it renders in — a teaser here, full content there — without you
having to create multiple fields or duplicate display configurations.

The module ships a field type, a matching widget, and a formatter. On the entry
form the widget shows the entity selection control next to a view‑mode selector,
so the editor picks *what* to reference and *how* it should look, per item. On
display, the formatter loads the referenced entity and renders it through the
selected view mode using Drupal's standard entity view builder. This makes it
useful for related‑content or promotional blocks where the same reference should
appear differently depending on context chosen per item.

This 2.x branch lets you reference across **all entity types**. (The older 1.x
branch limited a field to a single entity type; note there is **no upgrade path**
between the two branches.) The module depends only on core's Field module and
defines no routes, permissions, services, or settings of its own — rendering goes
through the core view builder, so the referenced entity's own access checks and
view‑mode display configuration still apply.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form.
Everything is set up on your field, described in "How to use it" below.

## Where it lives in the admin menu

Entity Reference View Mode adds no admin page. You use it entirely from **Structure
→ *(entity type)* → *(bundle)* → Manage fields / Manage form display / Manage
display**, where its field type, widget, and formatter appear.

## How to use it

1. On a bundle, go to **Manage fields → Add field** and choose the **Entity
   Reference View Mode** field type. Configure which target entity type it can
   reference in the field settings.
2. On the bundle's **Manage form display**, the field's widget presents an entity
   selection control alongside a view‑mode select — this is where editors pick
   the referenced entity and its presentation per item.
3. On the bundle's **Manage display**, set the field's formatter to the
   **Entity Reference View Mode** formatter so it renders each referenced entity
   in the chosen view mode.
4. Edit content and, for each reference, select the entity and the view mode you
   want it displayed in.

Because rendering uses the core entity view builder, the referenced entity's own
access and display settings are respected automatically.
