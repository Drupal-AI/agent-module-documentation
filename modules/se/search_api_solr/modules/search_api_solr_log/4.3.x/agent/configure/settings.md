# Configure Solr logging

## Settings
`/admin/config/search/search-api-solr-log` — route `search_api_solr_log.settings`, form
`Drupal\search_api_solr_log\Form\LogSettingsForm`. Permission: `administer site configuration`.
Controls the Solr logger (which Search API index/server receives log events). Config schema in
`config/schema/`.

## Log report
Provided as a View (config under `config/`) with **exposed Facets filters** (severity, type,
date) — depends on `facets_exposed_filters` and `views`. Browse events fast even at high volume
since they are stored and queried in Solr rather than the `watchdog` DB table.

## Clearing logs
`/admin/reports/search-api-solr-log/clear-logs` — route `search_api_solr_log.clear_logs`,
confirm form `ClearLogConfirmForm` (permission `administer site configuration`) deletes recent
log messages from the Solr index.

Logger implementation lives in `src/` (service in `search_api_solr_log.services.yml`); menu/
action links in `search_api_solr_log.links.*`. Views integration in
`search_api_solr_log.views.inc`.
