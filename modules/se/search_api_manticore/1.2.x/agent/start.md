<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API Manticore — agent index

**Manticore Search backend for Search API**. Version **1.2.1** (branch `1.2.x`). Core `^10.5 || ^11`, PHP `>= 8.3`.

A Search API backend that indexes and searches content in a [Manticore Search](https://manticoresearch.com)
engine over its **HTTP JSON API**, through the official `manticoresoftware/manticoresearch-php` SDK (`^4.0`).
Depends on core `key`, `language`, and `search_api:search_api`. Configured entirely as a Search API server
(`configure: search_api.overview`) — the module exposes no routes and no permission of its own.

## What it does

- **Backend plugin** `search_api_manticore` (`src/Plugin/search_api/backend/SearchApiManticoreBackend.php`)
  registers Manticore as a Search API server backend. All configuration is admin-only Search API server/index config.
- **Connector plugin system** (`src/Connector`, `src/Attribute/Connector.php`): the default `sdk` connector
  (`src/Plugin/Manticore/Connector/SdkConnector.php`) holds the Manticore **URL** and optional **HTTP Basic Auth**
  (username + a **Key entity** reference for the password). Alternative transports can register as sibling plugins.
- **Client seam** `ManticoreClientInterface` → `SdkClient` (`src/Api/`): the only place the SDK namespace is used.
  Custom **status-aware transports** (`src/Api/Transport/`) keep the HTTP status visible when an error response
  carries a non-JSON body (e.g. a proxy 401), which the stock SDK transport discards.
- **Translation layer** (`src/SearchAPI/`): field mapping, index/delete param builders, and a `Query/` subtree of
  builders/parsers for full-text, filters, sorts, facets, autocomplete, spellcheck, geo-distance, and geo-clustering.
- **Write-path lifecycle events** (`src/Event/`, six events): `PreIndexEvent`, `AlterIndexParamsEvent`,
  `PostIndexEvent`, `PreDeleteEvent`, `AlterDeleteParamsEvent`, `PostDeleteEvent`. Public API, frozen since 1.0.0.
- **Views handlers** (`search_api_manticore.views.inc`, `src/Plugin/views/`): a "Related items" contextual filter
  (`ManticoreMoreLikeThis`) and an exposable "Semantic search" filter (`ManticoreSemantic`), both vector-backed.

## Supported Search API features (1.2.x)

- Full-text search (Views + query API, incl. Direct parse mode); all six field types; filtering; sorting; paging with
  exact counts; language filtering.
- `search_api_facets` (+ OR operator, per-element counts on multi-value fields).
- `search_api_autocomplete` (needs infix indexing + Manticore Buddy).
- **Spellcheck** ("did you mean", via `search_api_spellcheck`; needs infix indexing).
- **More Like This** / **semantic** / **hybrid** vector search via engine-side auto-embeddings (`float_vector`
  columns, `FloatVectorDataType`); Drupal never computes or transmits a vector.
- **Location & geospatial**: radius filter, distance sort, and optional server-side geohash clustering
  (needs `beste/latlon-geohash`).
- Random sort (Global: Random Views criterion).
- Not supported: grouping (`search_api_grouping`).

## How keys/filters reach the engine (mechanism)

- **Full-text keys** are tokenized by the engine itself (`CALL KEYWORDS`) and reassembled into structured JSON
  `match`/`bool` clauses one clause per keyword position — nothing the user typed is spliced into a query string.
  Direct parse mode is the one exception: the user owns that raw Manticore syntax by design.
- **Filters/facets** become structured Manticore JSON clauses (`equals`, `in`, `range`, `bool`, `geo_distance`),
  never concatenated SQL.
- **DDL** (create/alter table, vector columns) is admin-config-derived and validated: setting names against an
  identifier pattern, values against a reject-list; `CALL SUGGEST`/`CALL KEYWORDS` free-text is quote-escaped.
- **Excerpts/highlighting** use Search-API-conventional `<strong>` markup returned via `ItemInterface::setExcerpt()`;
  Search API/Views handle the rendering as with any backend.

## Key files

- `search_api_manticore.info.yml`, `composer.json` — deps: `search_api ^1.37`, `key ^1.22`, `manticoresearch-php ^4.0`.
- `config/schema/search_api_manticore.schema.yml` — backend + connector + per-index (`table_settings`,
  `vector_fields`, `cluster_fields`) config schema.
- `search_api_manticore.module` — index Fields/Edit form alters (vector, clustering, table settings).
- `search_api_manticore.install` — `hook_requirements` (geohash library warning) + `update_10001`
  (rename `autocomplete_min_infix_len` → `min_infix_len`).
- `src/SearchAPI/Query/SearchParamBuilder.php`, `FilterBuilder.php`, `src/Api/SdkClient.php` — the query/DDL boundary.

## Docs

- `usage.md` — one-paragraph summary + use-case bullets.
- `human-docs/` — manual setup guide (installation, configuration) for a human clicking through the UI.
- Full narrative reference lives in the module's own `README.md` (events, vector search, geospatial, tests).

## Diff 1.1.x → 1.2.x

Based on the shipped `1.2.1` release source versus the `1.1.x` documentation baseline:

- **Release/branch**: `1.1.1` → `1.2.1`; new branch `1.2.x`. Core requirement unchanged (`^10.5 || ^11`), PHP `>= 8.3`.
- **Spellcheck** ("did you mean", `search_api_spellcheck`) is now a shipped feature — `SpellcheckParamBuilder` /
  `SpellcheckResultParser` and the `CALL SUGGEST` client path are present. The `1.1.x` scraped feature matrix listed
  spellcheck as "not supported yet".
- **Location & geospatial search** now ships end to end: radius filter and distance sort (`geo_distance`) plus optional
  server-side geohash clustering (`GeoClusterParamBuilder`/`GeoClusterResultParser`, `beste/latlon-geohash`). The
  `1.1.x` matrix listed the location data type as "not supported yet".
- **Vector search** (semantic / hybrid / related-items) via engine-side auto-embeddings is present as `FloatVectorDataType`,
  the `ManticoreSemantic` filter, and the `ManticoreMoreLikeThis` argument.
- **Infix setting renamed**: `update_10001` migrates the server setting `autocomplete_min_infix_len` → `min_infix_len`
  (now feature-neutral, shared by autocomplete and spellcheck; a stored `0` is preserved so infixing stays off).
- **Metadata correction**: the module provides **no permission** of its own and **no route** (no `*.permissions.yml`,
  no `*.routing.yml`) — the `1.1.x` `data.json` `provides_permissions` value is corrected to `false` here.
- Grouping (`search_api_grouping`) remains unsupported.
