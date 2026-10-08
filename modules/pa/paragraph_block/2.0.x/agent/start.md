<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraph Block (paragraph_block) — agent index

Exposes **paragraph types as block types**. Each paragraph type you opt in becomes a placeable
block (block-add UI + Layout Builder inline block) whose storage is one core `block_content`
entity holding a single paragraph. Package `paragraphs`. Version **2.0.0-rc4**. Core `^10 || ^11`.
License GPL-2.0-or-later.

## Dependencies

Contrib **paragraphs**, **form_decorator**, **block_form_alter** (composer: `drupal/block_form_alter ^2.1`)
and core **block_content**. Layout Builder is optional but a primary target. No permissions of its
own, no Drush, no config schema, no routes, no controllers.

## What it provides (from source)

- **One block-content bundle** `paragraph_block` (const `ParagraphBlockServiceInterface::BLOCK_TYPE`)
  with one `entity_reference_revisions` field **`field_paragraph_block_paragraph`**
  (`FIELD_NAME`, target_type `paragraph`, cardinality 1) — shipped as `config/optional/*`.
- **Service** `paragraph_block.service` (`ParagraphBlockService`): lists paragraph types whose
  `paragraph_block.status` third-party setting is on.
- **Form Decorator plugin** `ParagraphsTypeFormAlter` (form_decorator): adds the "Paragraph block
  settings" Enable checkbox to the paragraph-type add/edit form and saves the third-party setting.
- **Hooks** (`Hook/ParagraphBlockHooks`): `entity_type_alter` swaps in custom storage/access
  handlers; `block_type_form_alter`, `form_language_content_settings_form_alter`, `entity_duplicate`.
- **Custom storage** `CustomBlockContentStorage` / `CustomBlockContentTypeStorage`: synthesize
  per-paragraph-type "fake" bundles and transparently create a real `paragraph_block` block.
- **Access handler** `ParagraphBlockContentAccessControlHandler`: forbids standalone create of the
  base bundle.
- **Event subscribers**: `ControllerAlterSubscriber` hides the internal bundle from Layout Builder's
  inline-block chooser; `ConfigSubscriber` rewrites fake-bundle config dependencies on save.
- **Update hooks** (`.install`): migrate an older custom `paragraph_block` layout plugin to core
  `inline_block` and backfill inline-block usage.

## Solution docs

- **Enable a paragraph type as a block, config objects, operation** →
  [config/settings.md](config/settings.md)
- **Internal mechanism: service, storage handlers, hooks, subscribers, access** →
  [api/architecture.md](api/architecture.md)
