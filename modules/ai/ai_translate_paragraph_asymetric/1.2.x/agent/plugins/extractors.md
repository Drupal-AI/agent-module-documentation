<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FieldTextExtractor plugins for asymmetric paragraphs

The module is a thin extension of **AI Translate** (`ai_translate`, a Drupal AI submodule). It adds
two `FieldTextExtractor` plugins and nothing else — no routing, `*.services.yml`,
`*.permissions.yml`, `*.install`, config or hooks exist in the project.

## Install & enable

```bash
composer require drupal/ai_translate_paragraph_asymetric
drush en ai_translate_paragraph_asymetric -y
```

Requires the **AI Translate** submodule of Drupal AI, core **content_translation**, and **Paragraphs
Asymmetric Translation Widgets** (`paragraphs_asymmetric_translation_widgets`).

Post-install (from README):

1. Make the paragraph-reference field **translatable**; keep the **paragraph fields themselves
   non-translatable**.
2. In AI Translate config (`/admin/config/ai/ai_translate`) enable **"Paragraph"** for
   entity-reference translation.
3. Translate as usual via AI Translate's one-click action.

## Plugin 1 — `paragraph_asymmetric` (`ParagraphAsymetricExtractor`)

`src/Plugin/FieldTextExtractor/ParagraphAsymetricExtractor.php`, `#[FieldTextExtractor(id:
"paragraph_asymmetric", field_types: ['entity_reference','entity_reference_revisions'])]`, extends
`Drupal\ai_translate\Plugin\FieldTextExtractor\ReferenceFieldExtractor` and implements
`ConfigurableFieldTextExtractorInterface`.

`fieldSettingsForm()` returns `[]` (no per-field settings). The core work is **`setValue()`**, which
AI Translate calls to write the translation back:

1. Reads referenced entities from the **untranslated** source (`$entity->getUntranslated()`).
2. If the reference is empty, not paragraphs, or the field is not translatable, it delegates to
   `parent::setValue()` (standard reference handling) and returns.
3. Otherwise, target langcode = `$entity->language()->getId()`. For each referenced paragraph it
   calls **`createDuplicateWithSingleLanguage()`** — `createDuplicate()`, then recursively duplicates
   any `entity_reference_revisions` sub-fields that target `paragraph`, sets the duplicate's
   `langcode`, and `removeTranslation()`s all other languages so the copy stands alone.
4. It walks the duplicate's fields: `entity_reference_revisions` sub-fields with provided
   `$textMeta` are handed to **`setNestedParagraphs()`** (recursion); plain `entity_reference`
   fields are skipped; all other fields are `->set()` with the translated values from `$textMeta`
   when present.
5. `setNestedParagraphs()` duplicates each nested paragraph the same way, strips `field_name` /
   `field_type` keys from the incoming values, and `->set()`s them.
6. The rebuilt `['entity' => $duplicate]` items are written with `$entity->set($fieldName, ...)`.

Net effect: the translation references its **own** duplicated paragraph tree, independent of the
source (asymmetric). Note `setValue()` here does not itself call `$entity->save()` — persistence is
handled by AI Translate's calling flow.

## Plugin 2 — `text_paragraph_asymmetric` (`TextFieldParagraphAsymetricExtractor`)

`src/Plugin/FieldTextExtractor/TextFieldParagraphAsymetricExtractor.php`, `#[FieldTextExtractor(id:
"text_paragraph_asymmetric", label: 'Text', field_types: ['title','text','text_with_summary',
'text_long','string','string_long'])]`, extends `TextFieldExtractor`. Overrides **`shouldExtract()`**
to return TRUE when the entity is a `ParagraphInterface` **or** the field is translatable — so text
fields inside paragraphs are always offered for extraction.

## Notes

- Translated values come from AI Translate (via the configured AI provider) and are written through
  the standard field `->set()` API; text fields carry their own text format and are rendered through
  normal field rendering.
- All work happens inside AI Translate's translate batch, gated by AI Translate's
  `administer ai translate` permission. This module adds no route or endpoint of its own.
