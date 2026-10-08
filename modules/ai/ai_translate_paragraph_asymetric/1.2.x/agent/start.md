<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Translate Paragraph Asymetric (ai_translate_paragraph_asymetric) — agent index

Extends the **AI Translate** flow to handle **asymmetric paragraph** translations (a translation can
own a different paragraph structure than the source). Pure plugin provider: **no routes, forms,
services, permissions, hooks or config** of its own. Version **1.2.2**. Core `^10.2 || ^11`. License
GPL-2.0-or-later. Package `AI`. (Machine name intentionally spelled "asymetric".)

Dependencies: `ai:ai_translate`, `drupal:content_translation`,
`drupal:paragraphs_asymmetric_translation_widgets`. Composer requires
`drupal/paragraphs_asymmetric_translation_widgets:^1.4` and `drupal/ai:^1.0`.

## What it provides

Two `FieldTextExtractor` plugins (attribute `\Drupal\ai_translate\Attribute\FieldTextExtractor`),
auto-discovered and consumed by AI Translate:

- **`paragraph_asymmetric`** — `src/Plugin/FieldTextExtractor/ParagraphAsymetricExtractor.php`,
  extends `ai_translate`'s `ReferenceFieldExtractor`, implements
  `ConfigurableFieldTextExtractorInterface`. Targets `entity_reference` and
  `entity_reference_revisions`. Its `setValue()` duplicates referenced paragraphs (recursively) into
  the target language and writes AI Translate's translated values into the duplicates.
- **`text_paragraph_asymmetric`** (label "Text") —
  `src/Plugin/FieldTextExtractor/TextFieldParagraphAsymetricExtractor.php`, extends
  `TextFieldExtractor`. Targets `title`, `text`, `text_with_summary`, `text_long`, `string`,
  `string_long`. Overrides `shouldExtract()` to return TRUE for `ParagraphInterface` entities or
  translatable fields.

Details, the duplicate/recurse mechanism, and setup → [plugins/extractors.md](plugins/extractors.md)

## Operate it

1. Enable AI Translate (Drupal AI) + Paragraphs Asymmetric Translation Widgets, then this module.
2. Make the paragraph-reference field translatable; keep the paragraph fields themselves
   non-translatable.
3. In AI Translate config (`/admin/config/ai/ai_translate`) enable "Paragraph" for entity-reference
   translation.
4. Use AI Translate's one-click translate action; the plugins do the rest. Translation is gated by
   AI Translate's `administer ai translate` permission and sends content to the configured AI
   provider.
