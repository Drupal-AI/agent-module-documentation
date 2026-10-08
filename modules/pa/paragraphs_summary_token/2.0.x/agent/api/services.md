# Services / API

Two public services build the summary and image from a Paragraphs field. Call them directly when
you need the value in PHP instead of via a token.

## `paragraphs_summary_token.text_summary_builder`

Class `Drupal\paragraphs_summary_token\Service\TextSummaryBuilder` (implements
`TextSummaryBuilderInterface`).

```php
public function build(
  EntityReferenceRevisionsFieldItemList $paragraphs_field,
  ?int $trim = 300,
  ?string $format = NULL
): string;
```

- Returns `text_summary(strip_tags(trim($raw)), $format, $trim)` — a plain-text summary.
- `$raw` = value of the **first non-empty `text_long` field** found while iterating the referenced
  paragraphs, in this order per paragraph:
  1. any `text_long` field on the paragraph (sorted by field name);
  2. else recurse into any `entity_reference_revisions` field targeting `paragraph`;
  3. else recurse into any `entity_reference` field targeting `paragraphs_library_item`
     (into its `paragraphs` field).
- First match wins (`break 2`). Uses the current language's translation of each paragraph.

Example:

```php
$summary = \Drupal::service('paragraphs_summary_token.text_summary_builder')
  ->build($node->get('field_paragraphs'), 200);
```

> `paragraphs_summary_token.summary_builder` (class `SummaryBuilder`) is a **deprecated** empty
> subclass kept for BC — use `text_summary_builder`.

## `paragraphs_summary_token.image_builder`

Class `Drupal\paragraphs_summary_token\Service\ImageBuilder` (implements `ImageBuilderInterface`).

```php
public function build(
  EntityReferenceRevisionsFieldItemList $paragraphs_field,
  ?ImageStyleInterface $image_style = NULL,
  string $property_name = 'url'   // url|uri|width|height|mimetype|filesize
): string;
```

- Finds the first `image` field, or `media` entity-reference whose source plugin is `image`, across
  the paragraph tree (same recursion + language rules as above). Media files are validated with the
  `FileIsImage` constraint before use.
- Returns the requested property (see [tokens.md](tokens.md) for the property table). Returns `''`
  when no image is found.

Example:

```php
$style = \Drupal\image\Entity\ImageStyle::load('large');
$url = \Drupal::service('paragraphs_summary_token.image_builder')
  ->build($node->get('field_paragraphs'), $style, 'url');
```

Both services are constructed with `entity_type.manager` + `language_manager` (the image builder
also takes stream-wrapper manager, file URL generator and file validator) and use the shared
`ParagraphsSummaryTokenTrait` to look up fields by entity/field type from `field_storage_config`.
