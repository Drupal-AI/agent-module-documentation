# Configure a Solr server & connector

Create a Search API server at `/admin/config/search/search-api/add-server`, choose backend
**Solr**. The backend plugin is `Drupal\search_api_solr\Plugin\search_api\backend\SearchApiSolrBackend`.

## Connectors (SolrConnector plugin)
Pick a connector on the server form; each supplies host/port/path/core + auth:
- `standard` — `StandardSolrConnector` (single Solr node).
- `basic_auth` — `BasicAuthSolrConnector` (HTTP Basic Auth).
- `solr_cloud` — `StandardSolrCloudConnector` (SolrCloud, uses collections/ZooKeeper).
- `solr_cloud_basic_auth` — `BasicAuthSolrCloudConnector`.
Connector config schema: `config/schema/search_api_solr.connector.*.schema.yml`.

## Server config (Search API server entity)
Backend settings persist in the `search_api.server.*` config (schema
`search_api_solr.backend.schema.yml`): connector id + connector_config, plus retrieve-data,
highlighting, `fallback_multiple`, `index_single_documents_fallback_backend`, commit-within, etc.

## Getting a Solr config set onto your server
The server's **Files**/**config set** tabs stream generated Solr files
(`/…/server/{id}/files`, route `search_api_solr.solr_config_files`) and per-file endpoints
(`schema_extra_types.xml`, `solrconfig_extra.xml`, …). Download the full zip, or use Drush
`search-api-solr:get-server-config` (see [../drush/commands.md](../drush/commands.md)) and
install it into Solr. The `search_api_solr_admin` submodule can upload config sets directly
via the Collections API.

Indexes are created and mapped to the server exactly like any Search API index; field types
are chosen automatically per language from the installed SolrFieldType entities.
