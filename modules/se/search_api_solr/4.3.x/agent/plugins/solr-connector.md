# Define a SolrConnector plugin

The module **defines** one plugin type (`search_api_solr.plugin_type.yml`):

```yaml
search_api_solr_connector:
  label: Connector
  plugin_manager_service_id: plugin.manager.search_api_solr.connector
```

Manager: `Drupal\search_api_solr\SolrConnector\SolrConnectorPluginManager` (service
`plugin.manager.search_api_solr.connector`). Connectors abstract *how* Drupal reaches Solr
(host, transport, auth, cloud vs standalone).

## Implement one
1. Create `src/Plugin/SolrConnector/MyConnector.php`.
2. Add the attribute `Drupal\search_api_solr\Attribute\SolrConnector`:
   ```php
   #[SolrConnector(
     id: 'my_connector',
     label: new TranslatableMarkup('My hosted Solr'),
     description: new TranslatableMarkup('Connects to Acme Solr.'),
   )]
   class MyConnector extends SolrConnectorPluginBase { /* … */ }
   ```
   (Legacy annotation `@SolrConnector` under `src/Annotation/` is also supported.)
3. Extend `SolrConnectorPluginBase` (or a shipped connector). Override
   `defaultConfiguration()`, `buildConfigurationForm()`, and the endpoint/auth methods
   (`getSolrConnection()`, `getEndpoint()`, `useTimeout`, `getServerLink()`, etc.). For auth
   reuse `BasicAuthTrait`. Cloud connectors extend the cloud base variants.

Shipped connectors to copy: `StandardSolrConnector`, `BasicAuthSolrConnector`,
`StandardSolrCloudConnector`, `BasicAuthSolrCloudConnector`. Your connector then appears in
the dropdown on the Search API server form.
