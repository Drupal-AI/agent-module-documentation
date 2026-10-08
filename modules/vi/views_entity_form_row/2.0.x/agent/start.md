<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Entity Form Row — agent index

**Views row plugin that renders each result entity as its editable form in a chosen form mode**. Version **2.0.0**. Core `^11.3 || ^12`.

Depends on core `views`.

- Plugin: `views_entity_form_row` row plugin (`src/Plugin/views/row/EntityFormRow.php`, `#[ViewsRow]` attribute), derived per content entity type by `EntityFormRowDeriver`.
- One option: `form_mode` (string, default `default`); config schema `views.row.views_entity_form_row:*`.
- Each row builds a `ViewsEntityFormRowForm` (extends `ContentEntityForm`); form ID is `ENTITY_TYPE_BUNDLE[_FORM_MODE]_ENTITY_ID_form`.
- A row renders a form only when the user has `update` access to that entity (`$entity->access('update')`).
- Major 1.x→2.0 change: 2.x no longer swaps entity form handlers site-wide; dependency moved from core `node` to core `views`; Drupal 9/10 support dropped; theme hook/template removed.
