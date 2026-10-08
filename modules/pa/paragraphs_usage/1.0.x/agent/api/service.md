# ParagraphsUsageService API

Service id: `paragraphs_usage.paragraphs_usage_service`
Class: `\Drupal\paragraphs_usage\Service\ParagraphsUsageService`
Constructor deps: `entity_type.manager`, `entity_type.bundle.info`, `entity_field.manager`.

## Usage
```php
$service = \Drupal::service('paragraphs_usage.paragraphs_usage_service');
$type = \Drupal\paragraphs\Entity\ParagraphsType::load('my_paragraph_type');
$service->setParagraphType($type);      // required; triggers the scan
$usages = $service->getUsedParagraphs(); // array of usage records
```

## Return shape
`getUsedParagraphs()` returns a list of associative arrays:
```php
[
  'entity_type'        => 'node',            // host content-entity type id
  'bundle'             => 'article',         // host bundle id
  'bundle_entity_type' => 'node_type',       // bundle config entity type (or null)
  'entity_type_label'  => 'Article',         // human label of the bundle/entity type
  'field' => [
    'label' => 'Body paragraphs',            // field label
    'name'  => 'field_paragraphs',           // field machine name
  ],
]
```

## Notes
- The scan covers **all** `ContentEntityTypeInterface` types and their bundles, not just nodes.
- Only `entity_reference_revisions` fields are inspected (the field type Paragraphs uses).
- Matching honours `handler_settings.target_bundles` and the `negate` (exclude) flag, so a
  field that targets "any paragraph type" or "all except X" is reported correctly.
- The service is stateful: call `setParagraphType()` again to re-scan for a different type.
