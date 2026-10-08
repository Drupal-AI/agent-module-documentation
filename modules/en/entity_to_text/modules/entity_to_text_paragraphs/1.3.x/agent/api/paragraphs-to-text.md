<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ParagraphsToText — paragraph field to plain-text array

Class `Drupal\entity_to_text_paragraphs\Extractor\ParagraphsToText`
(`modules/entity_to_text_paragraphs/src/Extractor/ParagraphsToText.php`), service id
**`entity_to_text_paragraphs.extractor.paragraphs_to_text`**. Constructor args
(`entity_to_text_paragraphs.services.yml`): `@entity_to_text.htmlpurifier`, `@renderer`,
`@entity_type.manager`.

## Method

`public function fromParagraphToText(EntityReferenceRevisionsFieldItemList $paragraph_items): array`

Steps (source):
1. Iterates the reference-revisions field item list; for each item takes `$paragraph_item->entity`.
2. Gets the paragraph's view builder via `entityTypeManager->getViewBuilder($paragraph->getEntityTypeId())`
   and calls `view($paragraph, 'full', $paragraph_item->getLangcode())` — renders in **`full`** view mode
   using the item's langcode.
3. `renderer->renderRoot($view)` → markup, then `HtmlPurifier::init()->purify(...)` (strips all HTML/CSS),
   `trim()`, and appends to the result array.
4. Returns `string[]` — one plain-text string per Paragraph, in order.

## Usage

```php
$bodies = \Drupal::service('entity_to_text_paragraphs.extractor.paragraphs_to_text')
  ->fromParagraphToText($node->field_paragraphs);
```

## Notes

- Input must be an `EntityReferenceRevisionsFieldItemList` (a Paragraphs / entity_reference_revisions
  field), not an arbitrary entity.
- Rendering uses the `full` view mode, so the display configured for that view mode determines which
  sub-fields appear in the text.
- No access checks; the caller loads/permits the host entity and its Paragraphs.
