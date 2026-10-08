<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Connector & analyser plugin types

The module defines **two custom plugin types** (both use `default_plugin_manager` parents, declared
in `search_api_elasticsearch_client.services.yml`).

## ElasticSearchConnector

- Annotation `src/Annotation/ElasticSearchConnector.php`; interface
  `src/Connector/ElasticSearchConnectorInterface.php` (extends `PluginFormInterface`,
  `ConfigurableInterface`, `PluginInspectionInterface`); manager
  `src/Connector/ConnectorPluginManager.php` (service
  `plugin.manager.search_api_elasticsearch_client.connector`). Plugin dir:
  `Plugin/ElasticSearchClient/Connector/`. Invalid selections raise
  `InvalidConnectorException`.
- Interface methods: `getLabel()`, `getDescription()`, `getUrl()`, `getClient(): Elastic\Elasticsearch\Client`.

### Built-in connectors

- **standard** (`StandardConnector.php`, label "Standard", *no authentication*). One config key
  `url`. Form field `url` (`#type url`, required); validated with `UrlHelper::isValid()`; trimmed of
  `/ ` in `submitConfigurationForm`. `getClient()` = `ClientBuilder::create()->setHosts([$url])->build()`.
  Only one host is supported.
- **basicauth** (`BasicAuthConnector.php`, label "HTTP Basic Authentication") — extends
  `StandardConnector`, adds `username` (`textfield`, required) and `password` (`#type password`).
  `getClient()` adds `->setBasicAuthentication($username, $password)`. The password field is left
  blank to keep the existing password (previous value restored in `submitConfigurationForm` when the
  username is unchanged and the field is empty).

### Writing a custom connector

Create a plugin in your module's `Plugin/ElasticSearchClient/Connector/` implementing
`ElasticSearchConnectorInterface` (or extend `StandardConnector`). Override `getClient()` to
configure the `Elastic\Elasticsearch\ClientBuilder` — e.g. API-key or cloud-ID auth, extra hosts, or
transport options — and add config-form fields. It then appears in the backend's connector radios.

## ElasticSearchAnalyser

- Annotation `src/Annotation/ElasticSearchAnalyser.php`; base `src/Analyser/AnalyserBase.php`;
  interface `AnalyserInterface`; manager `src/Analyser/AnalyserManager.php` (service
  `plugin.manager.search_api_elasticsearch_client.analyser`). Plugin dir:
  `Plugin/ElasticSearchClient/Analyser/`.
- An analyser exposes `getSettings()` returning Elasticsearch index-`settings` analysis config. When
  a field mapping references an analyzer (see [data-types.md](data-types.md)), `BackendClient::updateSettings()`
  instantiates the matching analyser and merges its settings into the index (with `max_ngram_diff = 20`).
- Built-ins: **ngram** (`Ngram.php`, `PLUGIN_ID`) and **edge_ngram** (`EdgeNgram.php`) — supply the
  ngram / edge-ngram tokenizer + filter settings used by the corresponding ngram field data types.
