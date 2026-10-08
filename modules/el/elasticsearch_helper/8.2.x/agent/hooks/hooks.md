<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks & settings.php flags

## Hooks the module implements (behavior to know about)

- `hook_entity_insert` / `hook_entity_update` — on any entity save, either index it immediately
  (`ElasticsearchIndexManager::indexEntity()`) or, when `defer_indexing` is on, queue it. This is
  what makes content flow into ES automatically for index plugins that declare `entityType`.
- `hook_entity_delete` / `hook_entity_translation_delete` — remove the document
  (`deleteEntity()`).
- `hook_modules_installed` — auto-`setup()` indices whose provider module was just installed.
- `hook_module_preuninstall` — auto-`drop()` indices whose provider module is being uninstalled.
- `hook_requirements` — install-time: fail if the `Elastic\Elasticsearch\Client` library is
  missing; runtime: report cluster health (green/yellow/red / no nodes).
- `hook_install` sets module weight to 10 so entity hooks run late.

## Hooks it invokes for you (`elasticsearch_helper.api.php`)

- `hook_elasticsearch_helper_client_builder_alter(\Elastic\Elasticsearch\ClientBuilder $clientBuilder)`
  — last step of client construction; attach a logger, custom handler, retries, etc.

  ```php
  function my_module_elasticsearch_helper_client_builder_alter($client_builder) {
    $client_builder->setLogger(\Drupal::logger('elasticsearch'));
  }
  ```

- `hook_elasticsearch_helper_reindex_entity_query_alter(QueryInterface $query, $entity_type, $bundle = NULL)`
  — alter the entity query that selects entities for reindexing. The module's own implementation
  calls `$query->accessCheck(FALSE)` so a reindex covers all content regardless of the running
  user's access; override here to narrow it.

## Plugin-definition alter hooks

- `elasticsearch_helper_elasticsearch_index_info` — alter discovered `ElasticsearchIndex`
  definitions.
- `elasticsearch_helper_elasticsearch_auth_info` — alter discovered `ElasticsearchAuth`
  definitions.

## settings.php flags

| Setting | Effect |
|---------|--------|
| `$settings['elasticsearch_helper.silent_delete'] = TRUE;` | Suppresses the "could not delete document" log notice when an entity delete has no matching ES document. |

Connection config is read through the config factory, so `$config['elasticsearch_helper.settings']['...']`
overrides in `settings.php` apply to hosts/scheme/auth/ssl.
