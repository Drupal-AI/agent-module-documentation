# Legacy Solr connectors

Connector plugin (`src/Plugin/SolrConnector/`):
- `Solr36Connector.php` — id targets Solr 3.6-era servers; extends the base connector and
  overrides request building for the old API. This is the connector to select on the Search
  API server form when talking to a legacy server. It also covers the 4.5+/5.x paths together
  with the bundled config templates.

An `EventSubscriber/SearchApiSolrSubscriber.php` adjusts converted queries/config so requests
match what old Solr understands (service registered in
`search_api_solr_legacy.services.yml`).

## Config sets
Legacy Solr config templates ship under `solr-conf-templates/` with per-generation folders:
- `3.x/`, `4.x/`, `5.x/`

Build a config set from the matching folder and install it into your legacy Solr core, then
choose the legacy connector on the server. See the submodule `README.md` for the exact Solr
versions supported and caveats. No permissions, Drush, or config UI of its own.
