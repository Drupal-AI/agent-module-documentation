# Rendering JSON-LD — SchemaMetatagManager

Service `schema_metatag.schema_metatag_manager` (class `SchemaMetatagManager`, wraps
`@metatag.manager`). The module renders structured data automatically — you rarely call this
directly.

## How output happens
`schema_metatag_page_attachments_alter()` (in `schema_metatag.module`) runs on every page:
```php
$mgr = \Drupal::service('schema_metatag.schema_metatag_manager');
$items = $mgr->parseJsonld($attachments['#attached']['html_head']); // group flat schema_* tags into nested arrays
if ($items) {
  $jsonld = $mgr->encodeJsonld($items);                             // json_encode with the right flags
  $attachments['#attached']['html_head'][] = [[
    '#type' => 'html_tag', '#tag' => 'script',
    '#value' => $jsonld, '#attributes' => ['type' => 'application/ld+json'],
  ], 'schema_metatag'];
}
```
- `parseJsonld($html_head)` — walks Metatag's rendered head elements, keeps `schema_*` tags,
  and rebuilds the nested `@type` / property tree.
- `encodeJsonld($items)` — serializes to a JSON-LD string.
- Helper methods on the manager also explode/serialize array values and strip empty branches.

## Related services
- `plugin.manager.schema_property_type` — manager for `@SchemaPropertyType` plugins (see
  [../plugins/schema-types.md](../plugins/schema-types.md)).
- `schema_metatag.schema_metatag_client` — cached client used by tests/tooling.
- `schema_metatag.cache` — dedicated `schema_metatag_cache` bin.

Since values are Metatag tags, set them (with tokens) under the site's Metatag configuration;
they are output as JSON-LD without further code.
