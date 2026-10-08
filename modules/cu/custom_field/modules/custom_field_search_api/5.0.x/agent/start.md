<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API: Custom Field — agent index

A one-subscriber glue module. It teaches Search API to index a Custom Field's `string_long`
column as full-text by mapping the property data type `custom_field_string_long` → `text`.
No config, no field, no widget, no admin UI — enabling it is the whole setup.

- **The event, the mapping, and how to index a Custom Field column on an index** →
  [api/field-type-mapping.md](api/field-type-mapping.md)

Key facts:
- Service `custom_field_search_api.search_api_event_subscriber` subscribes to
  `SearchApiEvents::MAPPING_FIELD_TYPES` (method `onMappingFieldTypes`) and adds
  `$mapping['custom_field_string_long'] = 'text'`.
- Read the live mapping:
  `\Drupal::service('search_api.data_type_helper')->getFieldTypeMapping()['custom_field_string_long']`
  → `text` when this module is enabled.
- A Custom Field column is indexed via its `property_path` `<field_name>:<column>` in a
  `search_api.index.<id>` config's `field_settings`.
