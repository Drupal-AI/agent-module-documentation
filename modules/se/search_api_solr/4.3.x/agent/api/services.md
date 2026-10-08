# Services & programmatic APIs

Key services (`search_api_solr.services.yml`):

| Service | Class | Use |
|---|---|---|
| `plugin.manager.search_api_solr.connector` | `SolrConnectorPluginManager` | Load/instantiate SolrConnector plugins. |
| `solr_field.manager` | `SolrFieldManager` | Discover Solr fields for an index. |
| `solr_document.factory` | `SolrDocumentFactory` | Build typed `solr_document` items. |
| `solr_multisite_field.manager` / `solr_multisite_document.factory` | — | Same, for multisite search. |
| `search_api_solr.streaming_expression_query_helper` | `StreamingExpressionQueryHelper` | Build/run Solr streaming expressions. |
| `solarium.query_helper` | `Solarium\Core\Query\Helper` | Escape/format values for Solr queries. |
| `search_api_solr.configset_controller` | `SolrConfigSetController` | Generate the Solr config set files/zip. |
| `search_api_solr.command_helper` | `SolrCommandHelper` | Backs the Drush commands (finalize, get config, index). |

## Typical patterns
- Get the backend from a server: `$server->getBackend()` returns `SearchApiSolrBackend`;
  from it `getSolrConnector()` gives the active connector, `->getEndpoint()` the Solarium endpoint.
- Run a raw Solarium query via the connector (`->execute($query)`), or use the backend's
  `search()` through the normal Search API query API (`$index->query()->…->execute()`).
- Build a config set programmatically:
  `\Drupal::service('search_api_solr.configset_controller')->getConfigZip($server)`.
- Streaming expressions: get the helper, `->createQuery($index)`, set the expression, execute.

See also the alter hooks in [hooks.md](hooks.md).
