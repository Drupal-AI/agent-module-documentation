<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Backend configuration (elasticsearch_client)

Class `ElasticSearchBackend` (`src/Plugin/search_api/backend/ElasticSearchBackend.php`), a
`@SearchApiBackend` (id `elasticsearch_client`, label "Elasticsearch Client"). There is **no admin
route of its own** — you configure it as the backend of a Search API **server** at
`/admin/config/search/search-api/add-server` (route `entity.search_api_server.add_form`). Config is
stored on the `search_api.server.*` config entity.

## Prerequisites

1. Install the official ES PHP client yourself (not a Composer dep of this module):
   `ddev composer require elasticsearch/elasticsearch ^8.11` (any `^8` matching your cluster).
2. `ddev drush en search_api_elasticsearch_client -y` (pulls in `search_api`, `geofield`).

## Configuration form (`buildConfigurationForm`)

- **connector** (`radios`, required) — chooses an `ElasticSearchConnector` plugin (`standard` /
  `basicauth`). AJAX-swaps the connector sub-form (`buildAjaxConnectorConfigForm`).
- **connector_config** — the selected connector's own sub-form (URL, and username/password for
  basicauth). See [../plugins/connectors.md](../plugins/connectors.md).
- **advanced** (details):
  - **fuzziness** (`select`, required) — `0` (disabled), `auto` (default, `FUZZINESS_AUTO`), or
    `1`–`5`. Applied to full-text terms by `SearchParamBuilder`.
  - **prefix** (`textfield`) — index prefix prepended to every Search API index id
    (`BackendClient::getIndexId()` returns `prefix . $index->id()`); useful to share one cluster
    across projects/environments.
  - **synonyms** (`textarea`) — Solr `synonyms.txt` format; stored as an array (split on `PHP_EOL`
    in `submitConfigurationForm`) and applied via the synonyms event subscriber.

`defaultConfiguration()`: `connector = 'standard'`, `connector_config = []`,
`advanced = { fuzziness: 'auto', prefix: NULL, synonyms: [] }`.

## Config schema

`config/schema/search_api_elasticsearch_client.backend.schema.yml` defines
`plugin.plugin_configuration.search_api_backend.elasticsearch_client` with `connector`,
`connector_config` (typed dynamically as
`plugin.plugin_configuration.elasticsearch_connector.[%parent.connector]`), and `advanced`
(`fuzziness`, `prefix`). Connector schemas live in the sibling `*.connector.standard.schema.yml`
and `*.connector.basicauth.schema.yml`.

## Runtime accessors

- `getConnector()` → instantiates the connector plugin; throws `InvalidConnectorException` if the
  plugin does not implement `ElasticSearchConnectorInterface`.
- `getClient()` → lazily builds and caches the `Elastic\Elasticsearch\Client` from the connector.
- `getBackendClient()` → builds a `BackendClient` via `BackendClientFactory::create()`, passing
  settings `{ prefix, fuzziness }`.
- `viewSettings()` shows the cluster URL and, if the server is enabled, a reachability check
  (`server->isAvailable()` → `BackendClient::isAvailable()` → `client->ping()`).
- The ES `Client` is excluded from serialization (`__sleep()` unsets `client`).

## Operate

Create the server, pick the backend, choose a connector + URL, save; then create/attach a Search
API **index** to that server and index content (`drush search-api:index`). Field mappings and index
settings are pushed automatically when the index is created/updated (see
[../api/backend-client.md](../api/backend-client.md)).
