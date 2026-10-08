# Checkall Widget — manual setup guide

**Checkall Widget** (`checkall_widget`) is a small convenience for content editors:
it provides a field widget for options‑buttons (checkbox‑list) fields that adds a
**check‑all / select‑all** control. Instead of ticking (or un‑ticking) each box one
at a time, an editor can toggle every option at once — handy on multi‑value option
fields with a long list of choices, such as categories, features, or tag‑style
selections.

It's purely an input‑ergonomics feature. The values stored are still the field's
normal allowed options, and the module has no access implications and no settings
form of its own — you simply choose it as the widget on the field's form display. It
requires nothing beyond Drupal core.

There's a nice bit of context worth knowing: this functionality is planned to be
merged into Drupal core (core issue #3459246), so on a future core version you may
not need a contrib module for it at all. For now, this is the OOP‑based option among
several similar projects. Note the module is minimally maintained.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. You enable it per field on the
form display, as described below.

## Where it lives in the admin menu

Checkall Widget adds no admin page. You select it as a widget from **Structure →
*(your entity type)* → Manage form display** — for example a content type at
`/admin/structure/types/manage/<type>/form-display`.

## How to use it

1. Add (or find) an **options‑buttons** field — a list/options field displayed as
   **checkboxes** with more than one allowed value.
2. Go to the bundle's **Manage form display** (Structure → the entity type → Manage
   form display).
3. In the **Widget** column for that field, choose the **Checkall Widget**.
4. Save the form display.

Now, when editing content, that field shows a check‑all/select‑all control that
toggles all the checkboxes at once.
