<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Translate Paragraph Asymetric adds one-click AI translation for asymmetric paragraphs by plugging field-text-extractor plugins into the AI Translate module.

---

AI Translate Paragraph Asymetric extends the **AI Translate** submodule of Drupal AI so its one-click
translation flow can handle **asymmetric paragraph** translations — the setup (via Paragraphs
Asymmetric Translation Widgets) where a translation can reference a different set/structure of
paragraphs than the source. The module ships no routes, forms, services or config of its own; it only
provides two `FieldTextExtractor` plugins that AI Translate discovers automatically. The
`paragraph_asymmetric` plugin duplicates the source's referenced paragraphs into the target language
(recursively, including nested paragraphs), applies AI Translate's translated field values to the
duplicates, and writes them back so the translation owns its paragraphs independently. The
`text_paragraph_asymmetric` plugin makes plain text/string fields inside those paragraphs eligible for
extraction. The machine name is intentionally spelled "asymetric". Content is sent to whatever AI
provider AI Translate is configured to use.

Use it to:

- Translate paragraph-based content where languages have different paragraph structures.
- Add AI translation to a site using Paragraphs Asymmetric Translation Widgets.
- Reuse AI Translate's one-click translate action for `entity_reference`/`entity_reference_revisions`
  paragraph fields.
- Duplicate referenced paragraphs into a target-language copy per translation.
- Recursively duplicate and translate nested paragraphs.
- Give each translation its own independently editable paragraphs.
- Extract title, text, text_with_summary, text_long, string and string_long fields from paragraphs.
- Keep the source paragraphs untouched while building the translated set from duplicates.
- Fall back to AI Translate's default reference handling for non-paragraph references.
- Enable the "Paragraph" entity-reference option in AI Translate's config to drive it.
- Batch-translate a paragraph-heavy node in a single action via AI Translate.
- Support content_translation-based multilingual paragraph sites.
- Feed paragraph field text through AI Translate's provider/prompt configuration.
- Strip source translations from duplicates so each language stands alone.
- Bridge AI Translate and Paragraphs Asymmetric Translation Widgets without custom code.
- Serve as a reference for writing custom `FieldTextExtractor` plugins for AI Translate.
