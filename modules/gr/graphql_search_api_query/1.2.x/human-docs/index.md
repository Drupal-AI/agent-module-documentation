# GraphQL Search API Query — manual setup guide

**GraphQL Search API Query** (`graphql_search_api_query`) exposes Drupal's
**Search API** through GraphQL, so a decoupled or headless front end can run
real searches — full-text queries, filters, facets, sorting and pagination —
instead of only fetching entities one at a time. It bridges the two systems by
providing GraphQL data producers that operate on your Search API *indexes*
rather than directly on entities.

If you already build entity queries with the `core_composable` schema from
GraphQL Core Schema, this will feel familiar: the search field uses the same
query syntax as core entity queries, but points at a search index. That means
you get relevance-scored keyword search, complex filters using all of Search
API's operators (equals, contains, between, and so on), facets on any indexed
field for building filtered browsing UIs, result grouping, and automatic
multilingual language filtering — all from GraphQL.

There is nothing to configure in this module itself. After you enable it, it
automatically extends your GraphQL schema with a new `searchApiQuery` field, and
it works as soon as you have a Search API index set up. The real "configuration"
lives in the two systems it connects: your Search API index (which fields are
indexed, searchable and facetable) and your GraphQL schema and endpoint.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside GraphQL and Search API.

There are **no configuration pages** for this module — it works out of the box
once your Search API index is in place.

## How to use it

1. Configure a **Search API** index (**Configuration → Search and metadata →
   Search API**) that includes the fields you want to search and facet on, and
   make sure it is indexed.
2. Use the `core_composable` schema from **GraphQL Core Schema**; this module
   extends it with the new `searchApiQuery` field automatically on install.
3. Open GraphiQL or a GraphQL explorer and test a `searchApiQuery`, applying
   full-text terms, filters, facets, sorting and pagination as needed.

> **Security note:** Results come straight from the Search API index, so what a
> GraphQL client can retrieve is decided by how that index is built. Make sure
> the index and query **respect content access** — index the access data or
> apply access filters — so the endpoint never surfaces unpublished or
> restricted content. This module has no access-control role of its own, and you
> should still secure and scope the GraphQL endpoint itself. It is *not covered*
> by Drupal's security advisory policy.
