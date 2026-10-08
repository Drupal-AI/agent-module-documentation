<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Typesense GraphQL is a GraphQL schema extension that turns your Search API Typesense indexes into a queryable GraphQL API with dynamically generated types, facets, and semantic/hybrid search.
---
The module bridges the `graphql` and `search_api_typesense` contrib modules. Rather than shipping a static schema, `TypesenseSchemaGenerator` inspects the Typesense collection schema of each enabled index and emits GraphQL types, enums (e.g. `TypesenseCollection`, `TypesenseFacetId`), document types, hit types and facet types on the fly. Configuration lives entirely inside the GraphQL server: on the `core_composable` server's Schema Extensions you enable the "Typesense Search" extension, pick which collections to expose, and optionally assign per-collection aliases. There are no module-owned routes, permissions, or config forms — the settings persist with the GraphQL server config, and `TypesenseCollectionManager` reads them back by scanning `graphql.graphql_servers.*`.

The two headline queries are `searchTypesense` (full-text with configurable per-field weights, prefix/infix/typo tolerance, pagination, `KEYWORD_SEARCH`/`SEMANTIC_SEARCH`/`HYBRID_SEARCH` modes with `alpha`/`distanceThreshold`, highlighting, conjunctive/disjunctive facets, level-based hierarchical facets, and language filtering when a `langcode` field exists) and `typesenseDocumentById` for direct document retrieval. Data producers under `src/Plugin/GraphQL/DataProducer/**` resolve each field. **Security/operational note:** query results are served straight from the Typesense index — they are NOT re-filtered through Drupal entity/node access grants — so access control depends on (a) the GraphQL server's endpoint permission (`execute … arbitrary/persisted graphql requests`) and (b) exactly which fields you index and expose. Treat everything indexed as visible to anyone allowed to query the endpoint; do not index private/unpublished data you would not grant to that audience, and prefer persisted queries plus a restricted endpoint for anonymous traffic. The bundled `typesense_integration` submodule adds Search API processors (breadcrumb text, canonical entity URL, HTML-safe filtering, remove-excluded) and a schema-alter subscriber.
---
- Enable `graphql`, `search_api_typesense`, and this module together
- Expose a Typesense collection via the "Typesense Search" schema extension on a GraphQL server
- Assign a friendly GraphQL alias to a collection (e.g. index `content` → `CONTENT`)
- Run a full-text `searchTypesense` query across weighted fulltext fields
- Tune per-field relevance with `weight`, `prefix`, `infix`, and `numTypos`
- Paginate results with `page` and `perPage`
- Return facet counts with `facetFields` and filter with `selectedFacets`
- Enable disjunctive faceting to show all options with global counts
- Build drill-down category trees with `hierarchicalFacets` (level-based lvlN fields)
- Strip numeric weight prefixes from hierarchical facet labels for display
- Fetch a single document by ID with `typesenseDocumentById`
- Run vector `SEMANTIC_SEARCH` when embeddings are enabled on the collection
- Run `HYBRID_SEARCH` tuning keyword-vs-vector balance via `alpha`
- Constrain vector matches with `distanceThreshold`
- Return field-level highlights and snippets from matched documents
- Restrict payload size with include/exclude field selection
- Do facet-only (zero-hit) queries by not requesting hits (perPage forced to 0)
- Filter automatically by interface language when the index has a `langcode` field
- Apply raw Typesense `filterBy` expressions with AND/OR join
- Sort results by mapped fields or by `_text_match` relevance
- Expose taxonomy/node reference facets as `TypesenseEntityReference` objects
- Model key/value facets with the `typesense_key_value` data type
- Add breadcrumb text / canonical URL indexing via the `typesense_integration` submodule
- Preserve word boundaries across block elements with the HTML-filter-safe processor
- Exclude flagged entities from the index with the remove-excluded processor
- Gate anonymous access by restricting the GraphQL endpoint permission and using persisted queries
