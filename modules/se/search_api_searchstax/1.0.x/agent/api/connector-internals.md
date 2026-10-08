<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Connector internals

`SearchStaxConnector extends StandardSolrConnector` (from `search_api_solr`). Source:
`src/Plugin/SolrConnector/SearchStaxConnector.php`. Annotation: `@SolrConnector(id="searchstax",
label="SearchStax Cloud with Token Auth")`.

## Authentication
- `connect()` calls `parent::connect()`, then on the `search_api_solr` endpoint calls
  `setAuthorizationToken('Token', $this->configuration['update_token'])`. Solarium adds an HTTP
  header `Authorization: Token <token>` to every Solr request. There is no username/password and no
  Basic auth.
- `defaultConfiguration()` adds `update_endpoint` and `update_token` (both `''`) and forces
  `scheme=https`, `port=443`.

## Transport / TLS
- All traffic is HTTPS: the form hard-codes `scheme=https`, `port=443`. The module itself sets **no**
  Guzzle/Solarium SSL options — certificate verification is left at the Solarium/`search_api_solr`
  default (verification on). There is no `verify => false` / `CURLOPT_SSL_VERIFYPEER` override.

## Working around SearchStax-blocked Solr admin APIs
SearchStax does not expose several admin/introspection APIs, so the connector overrides them with
safe stubs:
- `getServerInfo()` — hardcodes `['lucene' => ['solr-spec-version' => '8.11.1']]` (version
  auto-detection is blocked; 8.11.1 avoids the deprecated 6.0 field-type fallback).
- `getSchemaVersionString()` — defaults to `drupal-0.0.0-solr-8.x`, then tries a `<core>/schema`
  API call and reads `schema.name` if available.
- `coreRestGet()` — returns a placeholder `fieldTypes` entry ("Information about fieldTypes is not
  provided by SearchStax").
- `getLuke()` — returns empty fields and `numDocs = -1`.
- `getStatsSummary()` — zeros for pending docs / index size plus the schema version.
- `reloadCore()` — returns `FALSE` (no core reload).
- `pingServer()` — delegates to `pingCore()`.

## Config-set generation (`getFile()` / `alterConfigFiles()`)
Because the server side is managed, the Solr config-set is generated locally:
- `getFile()` pulls config files from `search_api_solr.configset_controller` and rewrites the
  embedded `drupal-x.y.z…` schema-version token to `getSchemaVersionString()`. On Drupal 8 (service
  missing) it returns an empty file list.
- `alterConfigFiles()` applies SolrCloud-appropriate edits: inserts `numVersionBuckets`, raises
  autoCommit/autoSoftCommit max times, strips the implicit `/replication` and `/get` request
  handlers, optionally appends a `statsCache`, rewrites `solr.luceneMatchVersion`, and unsets
  `solrcore.properties` (not read from ZooKeeper in SolrCloud).

## Surface area
No routing, permissions, services, controllers, hooks, forms (beyond the connector config form),
events, or Drush commands. The `.install` file is empty. The only config schema is the connector
settings mapping.
