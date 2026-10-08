<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Fixed Block Content — agent index

Wraps a custom (`block_content`) block in a **`fixed_block_content` config entity** so a block
placement never breaks when the underlying content block is missing/unstaged. A derived block
plugin `fixed_block_content:<id>` is placeable in Block layout.

- **Create/manage a fixed block, its config keys, default-content export/import, admin UI** →
  [configure/fixed-blocks.md](configure/fixed-blocks.md)
- **The FixedBlockContentInterface API (getBlockContent, export/import, protected, auto_export)** →
  [api/entity-api.md](api/entity-api.md)
- **The derived block plugin (id, view mode, deriver)** →
  [plugins/block.md](plugins/block.md)

Key facts:
- Config entity type `fixed_block_content` (config prefix `fixed_block_content`). Keys:
  `id`, `title`, `block_content_bundle`, `default_content` (HAL-serialized), `auto_export` (int),
  `protected` (bool).
- Configure route / admin list: `entity.fixed_block_content.collection` =
  `/admin/structure/block-content/fixed-block-content`. Gated by core permission
  `administer block types` (the module defines no permissions of its own).
- Depends on `block_content` + `hal`. No Drush, no plugin types, no custom permissions.
