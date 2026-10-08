<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Translate Layout builder Asymmetric adds one-click AI translation for asymmetric Layout Builder content by plugging two field-text-extractor plugins into the AI Translate module.

---

AI Translate Layout builder Asymmetric extends the **AI Translate** submodule of Drupal AI so its
one-click translation flow can handle **asymmetric Layout Builder** translations — the setup (via
Layout Builder Asymmetric Translation, `layout_builder_at`) where each language keeps its own,
independently structured layout. It ships no routes, forms, services or config of its own; it only
provides two `FieldTextExtractor` plugins that AI Translate discovers automatically. The
`layout_builder_asymmetric` plugin duplicates the source layout's `layout_section` field, clones the
inline/reusable block content referenced by each Layout Builder component into the target language
(new UUIDs), applies AI Translate's translated field values to the clones, and saves them so the
translation gets its own layout. The `text_lb_asymmetric` plugin makes plain text/string fields
inside those blocks eligible for extraction. The project notes it is **obsolete for AI 1.2.x and
later**, where the capability was merged into the main AI package. Content is sent to whatever AI
provider AI Translate is configured to use.

Use it to:

- Translate Layout Builder pages where languages have different layouts (asymmetric translation).
- Add AI translation to a site already using `layout_builder_at`.
- Reuse AI Translate's existing one-click translate action for Layout Builder content.
- Clone per-component block content into a target-language copy with a fresh UUID.
- Give each translation its own independently editable layout and blocks.
- Translate inline (non-reusable) blocks placed in a layout.
- Translate reusable block content referenced by a component (by block or revision id).
- Extract title, text, text_with_summary, text_long, string and string_long fields from blocks.
- Keep the source layout untouched while building the translated layout from a clone.
- Translate content on entity types with a translatable `layout_section` field.
- Let editors avoid rebuilding the layout by hand in each language.
- Batch-translate a Layout Builder node in a single action via AI Translate.
- Feed block field text through AI Translate's provider/prompt configuration.
- Support content_translation-based multilingual Layout Builder sites.
- Migrate a symmetric AI-translation workflow toward asymmetric layouts.
- Bridge AI Translate and Layout Builder Asymmetric Translation without custom code.
- Serve as a reference for writing custom `FieldTextExtractor` plugins for AI Translate.
- Provide a drop-in until upgrading to AI 1.2.x where the feature is built in.
