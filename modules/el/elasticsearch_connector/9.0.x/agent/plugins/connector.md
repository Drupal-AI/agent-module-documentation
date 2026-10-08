<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `elasticsearch_connector` connector plugin type

The module defines its own plugin type for building the Elasticsearch PHP client — separate
from (and consumed by) the `elasticsearch` Search API **backend** plugin.

## Manager, annotation, interface

| Piece | Value |
|---|---|
| Plugin manager service | `plugin.manager.elasticsearch_connector.connector` (class `Drupal\elasticsearch_connector\Connector\ConnectorPluginManager`) |
| Annotation | `@ElasticSearchConnector` (`Drupal\elasticsearch_connector\Annotation\ElasticSearchConnector`) — fields: `id`, `label`, `description` |
| Plugin namespace | `Plugin/ElasticSearch/Connector` |
| Required interface | `Drupal\elasticsearch_connector\Connector\ElasticSearchConnectorInterface`, which extends `PluginFormInterface`, `ConfigurableInterface`, `PluginInspectionInterface` — implementors need `getLabel()`, `getDescription()`, `getClient(): Elastic\Elasticsearch\Client`, `getUrl()`, plus the plugin-form methods |

A connector plugin's job is narrow: turn its own configuration into a built
`Elastic\Elasticsearch\Client` (via `Elastic\Elasticsearch\ClientBuilder`). The `elasticsearch`
Search API backend asks `ConnectorPluginManager::createInstance($connector_id, $connector_config)`
for one, then calls `getClient()`.

## Shipped connectors

| Plugin id | Class | Label | Config keys (`connector_config`) |
|---|---|---|---|
| `standard` | `Plugin\ElasticSearch\Connector\StandardConnector` | Standard | `url`, `enable_debug_logging` |
| `basicauth` | `Plugin\ElasticSearch\Connector\BasicAuthConnector` (extends `StandardConnector`) | HTTP Basic Authentication | `url`, `username`, `password`, `enable_debug_logging` |
| `elastic_cloud_id` | `Plugin\ElasticSearch\Connector\ElasticCloudIdConnector` | Elastic Cloud ID | `elastic_cloud_id`, `api_key_id`, `enable_debug_logging` |
| `elastic_cloud_endpoint` | `Plugin\ElasticSearch\Connector\ElasticCloudEndpointConnector` | Elastic Cloud Endpoint | `url`, `api_key_id`, `enable_debug_logging` |

Notes:
- `basicauth` builds its client with `setBasicAuthentication($username, $password)`.
- Both Elastic Cloud connectors resolve `api_key_id` through the **Key module's**
  `key.repository` service, *only if that service is present* — they intentionally avoid a hard
  type-hint on `KeyRepositoryInterface` so Key stays an optional dependency (it's a `suggest`,
  not a `dependencies` entry). Without Key installed, their config form shows an error and no
  usable client can be built, but the config keys themselves are still valid/storable.
- Config for each is validated by its own schema:
  `plugin.plugin_configuration.elasticsearch_connector.{standard,basicauth,elastic_cloud_id,elastic_cloud_endpoint}`
  (`config/schema/elasticsearch_connector.connector.*.schema.yml`); `basicauth`'s schema `type`
  is literally `plugin.plugin_configuration.elasticsearch_connector.standard` plus its own two
  extra keys, mirroring the class inheritance.
- All four support `enable_debug_logging` (routes Elasticsearch HTTP traffic to the
  `logger.channel.elasticsearch_connector_client` channel) — noisy and may log PII, intended for
  temporary troubleshooting only.

## Implementing a new connector

1. Create `src/Plugin/ElasticSearch/Connector/MyConnector.php` in your module, implementing
   `ElasticSearchConnectorInterface` (extend `Drupal\Core\Plugin\PluginBase`, implement
   `ContainerFactoryPluginInterface` if you need injected services like `http_client`).
2. Annotate it:
   ```php
   /**
    * @ElasticSearchConnector(
    *   id = "my_connector",
    *   label = @Translation("My Connector"),
    *   description = @Translation("Connects using my custom scheme.")
    * )
    */
   ```
3. Implement `defaultConfiguration()`, `buildConfigurationForm()`/`validateConfigurationForm()`/
   `submitConfigurationForm()` (from `PluginFormInterface`), `getClient()` (build and return an
   `Elastic\Elasticsearch\Client` via `ClientBuilder`), `getUrl()`, `getLabel()`,
   `getDescription()`.
4. Add a config schema `plugin.plugin_configuration.elasticsearch_connector.my_connector` in
   your own module so the resulting `search_api.server` config validates.
5. It becomes selectable as `backend_config.connector: my_connector` on any `search_api.server`
   using the `elasticsearch` backend — no core/Search API changes needed.

## The other (unused) plugin type: `elasticsearch_analyser`

The module also defines `plugin.manager.elasticsearch_connector.analyser`
(`Drupal\elasticsearch_connector\Analyser\AnalyserManager`), annotation `@ElasticSearchAnalyser`,
plugin namespace `Plugin/ElasticSearch/Analyser`, interface `AnalyserInterface`
(base class `AnalyserBase`). It exists to let a module customize Elasticsearch **text-analysis**
settings applied when an index is created, but the main module ships **no concrete analyser
plugin** — the only example (`AnalyzerOne`) lives in the test-only submodule
`elasticsearch_connector_test`, not in a real deployment.
