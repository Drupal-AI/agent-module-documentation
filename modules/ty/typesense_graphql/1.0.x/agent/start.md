<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Typesense GraphQL (typesense_graphql) — agent index

**A GraphQL schema extension that dynamically exposes Search API Typesense collections with faceted, hierarchical, semantic and hybrid search.**

- **Version:** 1.0.x (installed 1.0.0-beta13)
- **Core:** ^10 || ^11
- **Requires:** `search_api_typesense` (declared) and `graphql` (README) modules
- **Submodule:** `typesense_integration` (Search API processors + schema-alter subscriber)
- **Config:** none of its own — enable the "Typesense Search" **schema extension** on a GraphQL server (`/admin/config/services/graphql`), pick `enabled_collections`, optional `collection_aliases`; stored in `graphql.graphql_servers.*`
- **Routes/permissions:** none provided by this module (access is the GraphQL server's endpoint permission)
- **Services:** `typesense_graphql.collection_manager` (`TypesenseCollectionManager`), schema subscriber, logger channel
- **Queries:** `searchTypesense` (full-text, facets, hierarchical facets, KEYWORD/SEMANTIC/HYBRID modes, highlights, language filter) and `typesenseDocumentById`
- **Resolvers:** `src/Plugin/GraphQL/DataProducer/**` (e.g. `Query/SearchTypesense.php`, `TypesenseHits`, `TypesenseFacets`, `TypesenseDocumentById`)
- **Schema generation:** `TypesenseSchemaGenerator` builds types/enums from each collection's Typesense schema

**Security:** No module routes/permissions — access is governed entirely by the GraphQL server endpoint permission (`execute … arbitrary/persisted graphql requests`). Results come straight from the Typesense index and are **NOT** re-checked against Drupal entity/node access, so anything indexed is visible to anyone allowed to query the endpoint. Do not index private/unpublished data for a broader audience than intended; prefer a restricted endpoint + persisted queries for anonymous traffic. No `verify => false`, no unverified callbacks.

See [api/graphql.md](api/graphql.md)
