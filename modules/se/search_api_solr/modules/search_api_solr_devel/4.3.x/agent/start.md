# search_api_solr_devel — agent start

Developer debugging for Search API Solr: logs raw Solarium requests/responses and adds a Devel
tab to inspect Solr queries. Requires `devel` + `search_api_solr`. No config UI — enable and go.
Do not run on production.

Provides a Devel local task (`search_api_solr_devel.links.task.yml`), a debug controller
(`src/Controller/`), and request/response logging (`src/Logging/`, service in
`search_api_solr_devel.services.yml`) that decorates the Solr connector to capture traffic.
No configuration, permissions, or Drush commands — trivial module.
