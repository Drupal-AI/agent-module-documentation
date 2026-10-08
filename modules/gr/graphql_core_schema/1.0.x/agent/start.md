# Graphql Core Schema — agent index

Auto-generates a configurable GraphQL schema (`core_composable`) from Drupal entities/fields, on top of
the contrib **GraphQL** module (required). Pick entity types, fields, and schema extensions per GraphQL
Server. Successor to `graphql_core`. No config route of its own (configure via the GraphQL server form),
no permissions of its own, no Drush.

- **Create a server, select the schema, enable entity types / fields / extensions / views; the
  `schema_configuration` structure** → [configure/schema-server.md](configure/schema-server.md)
- **Access & resolution model (does a low-priv client leak data?) — how field/entity access is
  enforced** → [api/access-and-resolvers.md](api/access-and-resolvers.md)
- **Bundled schema extensions and the included sub-modules (what each adds)** →
  [extend/extensions-and-submodules.md](extend/extensions-and-submodules.md)
- **Write your own schema extension / alter the generated entity-field schema** →
  [extend/custom-extensions.md](extend/custom-extensions.md)

Key facts:
- Schema plugin `core_composable` (`Plugin/GraphQL/Schema/CoreComposableSchema`, extends
  `ComposableSchema`). Config schema `graphql.schema.core_composable` (opaque `core_composable` map).
- Server config lives on the GraphQL `Server` entity `schema_configuration.core_composable`
  (enabled_entity_types, fields, entity_base_fields, extensions, extension_views.enabled_views).
- Resolution: `CoreComposableResolver` — default resolver enforces `->access('view')` on entities/field
  items; `entity_query` producer uses `->accessCheck(TRUE)`. Access is opt-in-safe by default (neutral
  → not resolved).
- Sub-modules (14; documented at README level here, not as separate dirs): graphql_debugging,
  graphql_environment_indicator, graphql_file_url, graphql_form_schema, graphql_masquerade_schema,
  graphql_media_oembed_schema, graphql_messenger, graphql_metatag_schema,
  graphql_metatag_schema_org_schema, graphql_rokka_schema, graphql_security,
  graphql_tablefield_schema, graphql_telephone, graphql_translatable_config_pages.
