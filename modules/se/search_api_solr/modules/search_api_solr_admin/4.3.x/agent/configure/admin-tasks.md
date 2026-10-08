# Solr admin tasks & field analysis

Local actions appear on the Search API server page
(`/admin/config/search/search-api/server/{server}`) once this submodule is enabled.

## Tasks (permission: `execute solr admin task`)
- **Upload config set** — pushes the generated Solr config set to the server (SolrCloud
  Collections API `UPLOAD`/`CREATE`). Drush: `search-api-solr:upload-configset` (`solr-upload-conf`).
- **Reload** — reload core/collection so new config takes effect. Drush: `solr-reload`.
- **Delete collection** — Drush: `solr-delete-collection`.
- **Delete all** — clear every document from the index. Drush: `solr-delete-all`.

Commands are in `src/Commands/` (service in `search_api_solr_admin.drush.services.yml`),
backed by `SolrAdminCommandHelper`.

## Field analysis (permission: `perform field analysis`)
A form runs Solr's Analysis API for a chosen field type and value, showing the token stream
after each analyzer/filter at index time and query time — use it to debug matching, stemming,
synonyms, and stopwords. Controllers/routes are declared in
`search_api_solr_admin.routing.yml`; styling in `css/`, markup in `templates/`.
