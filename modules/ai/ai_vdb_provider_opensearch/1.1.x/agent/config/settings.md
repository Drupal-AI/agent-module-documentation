<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — ai_vdb_provider_opensearch

Grounds: `src/Form/OpenSearchConfigForm.php`, `ai_vdb_provider_opensearch.routing.yml`,
`ai_vdb_provider_opensearch.links.menu.yml`, `config/schema/ai_vdb_provider_opensearch.schema.yml`,
`ai_vdb_provider_opensearch.info.yml`.

## Install / enable

```
composer require drupal/ai_vdb_provider_opensearch
drush en ai_vdb_provider_opensearch -y
```

Pulls in `ai`, `ai_search`, `key`, `search_api_opensearch` (which brings the
`opensearch-project/opensearch-php` client). You need a reachable OpenSearch 2.4+ cluster with the
k-NN plugin. Experimental module — expect API churn.

## Route, permission, menu

- Route **`ai_vdb_provider_opensearch.settings_form`** → `/admin/config/ai/vdb_providers/opensearch`,
  `_form: OpenSearchConfigForm`, requirement `_permission: 'administer ai providers'`.
- Menu link `ai_vdb_provider_opensearch.settings_menu` ("OpenSearch Configuration") under parent
  `ai.admin_vdb_providers`.
- `info.yml` `configure:` points at the same route. (Note: the README's `/admin/config/search/...`
  path is stale; the routing.yml path above is authoritative.)

## Config object `ai_vdb_provider_opensearch.settings`

Written by `OpenSearchConfigForm::submitForm()`. Keys (schema: `config_object`):

- `connector` (string) — the Search API OpenSearch **connector plugin id**; defaults to
  `'standard'` (the form's `$configuration` default). Schema label "The connector plugin ID".
- `connector_config` — typed dynamically as
  `plugin.plugin_configuration.opensearch_connector.[%parent.connector]`; the shape is defined by
  the chosen connector plugin (e.g. endpoint URL, and an auth **Key** reference for authenticated
  clusters). This module builds that subform via `ConnectorFormTrait::buildConnectorConfigForm()`
  and validates it via `validateConnectorConfigForm()`.
- `vdb_config.engine` (string) — k-NN engine `select`, `#required`, default `'faiss'`. Options:
  `faiss` (FAISS, default), `lucene` (Lucene), `nmslib` (deprecated; incompatible with OpenSearch 3+).

There is **no `config/install/`** — the config object does not exist until the form is saved;
`buildForm()` falls back to `['connector' => 'standard', 'connector_config' => []]` when raw data is
empty.

## Form flow (source)

- `buildForm()` loads `ai_vdb_provider_opensearch.settings` raw data, renders the connector subform
  (`buildConnectorConfigForm`) plus the `vdb_config` details group, and a submit button.
- `validateForm()` delegates connector validation to `validateConnectorConfigForm()`.
- `submitForm()` calls `submitConnectorConfigForm()`, then sets `connector`, `connector_config`,
  `vdb_config` on the editable config and saves; adds a status message.
- `buildAjaxConnectorConfigForm()` returns `$form['connector_config']` for the connector-switch AJAX.

## Connector / credentials / endpoint

This module never opens a socket itself. The OpenSearch endpoint URL, port, TLS behaviour and
authentication all come from the selected **Search API OpenSearch connector** and are stored in its
`connector_config`. Authenticated clusters (incl. **AWS OpenSearch Service** via
`search_api_aws_signature_connector`) reference a **Key** entity for credentials — install/enable
`key` (already a dependency) and create the Key first. To operate: pick a connector, fill its
endpoint + Key, choose the engine, save, then select the `opensearch` provider inside an **AI Search**
Search API server.

## After configuring

The AI Search backend drives the provider (see [../plugins/vdb_provider.md](../plugins/vdb_provider.md)):
it creates a collection (OpenSearch index) with a `knn_vector` mapping, indexes embeddings, and runs
k-NN searches. `ping()`/`isSetup()` are used to health-check the connection.
