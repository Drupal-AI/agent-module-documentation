<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Elasticsearch Helper Content (elasticsearch_helper_content) — agent index
**UI + `elasticsearch_content_index` config entity to define Elasticsearch indices for content entities, with pluggable normalizers.**

- **Version:** 8.0.x
- **Core:** ^9 || ^10
- **Depends on:** elasticsearch_helper, elasticsearch_helper_index_management
- **Routes:** `entity.elasticsearch_content_index.{add,edit,delete}_form` under `/admin/config/search/elasticsearch_helper/index/...` — all permission `administer site configuration`.
- **Plugin managers:** `plugin.manager.elasticsearch_entity_normalizer`, `plugin.manager.elasticsearch_field_normalizer`. **Deriver:** `ContentIndexDeriver` → `ContentIndex` ElasticsearchIndex plugin. **Event subscriber:** `UnpublishedContentEventSubscriber`.

**Security:** All routes require `administer site configuration`; no anonymous or web-service endpoints. Config-entity + plugin architecture; connection to Elasticsearch is handled by the base `elasticsearch_helper` module.

See [plugins/normalizers.md](plugins/normalizers.md)