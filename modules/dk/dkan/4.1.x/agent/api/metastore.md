<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Metastore + search JSON API (dkan_metastore, dkan_metastore_search)

The metastore stores each dataset (and other schema-defined items) as a core `node` of bundle
**`data`**, keeping the JSON metadata in `field_json_metadata`. The REST API lives under
`/api/1/metastore/…`; a DCAT-US catalog is served at `/data.json`; full-text/faceted search is at
`/api/1/search`. All routes set `_auth: ['basic_auth','cookie']`.

Controller: `Drupal\dkan_metastore\Controller\MetastoreController` (+ `MetastoreRevisionController`).
Service: `dkan.metastore.service` (`Drupal\dkan_metastore\MetastoreService`). Custom access:
`Drupal\dkan_metastore\Controller\MetastoreAccessManager`.

## Read routes (all gated by `_permission: 'access content'`)

| Route name | Method · Path | Controller method |
| --- | --- | --- |
| `dkan_metastore.1.metastore` | GET `/api/1/metastore` | `OpenApiController::getComplete` (spec) |
| `dkan_metastore.1.metastore.schemas` | GET `/api/1/metastore/schemas` | `getSchemas` |
| `dkan_metastore.1.metastore.schemas.id` | GET `/api/1/metastore/schemas/{identifier}` | `getSchema` |
| `dkan_metastore.1.metastore.schemas.id.items` | GET `/api/1/metastore/schemas/{schema_id}/items` | `getAll` |
| `dkan_metastore.1.metastore.schemas.id.items.id` | GET `/api/1/metastore/schemas/{schema_id}/items/{identifier}` | `get` |
| `dkan_metastore.1.metastore.schemas.dataset.items.id.docs` | GET `…/dataset/items/{identifier}/docs` | `getDocs` (per-dataset OpenAPI) |
| `dkan_metastore.data_json` | GET `/data.json` | `getCatalog` |
| `dkan_metastore_search.1.search` | GET `/api/1/search` | `SearchController::search` |
| `dkan_metastore_search.api.facets` | GET `/api/1/search/facets` | `SearchController::facets` |

Query params on item GETs: `show-reference-ids` / `show_reference_ids` (inline referenced sub-items).
Search params: `page`, `page-size` (capped at 100), `facets`, plus `fulltext`/facet filters;
non-numeric `page`/`page-size` → 400.

**Publication filtering:** reads return **published items only** by default. `MetastoreService::getAll()`
and `getCatalog()` call `retrieveAll(..., $unpublished = FALSE)`; `get()` uses `retrieve($id, $published = TRUE)`.
Unpublished/draft datasets are therefore excluded from anonymous list/catalog/get responses. (Note the
datastore query/SQL endpoints resolve tables by resource UUID and do **not** re-check dataset
publication — see [datastore.md](datastore.md).)

## Write routes (custom access via `MetastoreAccessManager`)

| Route | Method · Path | Access callback |
| --- | --- | --- |
| `…items.post` | POST `/api/1/metastore/schemas/{schema_id}/items` | `MetastoreAccessManager::canCreate` |
| `…items.id.put` | PUT `…/items/{identifier}` | `canUpdate` |
| `…items.id.patch` | PATCH `…/items/{identifier}` | `canUpdate` |
| `…items.id.delete` | DELETE `…/items/{identifier}` | `canDelete` |
| `…items.id.publish` | PUT `…/items/{identifier}/publish` | `canUpdate` |
| `…items.id.revisions.post` | POST `…/items/{identifier}/revisions` | `canUpdate` |
| `…items.id.revisions` | GET `…/items/{identifier}/revisions` | `canViewRevisionList` |
| `…items.id.revisions.id` | GET `…/items/{identifier}/revisions/{revision_id}` | `canViewRevision` |

`MetastoreAccessManager` (`Controller/MetastoreAccessManager.php`) is a real permission check, **not**
an open route: each callback first honours the legacy permission `post put delete datasets through the api`
and otherwise **defers to the `node` entity access-control handler** for bundle `data`
(`createAccess` / `access($entity,'update'|'delete')`). So writes require either that legacy permission
or standard node permissions (`create data content`, `edit any/own data content`, `delete …`).
Anonymous POST returns **401** (runtime-verified). For a missing item, `canUpdate`/`canDelete` return
`allowed()` and let the controller emit 404 (info-leak-safe); PUT to a missing item still requires create
access.

Body handling: POST/PUT/PATCH read the raw request body (`$request->getContent()`) and validate it with
`ValidMetadataFactory` against the JSON schema; PATCH applies an RFC-7386 JSON merge-patch. The
`identifier` in the body must match the URL identifier (`CannotChangeUuidException` otherwise).

## Notes for agents

- `{schema_id}` is usually `dataset`; schemas come from `SchemaRetriever` (site + module `schema/` dirs).
- Successful POST returns `201` with `{endpoint, identifier}`; the identifier is a UUID.
- Responses are cache-metadata-aware via `dkan.metastore.api_response` (`MetastoreApiResponse`).
- Default install ships roles `api_user` (legacy write permission) and, with `dkan_alt_api`,
  `alternate_api_user`.
