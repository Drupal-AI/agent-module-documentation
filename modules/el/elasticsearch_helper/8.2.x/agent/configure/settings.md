<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Connection settings

Form `\Drupal\elasticsearch_helper\Form\ElasticsearchHelperSettingsForm` (id
`elasticsearch_helper_settings_form`), route
`elasticsearch_helper.elasticsearch_helper_settings_form` at
`/admin/config/search/elasticsearch_helper`, gated by permission `configure elasticsearch helper`.
It edits one config object: **`elasticsearch_helper.settings`**. The form's `#after_build`
(`checkConnection()`) pings the cluster and prints its health (green/yellow/red) each time it loads.

## Config object `elasticsearch_helper.settings`

| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `scheme` | string | `http` | `http` or `https`, applied to every host. |
| `hosts` | sequence of `{host, port}` | `[{host: localhost, port: '9200'}]` | Cluster nodes. `host` is a bare hostname (no scheme — form rejects one). `port` blank → 9200. |
| `authentication.method` | string | `''` | Empty = no auth, else an `ElasticsearchAuth` plugin id (`basic_auth`, `api_key`). |
| `authentication.configuration.<method>` | mapping | `{}` | Per-method credentials (see [plugins/elasticsearch-auth.md](../plugins/elasticsearch-auth.md)). |
| `ssl.certificate` | string | `''` | Path/name of a PEM CA bundle file; passed to the client via `setCABundle()` when set. |
| `ssl.skip_verification` | boolean | `false` | When `true`, calls `setSSLVerification(FALSE)` on the client. Left `false`, TLS certificate verification stays on. |
| `defer_indexing` | boolean | `false` | When `true`, entity CRUD queues indexing (queue `elasticsearch_helper_indexing`) instead of indexing synchronously. |

Schema: `config/schema/elasticsearch_helper.schema.yml`. Auth config uses a dynamic type key
`elasticsearch_helper.authentication_configuration.[%parent.%parent.method]`, so each method
supplies its own schema mapping.

## How it becomes a client

`ElasticsearchClientBuilder::build()` (service `elasticsearch_helper.elasticsearch_client_builder`,
factory for service `elasticsearch_helper.elasticsearch_client`) reads the config through
`ElasticsearchConnectionSettings`:

- `getFormattedHosts()` builds `scheme://host:port` strings (port defaults to `9200`).
- If `authentication.method` is set, the matching auth plugin's `authenticate()` runs.
- If `ssl.certificate` is set, `setCABundle()` is called; if `ssl.skip_verification` is true,
  `setSSLVerification(FALSE)`.
- Finally `hook_elasticsearch_helper_client_builder_alter($client_builder)` lets other modules
  adjust the `Elastic\Elasticsearch\ClientBuilder` (e.g. attach a logger). See
  [hooks/hooks.md](../hooks/hooks.md).

Config values are read via the config factory (not raw data), so `$config['...']` overrides in
`settings.php` and config overrides apply.

## Set values without the UI

```php
// PHP.
$config = \Drupal::configFactory()->getEditable('elasticsearch_helper.settings');
$config
  ->set('scheme', 'https')
  ->set('hosts', [['host' => 'es.internal', 'port' => '9200']])
  ->set('authentication', [
    'method' => 'basic_auth',
    'configuration' => ['basic_auth' => ['user' => 'elastic', 'password' => 'secret']],
  ])
  ->set('ssl', ['certificate' => '/path/to/ca.pem', 'skip_verification' => false])
  ->set('defer_indexing', true)
  ->save();
```

```bash
# Drush.
drush config:set elasticsearch_helper.settings scheme https -y
drush config:set elasticsearch_helper.settings defer_indexing true -y
```

## Deferred indexing

With `defer_indexing = true`, `hook_entity_insert/update` push `{entity_type, entity_id}` onto the
`elasticsearch_helper_indexing` queue (via `ElasticsearchIndexManager::addToQueue()`); the
`IndexingQueueWorker` (cron, 30s slice) loads each entity and indexes it. Run the queue manually
with `drush queue:run elasticsearch_helper_indexing`. Deletes are never deferred.
