<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DROWL Paragraphs for Bootstrap Type: Block Content Reference (drowl_paragraphs_bs_type_block_content) — agent index

Sub-module of **drowl_paragraphs_bs**. Installs the `block_content` Paragraph type.

- **Field**: `field_block_content` (field type `block_field`) — selects and configures a block plugin
  (incl. custom content blocks). Shared `field_settings` (hidden).
- Rendered by the **block_field** formatter (block plugin system).
- `.module`: `hook_form_layout_paragraphs_component_form_alter()` adds two link buttons on the
  `block_content` paragraph form — 'Custom block library' (`entity.block_content.collection`) and
  'Add custom block' (`block_content.add_page`), both opening in a new tab.
- `.install`: `update_9000` re-imports the `preview` view display.
- Depends on `block_field`, core `block_content`. No routes/permissions/services/schema.

See [paragraphs/block-content.md](paragraphs/block-content.md).
