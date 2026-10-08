<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Next.js GraphQL is a glue module that lets a Next.js front end use GraphQL (via GraphQL Compose) as its data layer for the Next.js integration, as an alternative to JSON:API (next_jsonapi).

---

The submodule is **info-only** — it ships just `next_graphql.info.yml` with no PHP, config, or schema. Its role is purely to declare a dependency set: enabling it pulls in `graphql`, `graphql_compose`, and `next`, wiring GraphQL Compose's schema into a Next.js decoupled setup so the front end can query content with GraphQL instead of JSON:API. Because it has no code of its own, it exposes no services, plugins, permissions, routes, or configuration; all actual behavior comes from the modules it depends on (GraphQL Compose provides the schema and the GraphQL endpoint; `next` provides preview/revalidation). It requires the contrib `graphql_compose` module to be installed. The GraphQL queries themselves are issued by the external Next.js application.

---

- Use GraphQL (via GraphQL Compose) instead of JSON:API as the Next.js data layer.
- Pull in the graphql + graphql_compose + next dependency set with one module enable.
- Build a headless Next.js site that queries Drupal content over GraphQL.
- Offer GraphQL to a front end that prefers typed schema queries over JSON:API.
- Combine GraphQL data fetching with next's preview and revalidation features.
- Standardize on GraphQL Compose's auto-generated schema for the decoupled front end.
- Choose GraphQL for more precise field selection than JSON:API sparse fieldsets.
- Serve a Next.js app that uses a GraphQL client (e.g. Apollo/urql) against Drupal.
- Swap the data layer from JSON:API to GraphQL by enabling this instead of next_jsonapi.
- Audit whether a site's Next.js integration is JSON:API- or GraphQL-based.
- Confirm the graphql_compose dependency is present before enabling.
- Provide the GraphQL option in the next-drupal ecosystem.
- Keep GraphQL wiring as a single enable/disable toggle (the glue module).
- Document the decoupled data-layer choice for a project.
- Reference which contrib modules a GraphQL-based Next.js setup requires.
- Prepare a multisite decoupled setup that standardizes on GraphQL.
- Enable GraphQL querying of nodes/taxonomy/media for the front end (via graphql_compose).
- Avoid custom GraphQL schema code by relying on GraphQL Compose.
- Decide between next_graphql and next_jsonapi based on the front-end's client.
- Serve GraphQL-based preview/data to a Next.js incremental static regeneration build.
