<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Next.js GraphQL — agent index

Glue submodule of [next](../../../../2.1.x/agent/start.md) that makes GraphQL (via **GraphQL
Compose**) the data layer for a Next.js decoupled site, instead of JSON:API (next_jsonapi).

**It is info-only** — `next_graphql.info.yml` and nothing else: no PHP, no services, no plugins, no
config, no schema, no permissions, no routes. Its entire purpose is the dependency set.

Key facts:
- Depends on `graphql`, `graphql_compose`, and `next`. Requires the contrib `graphql_compose` module.
- Provides no code of its own — behavior comes from GraphQL Compose (schema/endpoint) + `next`
  (preview/revalidation).
- Alternative to `next_jsonapi`: choose GraphQL vs JSON:API for the front-end data layer.
- The GraphQL queries are made by the external Next.js app.

No solution docs: there is no configuration, plugin, service, or hook to document — enabling the
module simply enables its dependencies.
