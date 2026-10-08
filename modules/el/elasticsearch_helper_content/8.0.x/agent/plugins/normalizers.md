<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Normalizer plugin types

Two annotation-based plugin types drive how content is shaped for Elasticsearch:

- **Entity normalizers** — `@ElasticsearchEntityNormalizer`, managed by `plugin.manager.elasticsearch_entity_normalizer`, base `EntityNormalizerBase`. Decide the overall document for an entity.
- **Field normalizers** — `@ElasticsearchFieldNormalizer`, managed by `plugin.manager.elasticsearch_field_normalizer`, base `FieldNormalizerBase`. Shape a single field's value.

Shipped field normalizers include: Text, Keyword, Boolean, Integer, FloatNormalizer, Date, Email, EntityReference / EntityReferenceId / EntityReferenceLabel, Link / LinkUri / LinkLabel, Path / FilePath / ImagePath, RenderedEntity / RenderedField, AddressPlain, EmptyCustomField.

## Extending
Add a plugin class under `src/Plugin/ElasticsearchNormalizer/Field/` (or `.../Entity/`) with the matching annotation to introduce a custom normalizer; it becomes selectable when configuring an `elasticsearch_content_index`.

## Config entity
`elasticsearch_content_index` (add/edit/delete forms are admin-gated). Each index is exposed to `elasticsearch_helper` as a derived `ContentIndex` plugin; run "Setup" from the index-management list to create it in Elasticsearch.
