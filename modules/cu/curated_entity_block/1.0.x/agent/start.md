<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Curated entity block (curated_entity_block) — agent index

Turns a **View** into a **placeable block** whose entities an editor hand-picks and orders, rendered
in **one chosen view mode**. Package `Custom`. Depends only on core **`views`**. Core requirement
`^10.3 || ^11`. License GPL-2.0-or-later. Version 1.0.0. No permissions, no routes, no services,
no Drush, no `.module`/`.install`.

- **The block: pick/order UI, rendering, view-mode select, entity-count bounds, Canvas & Custom
  Elements** → [blocks/curated-entity-block.md](blocks/curated-entity-block.md)
- **The Views display plugin: options, site-builder setup, the example View, config schema** →
  [views/display.md](views/display.md)

## What it actually is (from source)

Three plugins plus one config-schema file and one example View — no top-level config form.

- **Views display plugin** `curated_entity_block` — `src/Plugin/views/display/CuratedEntityBlock.php`,
  extends core `EntityReference`. Adds display options `allowed_view_modes`, `render_mode`
  (`default`|`custom_element`), `min_entities`, `max_entities`, `step_entities`. The display is
  both the block's selection pool (its filters/sort/access) and the source the deriver turns into a
  block.
- **Block deriver** `CuratedEntityBlockDeriver` — `src/Plugin/Derivative/CuratedEntityBlockDeriver.php`.
  One block per enabled view display built on `curated_entity_block` (mirrors core `ViewsBlock`).
  Bakes `view_id`, `display_id`, `target_entity_type_id`, `render_mode` into each derivative.
- **Block plugin** `curated_entity_block` — `src/Plugin/Block/CuratedEntityBlock.php`, extends
  `BlockBase`. `blockForm()` renders a tabledrag pick/order table (entity autocomplete via the
  `views` selection handler) + a view-mode `select`; `build()` loads and renders the picks.
- **Config schema** `config/schema/curated_entity_block.schema.yml` — `block.settings.curated_entity_block:*`
  (marked `FullyValidatable` so blocks qualify as Canvas components) and `views.display.curated_entity_block`.
- **Example View** `config/install/views.view.curated_entities_example.yml` — published nodes, newest
  first; a starter pool that may be altered or removed.

## Key behaviors

- Block settings: `selected` (ordered entity IDs), `view_mode` (default `default`), `label_display`
  default `visible` (so Canvas schema validation passes). No selection ⇒ falls back to the view's
  first results (capped at `max_entities`, else 3).
- `build()` re-checks each entity's `view` access (`$entity->access('view', NULL, TRUE)`) and skips
  disallowed ones; adds their cache metadata. Custom Element rendering used only when `render_mode`
  is `custom_element` **and** the `custom_elements` service is present.
- `custom_elements` is an optional (dev/suggested) dep; a display set to `custom_element` gains a
  hard module dependency via `calculateDependencies()`.

See the two solution docs above for full detail.
