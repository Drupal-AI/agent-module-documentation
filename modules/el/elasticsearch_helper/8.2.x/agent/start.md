<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Elasticsearch Helper (elasticsearch_helper) — agent index

Framework for indexing Drupal content into **Elasticsearch directly** (via the official
`elasticsearch/elasticsearch` ^8.0 PHP client), *not* through Search API. It defines an
`ElasticsearchIndex` plugin type; on its own the module indexes nothing until you add a plugin.
Entity CRUD auto-indexes/deletes documents; index create/drop/reindex/truncate run via drush or
a queue. Depends on core `serialization`. Core `^10 || ^11`.

Configure at route `elasticsearch_helper.elasticsearch_helper_settings_form`
(`/admin/config/search/elasticsearch_helper`). Provides one permission, five drush commands,
two plugin types, config schema, and a set of events.

- **Connection settings (hosts, scheme, auth method, SSL, defer-indexing), config object + schema, set via drush/PHP** → [configure/settings.md](configure/settings.md)
- **Define an index: the `ElasticsearchIndex` plugin type, annotation keys, mapping/field/settings definitions, normalizers** → [plugins/elasticsearch-index.md](plugins/elasticsearch-index.md)
- **Add an authentication method: the `ElasticsearchAuth` plugin type (`basic_auth`, `api_key`)** → [plugins/elasticsearch-auth.md](plugins/elasticsearch-auth.md)
- **Services + runtime API: the client, index manager, per-plugin operation methods, language analyzer** → [api/services.md](api/services.md)
- **Drush commands (list/setup/drop/reindex/truncate) + queue run** → [drush/commands.md](drush/commands.md)
- **Events + subscribers (operation lifecycle, operation permission, reindex, data-type build)** → [events/events.md](events/events.md)
- **Hooks the module implements/invokes + `settings.php` flags** → [hooks/hooks.md](hooks/hooks.md)
- **The one permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config object `elasticsearch_helper.settings`; keys: `scheme` (default `http`), `hosts` (sequence of `{host, port}`), `authentication.method` + `authentication.configuration.<method>`, `ssl.certificate`, `ssl.skip_verification` (default `false`), `defer_indexing` (default `false`).
- Route `elasticsearch_helper.elasticsearch_helper_settings_form` → `/admin/config/search/elasticsearch_helper`. Permission: `configure elasticsearch helper`.
- Services: `elasticsearch_helper.elasticsearch_client` (an `Elastic\Elasticsearch\Client`), `elasticsearch_helper.elasticsearch_client_builder`, `plugin.manager.elasticsearch_index.processor`, `plugin.manager.elasticsearch_auth`, `elasticsearch_helper.data_type_repository`, `elasticsearch_helper.queue_factory`.
- Plugin type `ElasticsearchIndex`: dir `Plugin/ElasticsearchIndex`, annotation `Drupal\elasticsearch_helper\Annotation\ElasticsearchIndex`, interface `ElasticsearchIndexInterface`, base `ElasticsearchIndexBase`, alter `elasticsearch_helper_elasticsearch_index_info`.
- Plugin type `ElasticsearchAuth`: dir `Plugin/ElasticsearchAuth`, base `ElasticsearchAuthPluginBase`, built-in ids `basic_auth` / `api_key`, alter `elasticsearch_helper_elasticsearch_auth_info`.
- Queue worker `elasticsearch_helper_indexing` (cron time 30s) processes deferred/reindex items.
- Drush commands: `elasticsearch:helper:list` (eshl), `:setup` (eshs), `:drop` (eshd), `:reindex` (eshr), `:truncate` (esht).
- Events: `ElasticsearchEvents::OPERATION|OPERATION_REQUEST|OPERATION_REQUEST_RESULT|OPERATION_ERROR`, `ElasticsearchHelperEvents::REINDEX`, `DataTypeEvents::BUILD`.
- Hooks invoked for others: `hook_elasticsearch_helper_client_builder_alter`, `hook_elasticsearch_helper_reindex_entity_query_alter`. `settings.php` flag `elasticsearch_helper.silent_delete`.
- Composer: `elasticsearch/elasticsearch: ^8.0`. Bundled example module: `elasticsearch_helper_example`.
