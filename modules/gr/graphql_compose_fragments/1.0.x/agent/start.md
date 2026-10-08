<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GraphQL Compose: Fragments (graphql_compose_fragments) — agent index

Add-on for **GraphQL Compose** that auto-generates a GraphQL **fragment** for every object
and union type in the composed schema. Version **1.0.2**. Core `^10.2 || ^11`, **PHP 8.1**.
Depends on `graphql_compose:graphql_compose` (Composer: `drupal/graphql_compose:^2 || ^3`).

**What it actually does** (do not overstate — it is not a file generator):
- The `FragmentManager` service walks every registered object/union type from GraphQL
  Compose's schema and builds a fragment string like `fragment FragmentNodePage on NodePage { … }`.
  Nested object/union fields become `...FragmentChildType` references; self-recursion is
  emitted as a `# Recursion` comment for you to resolve manually.
- **Admin form** at `/admin/config/graphql_compose/fragments` (route `graphql_compose.fragments`,
  permission `administer graphql configuration`) displays the fragments in collapsible code
  blocks (Union Types / Object Types) for **copy-paste**. Nothing is written to disk.
- **Optional schema exposure**: the form's "Enable fragments on schema" checkbox sets
  `graphql_compose.settings:settings.fragments_enabled` (off by default). When on, a
  `fragments` field is added to the `SchemaInformation` type so clients can query
  `info { fragments { type name class content entity bundle dependencies } }`.

**No** permissions.yml, **no** Drush commands, **no** routes of its own beyond the admin form.
It reuses GraphQL Compose's `administer graphql configuration` permission and inherits the
GraphQL endpoint's access model. Provides config schema only (one boolean key added via
`hook_config_schema_info_alter`).

- **Admin config form, the `fragments_enabled` toggle, how fragments are generated** →
  [configure/fragments.md](configure/fragments.md)
- **The `info { fragments }` query, its arguments, the `SchemaFragment` type and `schema_fragments` DataProducer** →
  [api/schema.md](api/schema.md)
