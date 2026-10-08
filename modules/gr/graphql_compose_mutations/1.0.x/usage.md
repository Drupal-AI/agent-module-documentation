<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GraphQL Compose: Mutations enables mutations for any entity in the schema.

---

GraphQL Compose: Mutations **enables create/update/delete mutations for entities in the GraphQL schema** — so
a decoupled client can write entities (not just read them) through GraphQL Compose. It depends on the GraphQL and
GraphQL Compose modules.

Use it to allow entity writes via GraphQL. It is a **web-services/write** feature, and its access model needs care.
What it does right: the mutation resolver **checks entity-level access** (`userCanDoActionOnEntityByType` for the
create/update/delete operation) and returns a violation if denied — so a user can't mutate an entity type they lack
access to. Two gaps to compensate for: (1) it sets the mutation's input values with `$entity->set($field, $value)`
**without a per-field edit-access check**, so any field exposed as mutable in the schema can be written by anyone
with entity access — regardless of field-level access controls (e.g. Field Permissions) on that field; and (2) it
**skips entity validation** (a `@todo` before `save()`), so field constraints/validation aren't enforced on
mutation. Mitigations: **only expose fields/bundles as mutable that are safe for the role that can mutate them**,
don't rely on field-level access for GraphQL-exposed fields, and **lock down the GraphQL endpoint** (authentication,
persisted queries, disable arbitrary queries in production). Configure the exposed mutations carefully.

---

- Enable entity create/update/delete mutations.
- Let decoupled clients write entities.
- Extend the GraphQL Compose schema.
- Depend on GraphQL + GraphQL Compose.
- Serve web-services/write.
- Expose mutations.
- CHECK entity-level access before mutating (returns a violation if denied).
- Set exposed input fields via $entity->set() WITHOUT per-field access checks.
- SKIP entity validation before save() (a @todo).
- Only expose fields/bundles safe for the mutating role (don't rely on field-level access).
- LOCK DOWN the GraphQL endpoint (auth, persisted queries, no arbitrary queries in prod).
- Configure the exposed mutations carefully.
- Handle GraphQL mutations.
- Mutate entities.
- Configure the mutations.
- Write entities.
- Handle the schema.
- Create/update/delete via API.
- Restrict exposed fields.
- Provide entity mutations.
