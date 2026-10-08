<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field-type mapping & indexing a Custom Field column

## The whole module

`SearchApiEventSubscriber` (service
`custom_field_search_api.search_api_event_subscriber`) subscribes to one event:

```php
public static function getSubscribedEvents(): array {
  return [SearchApiEvents::MAPPING_FIELD_TYPES => 'onMappingFieldTypes'];
}
public function onMappingFieldTypes(MappingFieldTypesEvent $event): void {
  $mapping = &$event->getFieldTypeMapping();
  $mapping['custom_field_string_long'] = 'text';
}
```

Search API builds its property-datatype → index-fieldtype mapping in
`DataTypeHelper::getFieldTypeMapping()`, dispatching `MAPPING_FIELD_TYPES`. This subscriber
adds the single entry **`custom_field_string_long` → `text`**. Without it, a Custom Field
`string_long` column property (Search API data type `custom_field_string_long`) has no mapping
and cannot be indexed as full-text.

## Verify the mapping live

```php
$m = \Drupal::service('search_api.data_type_helper')->getFieldTypeMapping();
$m['custom_field_string_long'];   // 'text' when this module is enabled
```

## Index a Custom Field column

Each column of a `custom` field is an indexable property at `property_path`
`<field_name>:<column>` on the `entity:<type>` datasource. A field entry in
`search_api.index.<id>` config `field_settings`:

```yaml
field_settings:
  cfsapi_body:
    label: 'Body'
    datasource_id: 'entity:node'
    property_path: 'field_desc:body'    # <custom field>:<string_long column>
    type: text                          # available because of this module
```

- `type: text` for a `string_long` column is exactly what this submodule enables.
- Other column types map through Search API's own rules (a `string` column → `string`, an
  `integer` column → `integer`, etc.); this module only fixes the `string_long`/`text` case.
- Add the field in the Search API index UI (*Fields* tab → *Add fields* → expand the Custom
  Field → pick the column), or set `field_settings` in the index config as above.

No admin page belongs to this module — everything is Search API's own index configuration.
