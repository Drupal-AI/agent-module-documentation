# Autocomplete List — manual setup guide

**Autocomplete List** (`autocomplete_list`) is an entity‑reference field widget
that replaces Drupal core's clumsy multi‑value reference form. Core renders one
text row per reference value plus a spare empty row, which becomes awkward the
moment you need to attach many entities. This module gives you instead a single
autocomplete box: you type, pick a match, and it is appended to a visible list of
everything you have selected so far. Each item in that list can be removed
individually, and the whole thing is driven by Drupal's built‑in AJAX.

It is a pure field widget — there is no settings page and no admin menu item. You
turn it on per field, on a bundle's **Manage form display** screen, by choosing
the **Autocomplete (List style)** widget for a multi‑value entity‑reference field.
The widget offers the same familiar options as core's autocomplete: a match
operator (**Contains** or **Starts with**), the width of the text box, and
placeholder text.

It works with any `entity_reference` field — taxonomy terms, nodes, users, or any
other referenceable entity — and is aimed at high‑cardinality fields where you
regularly select a lot of values (tagging, curating related content, and so on).
Selected values still go through the field's normal validation constraints, and
labels are rendered through Drupal's safe filtered markup, so it introduces no new
security surface: it has no routes, permissions, or services of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [How to use it](#how-to-use-it) — apply the widget to a reference field.

## Where it lives in the admin menu

The module adds no admin menu item and no global settings page. Everything is
configured per field, at **Structure → (your entity type) → Manage form display**
(for example, for an Article content type:
`/admin/structure/types/manage/article/form-display`).

## How to use it

1. Make sure you have a **multi‑value entity‑reference field** on the bundle you
   want to edit (or add one under **Manage fields**).
2. Go to that bundle's **Manage form display** screen.
3. In the **Widget** column for your reference field, choose
   **Autocomplete (List style)**.
4. Click the gear icon to configure the widget:
   - **Match operator** — **Contains** (matches anywhere in the label) or
     **Starts with** (matches only from the beginning).
   - **Size of textfield** — the width of the autocomplete box (default 60).
   - **Placeholder** — hint text shown in the empty box.
5. Save. On the entity's edit form the field now shows one autocomplete box; each
   entity you pick is added to a list below it, and each list item has a control to
   remove it.
