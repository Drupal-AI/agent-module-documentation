<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Attributes Paragraphs (entity_attributes_paragraphs) — agent index

Submodule of **entity_attributes** that adds Paragraphs support. Package **Fields**. Core `^11`.
Depends on `entity_attributes:entity_attributes` and `paragraphs:paragraphs`. No config, no
permissions, no schema of its own — it reuses the parent module's settings form, per-bundle
permissions and `entity_attributes.processor` service.

## What it provides

- **Plugin** `ParagraphAttributes` (id `paragraph`, `src/Plugin/EntityAttributes/ParagraphAttributes.php`)
  extending `ContentEntityAttributesBase` — entity type `paragraph`, `config_tab: paragraph`,
  `config_section: bundles`. It adds no overrides, so its supported attribute set is the base default
  `['attributes']` and storage is the standard `entity_attributes` `string_long` field.
- **Preprocess hook** `entity_attributes_paragraphs\Hook\PreprocessHooks::preprocessParagraph()`
  (`#[Hook('preprocess_paragraph')]`) → `processor->processContentEntityAttributes($paragraph,
  $variables, 'paragraph')`.

## Operate it

Enable the submodule, tick the paragraph bundles at `/admin/config/search/entity-attributes`, grant
`edit entity attributes paragraph {bundle}`, then print `{{ attributes }}` in the paragraph template.
See the parent module docs `modules/en/entity_attributes/1.2.x/agent/` for the full mechanism.
