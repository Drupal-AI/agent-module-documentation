<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DKAN (dkan) — agent index

Open-data portal for Drupal — a distribution-scale **suite of submodules**, not a single module. It
catalogs datasets as user-defined JSON metadata (`dkan_metastore`), imports the tabular file behind
each dataset into a queryable database table (`dkan_datastore`), pulls catalogs from other portals
(`dkan_harvest`), and exposes all of it over a documented HTTP/JSON API under `/api/1/…` plus a
DCAT-US `/data.json`. Datasets are stored as core `node` entities of bundle **`data`**
(field `field_json_metadata`) under a `content_moderation` workflow **`dkan_publishing`**
(states: draft, published, hidden, archived, orphaned), so metadata read/write access rides on
standard node entity access. The enabling module here (`dkan`) is a thin meta-package: it just
depends on the pieces and provides two update hooks.

- Depends on (info.yml): `dkan:dkan_metastore`, `dkan:dkan_metastore_admin`,
  `dkan:dkan_metastore_search`, `dkan:dkan_common`, `dkan:dkan_data_dictionary_widget`,
  `json_form_widget:json_form_widget`, + core `config`, `field`, `file`, `link`, `options`, `path`.
  Composer pulls `facets`, `search_api`, `select2`, `select_or_other`, `views_bulk_operations`,
  `moderated_content_bulk_publish`, Guzzle, and the `getdkan/*` libraries.
- Core: `^10.2 || ^11`. Package: `DKAN`. License GPL-2.0-or-later.
- No single settings page on the parent; each area has its own admin form under `/admin/dkan/…`.
  Provides **granular per-verb API permissions**, config schema, plugin types, and Drush commands
  (all in submodules).
- Plugin types (in `dkan_common`): **`DkanApiDocs`** (`plugin.manager.dkan_api_docs`) for OpenAPI
  spec fragments, **`DatasetInfoPlugin`** (`plugin.manager.dataset_info`) for dataset status info.

## Submodule map (grouped)

- **Metastore (metadata + JSON API)** — `dkan_metastore` (dataset node storage + metastore API,
  `/api/1/metastore/…`, `/data.json`) · `dkan_metastore_admin` (admin Views/toolbar for dataset
  content) · `dkan_metastore_search` (`/api/1/search` via Search API) · `dkan_metastore_facets`
  (facet blocks) · `dkan_data_dictionary_widget` (data-dictionary field widget).
- **Datastore (tabular data + query API)** — `dkan_datastore` (CSV → DB table, query + SQL endpoints,
  import/drop API) · `dkan_datastore_mysql_import` (LOAD DATA fast-path importer).
- **Harvest (aggregate external catalogs)** — `dkan_harvest` (register/run harvest plans that fetch a
  remote `data.json`, `/api/1/harvest/…`).
- **Foundation / frontend** — `dkan_common` (shared utils, base `/api` OpenAPI endpoints, storage/query
  abstraction, Drush; nested `dkan_alt_api` for anonymous-vs-authenticated API variants) ·
  `dkan_js_frontend` (routes a decoupled React front end) · `dkan_sample_content` (demo data).

> SCOPE: this doc set covers the **suite architecture + the public API + setup**. Individual submodule
> internals (every service/queue-worker/plugin) are not exhaustively enumerated here.

## What you'd do → where

- **Call the public REST/JSON API — read the catalog, write dataset metadata, publish/revise** →
  [api/metastore.md](api/metastore.md)
- **Query tabular datastore data, import/drop a resource, or use the SQL endpoint** →
  [api/datastore.md](api/datastore.md)
- **Register and run harvests of external data.json catalogs** → [api/harvest.md](api/harvest.md)
- **Install the suite, pick submodules, grant API permissions, tune settings** →
  [configure/setup.md](configure/setup.md)

## Key facts (real machine names)

- Entry-point routes (all `_auth: ['basic_auth','cookie']`): `/api`, `/api/1` (OpenAPI, `access content`);
  metastore `/api/1/metastore/schemas/{schema_id}/items` (GET `access content`, POST/PUT/PATCH/DELETE →
  `MetastoreAccessManager`); `/data.json` (`access content`); datastore `/api/1/datastore/query…`,
  `/api/1/datastore/sql` (GET/POST), `/api/1/datastore/imports`; harvest `/api/1/harvest/…`;
  search `/api/1/search`, `/api/1/search/facets`.
- Controllers: `dkan_metastore\Controller\MetastoreController` (+ `MetastoreRevisionController`,
  `MetastoreAccessManager` custom-access), `dkan_datastore\Controller\{QueryController,
  QueryDownloadController,ImportController}` (base `AbstractQueryController`),
  `dkan_datastore\SqlEndpoint\WebServiceApi`, `dkan_harvest\WebServiceApi`,
  `dkan_metastore_search\Controller\SearchController`, `dkan_common\Controller\OpenApiController`.
- Core services: `dkan.metastore.service` (`MetastoreService`), `dkan.datastore.service`
  (`DatastoreService`), `dkan.datastore.query` (`Service\Query`), `dkan.datastore.sql_endpoint.service`
  (`DatastoreSqlEndpointService`), `dkan.harvest.service` (`HarvestService`),
  `dkan.metastore.resource_mapper`, `dkan.common.dataset_info`.
- Permissions: `datastore_api_import`, `datastore_api_drop`, `harvest_api_index`,
  `harvest_api_register`, `harvest_api_run`, `harvest_api_info`, `dkan.harvest.dashboard`,
  legacy `post put delete datasets through the api` (DEPRECATED — use node content perms),
  `administer metastore settings`, `administer data dictionary settings`; alt-API:
  `get data through the alternate metastore api`, `query the alternate sql endpoint api`.
- Content model: node type **`data`**, fields `field_json_metadata` + `field_data_type`, workflow
  `dkan_publishing`. Default roles: `api_user`, `alternate_api_user`.
- Plugin type ids: `DkanApiDocs` (dir `Plugin/DkanApiDocs`), `DatasetInfoPlugin` (dir
  `Plugin/DatasetInfo`). Query DSL parser: `dkan_datastore\SqlParser\SqlParser` (bracketed
  `[SELECT … FROM <resourceId>][WHERE …][ORDER BY …][LIMIT …];`).
- Config: `dkan_datastore.settings` (`rows_limit`, `purge_file`, `purge_table`,
  `response_stream_max_age`), `dkan_metastore.settings` (`csv_headers_mode`, `property_list`,
  `redirect_to_datasets`, `html_allowed_html`), `dkan_common.settings`,
  `dkan_datastore_mysql_import.settings`, `dkan_js_frontend.config`.
