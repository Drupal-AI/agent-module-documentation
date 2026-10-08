# GraphQL Compose: Mutations — manual setup guide

**GraphQL Compose: Mutations** (`graphql_compose_mutations`) adds **write**
capability to your GraphQL API. It extends
[GraphQL Compose](https://www.drupal.org/project/graphql_compose) with generic
**create, update and delete** mutations for any Drupal entity type, so a decoupled
client can write entities — not just read them — without you hand‑writing schema
extensions. Enabling the module exposes a `genericMutation` operation, for example:

```graphql
mutation createNode {
  genericMutation(
    data: {
      type: "node"
      bundle: "article"
      operation: CREATE
      values: { title: "Hello World", body: "Content here" }
    }
  ) {
    success
    errors
    entity { ... on NodeArticle { id title } }
  }
}
```

You can also query which operations and permissions apply
(`operationsByEntityType`, `permissions`), decorate the `UserPermissions` service
to customise permission logic, implement custom resolvers, and hook into the
standard Drupal entity events.

This is a **web‑services / write** feature, and its access model needs care.
Please read the security section below before exposing it — allowing writes over an
API is materially different from exposing read‑only data.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (GraphQL and GraphQL Compose required).

There is **no dedicated settings form**. Mutations are exposed by enabling the
module; what is writable is governed by which fields/bundles are mutable in your
GraphQL Compose schema, and by Drupal entity permissions. Read the security notes
below.

## Security — read before exposing mutations

The module gets one important thing right, but has two gaps you must compensate
for:

- **What it does right:** the mutation resolver **checks entity‑level access**
  before mutating. A user must hold the appropriate Drupal entity permission
  (`create {bundle} content`, `edit any {bundle} content`, `delete any {bundle}
  content`, etc.); if they don't, the mutation returns a violation rather than
  writing. These checks are enforced at the **data‑producer level**, not merely in
  the schema.
- **Gap 1 — no per‑field access check:** it sets each input value with
  `$entity->set($field, $value)` **without a per‑field edit‑access check**. So any
  field exposed as mutable in the schema can be written by anyone with entity
  access, **regardless of field‑level access controls** (such as Field Permissions)
  on that field.
- **Gap 2 — no entity validation:** it **skips entity validation** before
  `save()`, so field constraints and validation rules are not enforced on
  mutations.

Because of these gaps, protect yourself with three practices:

1. **Only expose fields and bundles as mutable that are safe for the role that can
   mutate them.** Do not rely on field‑level access to protect a GraphQL‑exposed
   field.
2. **Validate untrusted input yourself**, and consider adding extra validation
   layers for any public‑facing endpoint.
3. **Lock down the GraphQL endpoint** — require authentication, use persisted
   queries, and disable arbitrary queries in production.
