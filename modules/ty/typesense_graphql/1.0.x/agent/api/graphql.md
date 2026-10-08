<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GraphQL API — Typesense GraphQL

No module routes. The API is served by the **GraphQL server endpoint** you attach the "Typesense Search" schema extension to (typically `core_composable` at `/graphql`). Access = that server's endpoint permission. Schema is generated from each enabled collection's Typesense schema, so enum/type names depend on your collection alias (uppercased, `-`→`_`).

## Enable collections
`/admin/config/services/graphql` → edit server → Schema Extensions → **Typesense Search** → Configure → tick collections, set aliases. Persisted in `graphql.graphql_servers.<id>` under `schema_configuration[…]['extension_typesense_graphql']` with keys `enabled_collections` and `collection_aliases`. `TypesenseCollectionManager::getEnabledCollections()` reads them back.

## searchTypesense
```graphql
query($text: String) {
  searchTypesense(
    collection: CONTENT
    text: $text
    fulltextFields: [{ name: "title", weight: 5, prefix: true, numTypos: 1 }]
    perPage: 20
    page: 0
    facetFields: [{ id: CONTENT_BUNDLE }, { id: CONTENT_TAGS, disjunctive: true }]
    selectedFacets: [{ id: CONTENT_BUNDLE, values: ["article"] }]
  ) {
    total
    facets { id type terms { id label count } }
    hits { document { ... on TypesenseHitDocumentContent { title } } highlights { field snippet } }
  }
}
```
Key args: `searchMode` (`KEYWORD_SEARCH`|`SEMANTIC_SEARCH`|`HYBRID_SEARCH`; semantic/hybrid require embeddings on the collection or an `InvalidArgumentException` is thrown), `alpha`, `distanceThreshold`, `sortBy: [{ field: …, direction: ASC|DESC }]`, `filterBy: { expression, join }`, `hierarchicalFacets: [{ id, separator, sortBy, stripWeightPrefix }]`, include/exclude field lists. When the index has a `langcode` field, results are auto-filtered by the requested `language`. If hits are not requested, `perPage` is forced to 0 for facet-only queries.

## typesenseDocumentById
Retrieve one indexed document by its Typesense id (language-aware). Useful for detail views without a search.

## Hierarchical facets
Level-based (Algolia-style): index `{base}_lvl1/2/3…` fields as `Typesense: Hierarchy Level`, enable facet+sort. Query with `hierarchicalFacets: [{ id: PRODUCTS_CATEGORY, separator: " > " }]`; drill down by adding `selectedFacets` with the full path value. See the module README for the full worked example.

## Access reminder
Documents are returned verbatim from Typesense with **no Drupal entity-access recheck**. Restrict the GraphQL endpoint permission and index only what the querying audience may see.
