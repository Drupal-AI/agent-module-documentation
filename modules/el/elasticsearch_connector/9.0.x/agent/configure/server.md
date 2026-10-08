<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure a Search API server on the `elasticsearch` backend

The module has **no configure route of its own** (`configure: null`). Everything happens on
Search API's normal server config entity, `search_api.server.<id>`, by setting
`backend: elasticsearch` and filling in `backend_config`.

## External requirement (read this first)

This backend cannot connect, index, or query without:

- A reachable **Elasticsearch 8/9** cluster (self-hosted or Elastic Cloud).
- The Composer libraries `elasticsearch/elasticsearch:^9.0.0` and `makinacorpus/php-lucene:^1.1`
  (already required by the module's own `composer.json`).
- The `drupal/search_api` module (declared dependency).

Nothing in this doc, and none of this module's eval cases, ever contacts a live cluster — they
only create/read the `search_api.server` **config entity**, which is fully valid and inspectable
without Elasticsearch actually being up.

## The config shape

```yaml
# search_api.server.<id>
id: my_server
name: 'My server'
description: ''
backend: elasticsearch
backend_config:
  connector: standard            # one of: standard, basicauth, elastic_cloud_id, elastic_cloud_endpoint
  connector_config:               # keys depend on `connector`, see below
    url: 'http://localhost:9200'
    enable_debug_logging: false
  advanced:
    fuzziness: auto               # 'auto', '0' (disabled), or '1'..'5'
    prefix: ''                    # index name prefix (share one cluster across envs)
    suffix: ''                    # index name suffix
    synonyms: []                  # list of Solr-format synonym lines, e.g. 'test => check'
langcode: en
status: true
dependencies:
  module:
    - elasticsearch_connector
```

Schema: `plugin.plugin_configuration.search_api_backend.elasticsearch` (in
`config/schema/elasticsearch_connector.backend.schema.yml`) defines `connector`,
`connector_config` (validated per-connector via
`plugin.plugin_configuration.elasticsearch_connector.[%parent.connector]`), and `advanced`.

## `connector_config` per connector

| `connector` id | Label | Config keys |
|---|---|---|
| `standard` | Standard | `url`, `enable_debug_logging` |
| `basicauth` | HTTP Basic Authentication | `url`, `username`, `password`, `enable_debug_logging` (extends `standard`) |
| `elastic_cloud_id` | Elastic Cloud ID | `elastic_cloud_id`, `api_key_id`, `enable_debug_logging` |
| `elastic_cloud_endpoint` | Elastic Cloud Endpoint | `url`, `api_key_id`, `enable_debug_logging` |

`api_key_id` is a **Key module** key name (`drupal/key` is only a `suggest`, not a hard
dependency — without it the Elastic Cloud connectors' forms show an error and no client can be
built, but the config keys themselves still validate).

## Via the UI

1. `/admin/config/search/search-api/add-server` (Search API's own add-server form).
2. Pick backend **ElasticSearch**, choose a connector, fill in its fields, set the advanced
   options, save.

## Via config (scriptable, no live ES needed to create the entity)

Write the config entity directly — this validates and saves cleanly even with no cluster
reachable, because Search API's `Server::create()->save()` does not connect to the backend on
save; only actually **enabling/using** the server for indexing talks to Elasticsearch:

```php
\Drupal::configFactory()->getEditable('search_api.server.my_server')->setData([
  'langcode' => 'en',
  'status' => TRUE,
  'dependencies' => ['module' => ['elasticsearch_connector']],
  'id' => 'my_server',
  'name' => 'My server',
  'description' => '',
  'backend' => 'elasticsearch',
  'backend_config' => [
    'connector' => 'standard',
    'connector_config' => [
      'url' => 'http://localhost:9200',
      'enable_debug_logging' => FALSE,
    ],
    'advanced' => [
      'fuzziness' => 'auto',
      'prefix' => '',
      'suffix' => '',
      'synonyms' => [],
    ],
  ],
])->save();
```

## Read it back

```bash
drush config:get search_api.server.my_server
# or a single key:
drush config:get search_api.server.my_server backend_config.connector
```

Or in PHP: `\Drupal::config('search_api.server.my_server')->get('backend_config.connector')`
(and `.connector_config.url`, `.connector_config.username`, `.advanced.fuzziness`, etc.).

## Processors (optional, per-index)

Two Search API processor plugins ship with the module and are enabled on a
`search_api.index.<id>` entity's `processor_settings`, not on the server:

- `elasticsearch_type_boost` — query-time boost by datasource/bundle
  (`plugin.plugin_configuration.search_api_processor.elasticsearch_type_boost`: `boosts` map of
  `datasource_boost` / `bundle_boosts`).
- `elasticsearch_highlight` — excerpts via Elasticsearch's native highlighter
  (`plugin.plugin_configuration.search_api_processor.elasticsearch_highlight`: `fields`, `type`
  [`unified`/`plain`/`fvh`], `fragment_size`, `number_of_fragments`, `boundary_scanner`,
  `pre_tag`/`snippet_joiner`, etc.).
