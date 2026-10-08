<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GraphQL Compose: Mutations — agent index

**Enables GraphQL create/update/delete mutations for entities**. Depends on `graphql`, `graphql_compose`. Version
**1.0.0**. Core `^10.1||^11`.

Web-services/write — **checks entity-level access** before mutating (good), but sets exposed input fields via
`$entity->set()` **without per-field access checks** and **skips entity validation**. So only expose fields/bundles
safe for the mutating role (don't rely on field-level access for exposed fields), and **lock down the GraphQL
endpoint** (auth, persisted queries).
