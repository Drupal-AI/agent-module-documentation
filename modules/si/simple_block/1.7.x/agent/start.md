<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Block — agent index

Title/content custom blocks stored as **config entities** (`simple_block`), so they deploy via
config management. Rendered by a per-entity block derivative `simple_block:<id>`. No `configure`
route in info, but the admin UI lives at `/admin/structure/block/simple-block`.

- **Create/manage blocks (UI, drush, config entity shape), place them, tokens, clone** →
  [configure/blocks.md](configure/blocks.md)
- **The config entity, block derivative, entity-reference formatter, cache tags, token** →
  [api/entity-and-plugins.md](api/entity-and-plugins.md)
- **Permissions that gate edit/clone/delete (and `administer blocks` for add/list)** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config entity `simple_block` (`config_prefix: simple_block`) with keys `id`, `title`,
  `content` (`text_format`: `value` + `format`). Config name: `simple_block.simple_block.<id>`.
- Block plugin id `simple_block`, derived per entity → **`simple_block:<id>`** (renders
  `processed_text` with global token replacement).
- Field formatter `simple_block_rendered_entity` for `entity_reference` fields.
- Depends on `block` + `filter`. Submodule **simple_block_layout_builder** adds Layout Builder
  create/edit → [../../modules/simple_block_layout_builder/1.7.x/agent/start.md](../../modules/simple_block_layout_builder/1.7.x/agent/start.md)
