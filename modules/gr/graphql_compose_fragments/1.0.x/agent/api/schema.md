<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GraphQL API — the `info { fragments }` query

Only active when `graphql_compose.settings:settings.fragments_enabled` is **TRUE** (set via the
admin form, see [../configure/fragments.md](../configure/fragments.md)). Off by default; when
off, none of the types/fields below are added to the schema.

## Query shape

The module extends GraphQL Compose's `SchemaInformation` type (reachable through the schema's
top-level `info` query) with a `fragments` field:

```graphql
query {
  info {
    fragments {
      type
      name
      class
      content
      entity
      bundle
      dependencies
    }
  }
}
```

### Arguments on `fragments`

- `entity: String` — return only fragments for that GraphQL Compose entity type plugin id.
- `bundle: String` — return only fragments for that bundle.
- `withDependencies: Boolean` — when true, transitively add every fragment referenced in a
  returned fragment's `dependencies` (recursive walk in the DataProducer). Useful with
  `entity`/`bundle` so the filtered set is self-contained.

With no arguments, **all** fragments are returned; `entity`+`bundle` narrows to one bundle,
either alone narrows accordingly.

## `SchemaFragment` type

Defined by `Plugin/GraphQLCompose/SchemaType/SchemaFragment.php` (id `SchemaFragment`), added
only when fragments are enabled:

| Field | Type | Meaning |
|-------|------|---------|
| `type` | `String!` | The schema type name the fragment is on (e.g. `NodePage`). |
| `name` | `String!` | The fragment name (prefix `Fragment` + type, e.g. `FragmentNodePage`). |
| `class` | `String!` | The PHP `::class` of the underlying `graphql-php` type (ObjectType/UnionType). |
| `content` | `String` | The full fragment definition string. |
| `entity` | `String` | Entity type plugin id, if the type maps to one. |
| `bundle` | `String` | Bundle id, if the type maps to one. |
| `dependencies` | `[String]` | Names of fragments this one spreads. |

## Resolution wiring

- `Plugin/GraphQL/SchemaExtension/FragmentsSchemaExtension.php`
  (`@SchemaExtension id="graphql_compose_fragments"`, `schema="graphql_compose"`, `@internal`)
  registers the resolvers — but **returns early if `fragments_enabled` is false**, so the field
  resolves nothing unless enabled. It maps `SchemaInformation.fragments` to the
  `schema_fragments` DataProducer and wires each `SchemaFragment` field to the corresponding
  array key (`class` resolves `$type::class`).
- `Plugin/GraphQL/DataProducer/SchemaFragments.php` (`@DataProducer id="schema_fragments"`)
  builds all fragments via `FragmentManager`, applies the `entity`/`bundle` filters, and — when
  `withDependencies` — recursively pulls dependency fragments into the result set.

## Access / disclosure note

The `fragments` payload is derived entirely from the schema shape (type and field names), which
is already reachable through standard GraphQL introspection on the same endpoint. It exposes no
content or user data, and it is opt-in and off by default. Access follows the GraphQL Compose
endpoint's own permissions — this module adds no access control of its own.
