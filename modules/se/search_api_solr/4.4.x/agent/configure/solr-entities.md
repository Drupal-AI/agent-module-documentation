# Solr config entities

The module defines several **config entity types** (`src/Entity/`) that together compile the
Solr config set. Manage them from the server's Solr tabs at
`/admin/config/search/search-api/server/{server}/…`. Each can be enabled/disabled per server.

| Entity | Config prefix | Route base | Purpose |
|---|---|---|---|
| `SolrFieldType` | `search_api_solr.solr_field_type.*` | `entity.solr_field_type.*` | Language-specific Solr field types (analyzers, tokenizers, stemming). |
| `SolrCache` | `search_api_solr.solr_cache.*` | `entity.solr_cache.*` | `solrconfig.xml` cache definitions (filter/query/document caches). |
| `SolrRequestHandler` | `search_api_solr.solr_request_handler.*` | `entity.solr_request_handler.*` | Custom request handlers (e.g. `/select`, `/mlt`). |
| `SolrRequestDispatcher` | `search_api_solr.solr_request_dispatcher.*` | `entity.solr_request_dispatcher.*` | `requestDispatcher` settings in `solrconfig.xml`. |

Field types ship for many languages; add/edit at `/…/solr_field_type/add`. On each server
tab you can enable/disable an entity for that server (`enable_for_server`/`disable_for_server`
routes), which changes what ends up in the generated config set. Permission for all Solr
config screens: **`administer search_api`**. Schemas live in `config/schema/`
(`search_api_solr.field_type.schema.yml`, `.cache.schema.yml`, `.request_handler.schema.yml`,
`.request_dispatcher.schema.yml`). Reinstall/refresh field types with Drush
`search-api-solr:reinstall-fieldtypes` / `:install-missing-fieldtypes`.
