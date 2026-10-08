<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API: Custom Field lets a Custom Field's long-text column be indexed as full-text by teaching Search API how to map the Custom Field `string_long` property data type to Search API's `text` type.

---

This is a tiny glue submodule: a single event subscriber (`SearchApiEventSubscriber`) that listens to Search API's `SearchApiEvents::MAPPING_FIELD_TYPES` event (`onMappingFieldTypes`). Custom Field exposes each column of a `custom` field as a typed property; a `string_long` column has the Search API property data type `custom_field_string_long`, which core Search API does not know how to index. The subscriber adds one entry to Search API's field-type mapping — `custom_field_string_long` → `text` — so that when you add a Custom Field's long-text column as a field on a Search API index, Search API offers/assigns the full-text `text` type instead of treating it as unindexable. Any Custom Field column can be indexed via its `property_path` (`<field_name>:<column>`); this submodule specifically fixes the `string_long` case so the column becomes a proper full-text field. It provides no config, no field, no widget, and no admin UI of its own — enabling it is the entire setup.

---

- Index the long-text (`string_long`) column of a Custom Field as full-text in Search API.
- Make a Custom Field "description" column searchable in a site search index.
- Add a Custom Field body column to a Solr or database Search API index as a `text` field.
- Ensure a Custom Field long-text column is offered the `text` type in the Search API field UI.
- Build faceted/keyword search over content stored in Custom Field columns.
- Include a Custom Field's rich long-text column in a search index's fulltext fields.
- Combine several Custom Field columns (string + string_long) on one index, each with the right type.
- Index a Paragraphs-replacement Custom Field's text column without custom code.
- Support autocomplete/spellcheck over a Custom Field long-text column via Search API add-ons.
- Keep Search API field-type detection correct after migrating fields into a Custom Field.
- Index Custom Field text columns alongside normal node fields in the same index.
- Provide fulltext relevance ranking on Custom Field long-text content.
- Enable database (search_api_db) or Solr indexing of Custom Field long-text columns.
- Expose Custom Field long-text columns to Search API Views-based search pages.
- Let editors' Custom Field prose be found by site search.
- Index multiple bundles' Custom Field long-text columns through one index.
- Avoid a Custom Field long-text column being silently skipped as an unsupported property.
- Map the Custom Field `string_long` property type to `text` globally for all indexes.
- Underpin a decoupled search experience that queries Custom Field text content.
