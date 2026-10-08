# search_api_solr — agent start

Search API backend for Apache Solr (via Solarium). You create a Search API **server**
using the "Solr" backend, pick a **SolrConnector**, then add indexes as usual. Extra
Solr config lives under each server at `/admin/config/search/search-api/server/{id}/…`.
Depends on `search_api` + core `language`. No single `configure` route.

- Set up a Solr server/backend & connectors → [configure/server.md](configure/server.md)
- Solr config entities (field types, caches, request handlers/dispatchers) → [configure/solr-entities.md](configure/solr-entities.md)
- Define a custom SolrConnector plugin → [plugins/solr-connector.md](plugins/solr-connector.md)
- Services & programmatic APIs (field manager, command helper, query helper) → [api/services.md](api/services.md)
- Alter hooks (query/document/results/config) → [api/hooks.md](api/hooks.md)
- Drush commands (config set, field types, finalize, parallel index) → [drush/commands.md](drush/commands.md)
- Submodules: search_api_solr_admin, _autocomplete, _devel, _legacy, _log (see their own docs).
