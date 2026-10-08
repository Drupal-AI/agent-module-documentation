# Inline Entity Form Dialog — manual setup guide

**Inline Entity Form Dialog** (`inline_entity_form_dialog`) gives you an
entity‑reference field **widget** that lets editors add, edit, reorder, and remove
referenced entities without ever leaving the page they are working on — and,
crucially, without nesting one Drupal form inside another. When an editor clicks
**Add** or **Edit**, the referenced entity's own form opens in a Drupal modal
dialog (a completely separate page request), and when they save, the item row
slides into place in the widget's table. The parent form is never rebuilt.

It exists as a stable, zero‑dependency alternative to the venerable
[Inline Entity Form](https://www.drupal.org/project/inline_entity_form) module.
Drupal's Form API was never designed to embed a full form — with its own form
state, validation, submit handlers, and AJAX — inside another form running through
the same pipeline. That is the source of IEF's well‑known headaches: form‑state
bleed, cascading AJAX failures on rebuild, submit‑handler ordering conflicts, and
repeated breakage on minor core updates. This module sidesteps all of that: the
parent form stores only a JSON array of entity IDs in a hidden input, and on save
it hands Drupal the ordinary `['target_id' => $id]` array that every reference
widget produces. It does **not** require, extend, or interact with the
`inline_entity_form` module.

You can use it on any entity type that has an entity‑reference field — nodes, block
content, media, and so on. It pairs naturally with
[Entity Reference Revisions](https://www.drupal.org/project/entity_reference_revisions)
for Paragraphs‑style content, and its structural CSS defers to your admin theme
(Gin looks especially tidy with the dialog workflow).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no site‑wide settings page** for this module. All of its options live
on the widget itself, which you configure per field in **Manage form display** —
described in "How to use it" below.

## Where it lives in the admin menu

Inline Entity Form Dialog adds no Configuration‑section page. You set it up
entirely from **Structure → Content types (or any entity type) → Manage form
display**, where you switch a reference field's widget and tune its options with
the gear icon.

> **Access note.** The module's two dialog routes
> (`/inline-entity-form-dialog/{entity_type_id}/{bundle}/add` and
> `.../{entity_id}/edit`) are gated only by the core **Access administration
> pages** permission. They build the requested entity's form but do not
> additionally re‑check that the user may create that bundle or update that
> specific entity, so grant **Access administration pages** only to roles you
> trust as editors.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Content types → *(your type)* → Manage form display** (or
   the equivalent for whichever entity type carries the reference field).
3. Find your **entity‑reference** field in the widget list and change its widget to
   **Inline Entity Form Dialog**.
4. Click the gear icon (⚙) on that row to set the widget's options:

   | Setting | Default | What it does |
   |---------|---------|--------------|
   | **Form mode** | `default` | Which entity form display is rendered inside the dialog. Create a trimmed form mode (for example `inline_dialog`) to show editors only the fields that belong in the dialog. |
   | **Allow adding new entities** | On | Shows the **Add** button. It is hidden automatically once the field reaches its cardinality limit. |
   | **Allow editing existing entities** | On | Shows an **Edit** button on each item row. Turn it off for a reference‑only widget. |
   | **Dialog width (px)** | 800 | Width of the modal, with a 300px minimum. |

5. Click **Update**, then **Save** the form display.

Editors now get an item list with **Add**, **Edit**, **Remove**, and drag‑to‑reorder
controls. **Add** and **Edit** open the entity form in a modal; on save the row
appears without a page reload. **Remove** takes the reference off the list but never
deletes the underlying entity, and the order you drag rows into is persisted when
the parent form is saved.

> **Troubleshooting.** If a saved item does not appear in the list, open your
> browser's developer console and look for Inline Entity Form Dialog wrapper
> errors — that is the usual clue.
