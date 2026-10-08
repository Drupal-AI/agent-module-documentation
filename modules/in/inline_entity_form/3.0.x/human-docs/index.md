# Inline Entity Form — manual setup guide

**Inline Entity Form** (`inline_entity_form`), often shortened to **IEF**, lets
editors create, edit, and remove *referenced* entities directly inside the parent
entity's form — instead of saving the parent, jumping off to a separate add/edit
page for each child, and coming back. Think of an order that owns its line items,
or a product that owns its variations: with IEF the child entities are managed
right there on the parent form.

It solves the "endless page‑hopping" problem you get with plain entity‑reference
fields. Rather than an autocomplete box that only points at things you built
elsewhere, IEF embeds the child's own edit form (or a whole sortable table of
them) into the page you are already on. It works with both `entity_reference` and
`entity_reference_revisions` fields, so it pairs naturally with Paragraphs‑style
nested content, and it is the mechanism Drupal Commerce uses to edit product
variations and order line items.

Enabling the module does **not** change any form on its own. IEF ships two field
*widgets* — **Inline entity form - Simple** and **Inline entity form - Complex** —
that you switch on per field on that field's **Manage form display** tab. Until
you pick one of those widgets for an entity‑reference field, nothing looks
different. There is no global settings page: every option lives on the widget
itself. The module has no dependencies beyond Drupal core and adds no submodules
or permissions of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

IEF has **no admin configuration page**. You turn it on one field at a time:

1. Start from an entity‑reference field (a field of type *Entity reference* or
   *Entity reference revisions*) on whichever bundle you want to edit inline — for
   example a "Line items" field on an Order, or a "Variations" field on a Product.
   Add such a field under **Structure → (your content type) → Manage fields** if
   you don't have one yet.
2. Go to that bundle's **Manage form display** tab
   (**Structure → (your content type) → Manage form display**).
3. Find your reference field in the list and, in the **Widget** column, choose one
   of:
   - **Inline entity form - Simple** — for a field that references a *single*
     entity. The child's form is embedded straight into the parent form.
   - **Inline entity form - Complex** — for a field that references *multiple*
     entities. They appear in a drag‑to‑sort table with **Add new** and (if you
     allow it) **Add existing** buttons.
4. Click the **gear/cog icon** next to the widget to open its settings, then
   **Save**.

The widget settings are where all of IEF's behavior is tuned — which entity
**form mode** renders the child form, whether editors may create brand‑new
entities (`allow_new`) and/or attach existing ones (`allow_existing`), custom
singular/plural button labels, whether to collapse the inline form into an
expandable *details* element, whether saving creates a new revision of the child,
what happens to a child when its reference is removed (keep it, delete it, or let
the editor decide), and — for the Complex widget only — whether editors may
duplicate an existing row. Once saved, open the parent entity's add/edit form and
you'll see the child entities managed inline.

For a field‑by‑field breakdown of every widget setting, see the agent doc
[`agent/configure/widgets.md`](../agent/configure/widgets.md).
