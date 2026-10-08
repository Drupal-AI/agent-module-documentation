<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Canvas Pattern Blocks (canvas_pattern_blocks) — agent index

Exposes a Drupal Canvas (Experience Builder) **pattern** as a placeable **block** that renders
the pattern live. Placing a pattern normally forks it (its component tree is copied into the host
page); this module keeps the pattern config as the source of truth by rendering it at request time,
so central pattern edits propagate to every page that placed the block.

- **Requires:** `drupal/canvas` (`^1.2`); `canvas:canvas` module dependency. Core `^10.3 || ^11`.
- **License:** GPL-2.0-or-later. **Package:** Canvas. No submodules, no Drush, no libraries, no services file.
- **Provides:**
  - **Config entity** `canvas_pattern_block` (`Entity/CanvasPatternBlock`) — a named handle storing
    `id`, `label`, and one `pattern` (a Canvas pattern ID). `config_export: [id, label, pattern]`.
  - **Block plugin** `canvas_pattern_block` (`Plugin/Block/PatternBlock`) with one derivative per
    config entity (`Plugin/Derivative/PatternBlockDeriver`); admin category "Pattern blocks".
  - **Admin UI** at `/admin/structure/canvas-pattern-block` (collection/add/edit/delete), via the
    entity's `AdminHtmlRouteProvider` default routes; menu + action links.
  - **Permission** `manage canvas pattern blocks` (restrict access), the entity's `admin_permission`.
  - **Config schema** for the config entity (`FullyValidatable`; `pattern` is `NotBlank`).

## How it fits together
- `PatternBlockDeriver` lists one block derivative per `canvas_pattern_block` entity.
- `PatternBlock::build()` loads the entity → loads its `pattern` → returns
  `$pattern->getComponentTree()->toRenderable($pattern, FALSE)` (Canvas core does the rendering).
- `CanvasPatternBlock::postSave()/postDelete()` call `refreshComponents()` to clear block plugin
  caches and regenerate Canvas block Components so the handle appears/updates in Canvas's library.
- `calculateDependencies()` adds a config dependency on the referenced pattern (delete-cascades).

## Solution docs
- Entity, block plugin, deriver, and rendering flow → [agent/plugins/pattern-block.md](plugins/pattern-block.md)
- Admin UI, routes, permission, config entity + schema → [agent/config/pattern-blocks.md](config/pattern-blocks.md)
