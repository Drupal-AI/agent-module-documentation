<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin types: OpenSearch connectors & analysers

The module defines two attribute-based plugin types with their own managers.

## OpenSearch connector (`opensearch_connector`)

- Manager: `Drupal\search_api_opensearch\Connector\ConnectorPluginManager`
  (service `plugin.manager.search_api_opensearch.connector`).
- Attribute: `Drupal\search_api_opensearch\Attribute\OpenSearchConnector` (id, label, description).
- Interface: `OpenSearchConnectorInterface` (extends `PluginFormInterface`,
  `ConfigurableInterface`, `PluginInspectionInterface`).
- Discovery dir: `src/Plugin/OpenSearch/Connector/`.
- Built-in ids: `standard`, `basicauth`; `aws_signature` from the AWS submodule.

A connector turns config into an `\OpenSearch\Client`. Interface methods: `getLabel()`,
`getDescription()`, `getClient(): \OpenSearch\Client`, `getUrl(): string`, plus the
`ConfigurableInterface`/`PluginFormInterface` config + form methods.

### Implement a connector

```php
namespace Drupal\my_module\Plugin\OpenSearch\Connector;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\search_api_opensearch\Attribute\OpenSearchConnector;
use Drupal\search_api_opensearch\Plugin\OpenSearch\Connector\StandardConnector;

#[OpenSearchConnector(
  id: "my_connector",
  label: new TranslatableMarkup("My connector"),
  description: new TranslatableMarkup("Reaches the cluster with custom auth."),
)]
class MyConnector extends StandardConnector {
  protected function getClientOptions(): array {
    return parent::getClientOptions() + [/* auth, headers, … */];
  }
}
```

Extending `StandardConnector` (and overriding `getClientOptions()` / `defaultConfiguration()` /
`buildConfigurationForm()`) is the usual pattern — that is exactly how `BasicAuthConnector` and
`AwsSignatureConnector` are built. Provide a config-schema
`plugin.plugin_configuration.opensearch_connector.<id>` for your settings.

## OpenSearch analyser (`opensearch_analyser`)

- Manager: `Drupal\search_api_opensearch\Analyser\AnalyserManager`
  (service `plugin.manager.search_api_opensearch.analyser`).
- Attribute: `Drupal\search_api_opensearch\Attribute\OpenSearchAnalyser` (id, label).
- Base/interface: `AnalyserBase` / `AnalyserInterface`.
- Discovery dir: `src/Plugin/OpenSearch/Analyser/`.
- Built-in ids: `ngram`, `edge_ngram`.

An analyser contributes OpenSearch analyzer/tokeniser configuration (used by the ngram /
edge_ngram data types). Implement one by extending `AnalyserBase` and tagging it with the
`#[OpenSearchAnalyser(...)]` attribute.
