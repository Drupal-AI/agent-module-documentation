<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Markup (entity_markup) — agent index

A per-field, per-view-mode admin UI that controls the **wrapper HTML tags and CSS classes** rendered
around entity fields, replacing small Twig `field--*.html.twig` overrides with configuration. Package
`Field`. Depends only on core **`field`**. Core `^8.9 || ^9 || ^10 || ^11`. License GPL-2.0-or-later.
Version dir 1.0.x (installed 1.0.0-beta5, pre-release).

## What it actually is

- One config entity type **`entity_view_markup`** (`src/Entity/EntityViewMarkup.php`), id
  `<entity_type>.<bundle>.<mode>`, storing a `field_markup` map keyed by field name.
- One dynamic edit form **`EntityMarkupEditForm`** (`src/Form/EntityMarkupEditForm.php`, `@internal`)
  reached through "Manage markup" tabs added next to Field UI's Manage fields/display.
- Applies its config at render time via **`entity_markup_preprocess_field()`** plus its own field
  templates and theme-suggestion alter (`entity_markup.module`, `templates/`).
- **No permissions of its own, no services beyond a route subscriber, no Drush, no plugin types.**
  Access reuses each entity type's `administer <type> display`.

## Solution docs

- **Config entity, edit form, schema, render/apply path** → [config/markup.md](config/markup.md)
- **Routes, "Manage markup" tabs/derivative, entity operation, hooks** → [routing/tabs.md](routing/tabs.md)
