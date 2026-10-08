<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `block_content` Paragraph type

## Install
`drush en drowl_paragraphs_bs_type_block_content -y`.

## What it installs (config/install)
- `paragraphs.paragraphs_type.block_content` — the bundle.
- `field.storage.paragraph.field_block_content` + `field.field.paragraph.block_content.field_block_content`
  (field type **`block_field`**) — lets an editor pick and configure a block plugin.
- `field_settings` — shared settings field.
- Default + preview view displays; the `.install` hook `..._update_9000()` re-imports
  `core.entity_view_display.paragraph.block_content.preview` from the shipped config.

## Editor shortcuts (`.module`)
`hook_form_layout_paragraphs_component_form_alter()` (fires only for a `block_content` paragraph) adds two
buttons to the component form:
- 'Custom block library' → `Url::fromRoute('entity.block_content.collection')`.
- 'Add custom block' → `Url::fromRoute('block_content.add_page')`.
Both open in a new tab; they are convenience links only (the target routes enforce their own access).

## Rendering
The referenced block is rendered by the block_field module via the block plugin system; block plugin
access is handled there.
