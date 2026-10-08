<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GraphQL Search API Query exposes Search API queries via GraphQL data producers.

---

GraphQL Search API Query exposes **Search API queries through GraphQL** — providing GraphQL data producers
so a decoupled/GraphQL client can run Search API searches (full-text, filters, facets) and receive results. It
depends on the GraphQL and Search API modules, in the GraphQL package.

Use it to query Search API from a GraphQL front end. It is a decoupled/search integration feature. Security
notes: results come from the **Search API index**, so what a GraphQL client can retrieve is governed by how
the index is built and by Search API's processors — ensure the index/query **respect content access** (index
access data, or apply access filters) so the GraphQL endpoint does not surface unpublished/restricted content;
and secure/scope the GraphQL endpoint itself. It has no access-control role of its own. Configure the GraphQL
schema and Search API index.

---

- Expose Search API via GraphQL.
- Provide GraphQL data producers.
- Run searches from a GraphQL client.
- Depend on GraphQL and Search API.
- Return full-text/filter/facet results.
- Serve decoupled front ends.
- Ensure the index respects content access.
- Avoid surfacing restricted content.
- Secure/scope the GraphQL endpoint.
- Have no access-control role of its own.
- Configure the schema and index.
- Handle GraphQL search.
- Query Search API.
- Configure the producers.
- Search via GraphQL.
- Handle the integration.
- Expose search.
- Return search results.
- Configure access.
- Provide GraphQL search.
