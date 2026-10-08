<!-- SPDX-License-Identifier: LicenseRef-DXPR-Commercial -->
# DXPR Builder Block Type — agent index

Config-only submodule of **dxpr_builder**. Installs a custom block type
**`drag_and_drop_block`** ("Drag and Drop Block") whose `body` is edited with the DXPR Builder
formatter. No code, settings, permissions, schema, or Drush.

- **The block type, its body field and display** →
  [configure/block-type.md](configure/block-type.md)

Key facts:
- `block_content` bundle: `drag_and_drop_block` (config `block_content.type.drag_and_drop_block`,
  enforced to this module).
- `body` view-display component uses formatter `dxpr_builder_text`
  (`core.entity_view_display.block_content.drag_and_drop_block.default`).
- Depends on `dxpr_builder`, `text`, `node`. Parent docs:
  [../../../../2.8.x/agent/start.md](../../../../2.8.x/agent/start.md).
