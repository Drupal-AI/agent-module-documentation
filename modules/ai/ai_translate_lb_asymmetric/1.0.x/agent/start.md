<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Translate Layout builder Asymmetric (ai_translate_lb_asymmetric) — agent index

Extends the **AI Translate** flow to handle **asymmetric Layout Builder** translations (per-language
layouts). Pure plugin provider: **no routes, forms, services, permissions, hooks or config** of its
own. Version **1.0.0**. Core `^10.3 || ^11`. License GPL-2.0-or-later. Package `AI`.

Dependencies: `ai:ai_translate`, `drupal:content_translation`, `drupal:layout_builder_at`.
Composer requires `drupal/ai:^1.0@beta`.

> Project note: **obsolete for AI 1.2.x+** — the capability was merged into the main AI package.

## What it provides

Two `FieldTextExtractor` plugins (attribute `\Drupal\ai_translate\Attribute\FieldTextExtractor`),
auto-discovered and consumed by AI Translate:

- **`layout_builder_asymmetric`** — `src/Plugin/FieldTextExtractor/LbAsymmetricExtractor.php`,
  extends `ai_translate`'s `LbFieldExtractor`. Targets `layout_section` fields. Its `setValue()`
  clones each component's block_content into the target language and saves a translated,
  independent layout.
- **`text_lb_asymmetric`** (label "Text") —
  `src/Plugin/FieldTextExtractor/TextFieldLbAsymmetricExtractor.php`, extends `TextFieldExtractor`.
  Targets `title`, `text`, `text_with_summary`, `text_long`, `string`, `string_long`. Overrides
  `shouldExtract()` to return TRUE for `BlockContent` entities or translatable fields.

Details, the clone/save mechanism, and setup → [plugins/extractors.md](plugins/extractors.md)

## Operate it

1. Enable AI Translate (Drupal AI) + Layout Builder Asymmetric Translation, then this module.
2. Make the layout (block-reference) field translatable; keep the block fields themselves
   non-translatable.
3. Use AI Translate's normal one-click translate action; the plugins do the rest. Translation is
   gated by AI Translate's own `administer ai translate` permission and sends content to the
   configured AI provider.
