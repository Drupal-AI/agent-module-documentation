<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GraphQL Compose Configs — agent index

**Exposes selected Drupal configuration through GraphQL** (via GraphQL Compose). Depends on `graphql_compose`.
Provides permissions. Version **1.0.0-alpha2**. Core `^10.2||^11`.

Decoupled — **config can contain sensitive values** (API keys/credentials): **only expose non-sensitive config**,
review surfaced keys, configure GraphQL endpoint access (don't expose secrets to anonymous). No access role of
its own beyond permission + GraphQL access.
