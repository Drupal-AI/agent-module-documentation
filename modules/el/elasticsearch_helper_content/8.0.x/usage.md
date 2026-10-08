<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Elasticsearch Helper Content lets site builders define Elasticsearch indices for any Drupal content entity type through the admin UI, choosing which fields are indexed and how each is normalized, without writing an ElasticsearchIndex plugin by hand.
---
The module adds an `elasticsearch_content_index` config entity plus add/edit/delete forms under `/admin/config/search/elasticsearch_helper/index/...`, all gated by the `administer site configuration` permission (routes in `elasticsearch_helper_content.routing.yml`; the "Add content index" action link appears on the index management list). Each index is realised as a derived `ContentIndex` ElasticsearchIndex plugin (via `ContentIndexDeriver`). Indexing is driven by two plugin managers — `plugin.manager.elasticsearch_entity_normalizer` and `plugin.manager.elasticsearch_field_normalizer` — with a large library of field normalizers (text, keyword, date, boolean, integer, entity reference id/label, link uri/label, rendered entity/field, file/image path, address, email, etc.). An `UnpublishedContentEventSubscriber` handles how unpublished content is treated during indexing, and a custom param converter resolves the content-index entity on admin routes.

Operationally: enable the module (with `elasticsearch_helper` and `elasticsearch_helper_index_management`), create a content index, pick the entity type/bundle and fields with their normalizers, save, then run the index setup from the index-management UI. All configuration is admin-permission-gated; the module provides plugin types you can extend with custom entity/field normalizers.
---
- Define an Elasticsearch index for a content entity type via the UI.
- Choose which entity fields get indexed.
- Assign a normalizer plugin per field (text, keyword, date, boolean…).
- Index entity-reference targets by id or label.
- Index rendered entity or rendered single-field output.
- Index file/image paths and link uri/label values.
- Support multilingual content indexing.
- Control handling of unpublished content during indexing.
- Add a custom field normalizer plugin for a bespoke field type.
- Add a custom entity normalizer plugin.
- Manage indices (add/edit/delete) from the admin config UI.
- Trigger index setup/creation from the index-management list.
- Map address and email fields into structured ES fields.
- Reuse the derived ContentIndex plugin from elasticsearch_helper.
- Restrict index configuration to `administer site configuration`.
- Build a search backend feeding a decoupled or Search API front end.