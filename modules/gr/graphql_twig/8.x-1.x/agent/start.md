<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GraphQL Twig (graphql_twig) — agent index

Runs a **GraphQL query embedded in a Twig theme template** and injects the result.
Version **dev (8.x-1.x)**. Core `^10.4 || ^11`. Requires contrib **GraphQL 3.x** + a configured
GraphQL server (`/admin/config/graphql`).

**Not an SSTI surface:** the Twig + query are **developer-authored theme templates**, not user
input. The security boundary is the **GraphQL schema's own access control** — a template can only
fetch what the schema exposes to the current user. Design schema field access deliberately.