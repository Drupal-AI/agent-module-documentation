<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FieldTextExtractor plugins for asymmetric Layout Builder

The module is a thin extension of **AI Translate** (`ai_translate`, a Drupal AI submodule). It adds
two `FieldTextExtractor` plugins and nothing else — no routing, `*.services.yml`, `*.permissions.yml`,
`*.install`, config or hooks exist in the project.

## Install & enable

```bash
composer require drupal/ai_translate_lb_asymmetric
drush en ai_translate_lb_asymmetric -y
```

Requires the **AI Translate** submodule of Drupal AI, core **content_translation**, and **Layout
Builder Asymmetric Translation** (`layout_builder_at`). Composer pulls `drupal/ai:^1.0@beta`.

Post-install (from README):

1. Make the field that references the layout/blocks **translatable**.
2. Keep the **block fields themselves non-translatable**.
3. Translate as usual via AI Translate's one-click action.

## Plugin 1 — `layout_builder_asymmetric` (`LbAsymmetricExtractor`)

`src/Plugin/FieldTextExtractor/LbAsymmetricExtractor.php`, `#[FieldTextExtractor(id:
"layout_builder_asymmetric", field_types: ['layout_section'])]`, extends
`Drupal\ai_translate\Plugin\FieldTextExtractor\LbFieldExtractor`. `create()` wires
`config.factory` (`ai_translate.settings`), `entity_type.manager`,
`plugin.manager.layout_builder.section_storage`, `ai_translate.text_extractor`, `uuid`, the
`block_content` storage, and a `ai_translate_lb_asymmetric` logger channel.

Text extraction is inherited from `LbFieldExtractor`. The module's own work is in **`setValue()`**,
which AI Translate calls to write the translation back:

1. Reads the **untranslated** source entity (`$entity->getUntranslated()`) and its
   `layout_section` field value; target langcode = `$entity->language()->getId()`.
2. For each section it `clone`s the `Section` and walks its components. For each component it loads
   the referenced block by `block_revision_id` (`loadRevision`) or `block_id` (`load`).
3. Each found block is duplicated (`createDuplicate()`), given a **new UUID** and the target
   `langcode`. Matching entries in the `$textMeta` translation array (keyed by the source block's
   UUID) are written into the clone with `->set($field, $translationData, $delta)` when the clone
   `hasField($field)`.
4. The clone is `save()`d (failures are logged, not thrown); the component configuration is updated
   to point at the clone's `block_id`/`block_revision_id`; the component gets a fresh UUID.
5. The rebuilt `$duplicatedSections` are written to the field and the entity is `save()`d.

Net effect: the translation gets its **own** set of blocks and its **own** layout, independent of
the source language (asymmetric).

## Plugin 2 — `text_lb_asymmetric` (`TextFieldLbAsymmetricExtractor`)

`src/Plugin/FieldTextExtractor/TextFieldLbAsymmetricExtractor.php`, `#[FieldTextExtractor(id:
"text_lb_asymmetric", label: 'Text', field_types: ['title','text','text_with_summary','text_long',
'string','string_long'])]`, extends `TextFieldExtractor`. It only overrides **`shouldExtract()`**:
returns TRUE when the entity is a `BlockContent` **or** the field definition is translatable —
ensuring text fields inside layout blocks are always offered for extraction.

## Notes

- Translated values come from AI Translate (via the configured AI provider) and are written through
  the standard field `->set()` API; text fields carry their own text format and are rendered
  through normal field rendering.
- All work happens inside AI Translate's translate batch, which is gated by AI Translate's
  `administer ai translate` permission. This module adds no route or endpoint of its own.
- Obsolete for **AI 1.2.x+**, which bundles the same capability.
