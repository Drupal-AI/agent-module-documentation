<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Required Field Display (required_field_display) — agent index

Adds a red required-marker (a `*`) next to required fields on the Field UI admin screens, so a site
builder can see which fields a bundle requires without opening each field's edit form. It is a
**purely administrative display aid** — it changes nothing about the fields, their storage, or their
runtime validation, so it is free to add and free to remove. No dependencies, no routes, no
permissions, no configuration. Core requirement `^8.8 || ^9 || ^10 || ^11`.

The whole module is one procedural file (`required_field_display.module`, ~100 lines) plus one CSS
file. It hooks two Field UI screens:

- **Manage fields** (`admin/structure/types/manage/{bundle}/fields`) — `hook_preprocess_table()`
  adds the `required-field` class to the label cell of each required field's row in the
  `field-overview` table.
- **Manage form display** (`.../form-display`) — `hook_form_entity_form_display_edit_form_alter()`
  appends `<span class="required-field"></span>` after each required field's human name.

The CSS then renders a red `*` (`required-field`) or `* ∞` (`required-field-multivalue`, used when a
required field also has unlimited cardinality) via `::after`.

## What it marks as "required"

- Any field whose definition `->isRequired()` returns TRUE.
- If the optional **`require_on_publish`** module is enabled, also any field carrying its
  `require_on_publish` third-party setting (marked with the same indicator).

## What you'd do → where

- **How the marking works, both screens, the multivalue marker, and how to restyle/override it** →
  [fields/required_field_display.md](fields/required_field_display.md)

## Key facts (real names)

- File: `required_field_display.module`. No `src/`, no config, no schema, no permissions, no routes.
- Hooks: `required_field_display_help`, `required_field_display_form_entity_form_display_edit_form_alter`,
  `required_field_display_preprocess_table`.
- Library: `required_field_display/ui_styles` (attaches `css/required_field_display_ui.css`),
  attached to both altered screens; wrapper class `field-display-overview`.
- CSS classes: `required-field` (renders ` *`), `required-field-multivalue` (renders ` * ∞`), both
  in red (`#e32700`).
- `.info.yml` reports the legacy `version: '8.x-1.8'`; package `Fields`.
