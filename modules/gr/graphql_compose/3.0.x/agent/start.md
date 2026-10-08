# GraphQL Compose — agent index

No-code GraphQL schema builder for Drupal. It ships a GraphQL **server**
(`graphql_compose_server`, endpoint `/graphql`, schema plugin `graphql_compose`) and a
per-server **settings config object** that records which entity bundles/fields are exposed.
Three custom plugin managers (EntityType, FieldType, SchemaType) turn that config into a
GraphQL schema. Extend it by enabling submodules (each nested under this project).

- **Enable/inspect exposed types & fields, global settings, config keys, admin routes** →
  [configure/schema.md](configure/schema.md)
- **The three GraphQL Compose plugin types (EntityType / FieldType / SchemaType), attributes, how to add one; plus DataProducer & SchemaExtension** →
  [plugins/plugin-types.md](plugins/plugin-types.md)
- **Alter hooks in `graphql_compose.api.php` (custom types, field enable/results, interfaces, translation, inflection)** →
  [hooks/hooks.md](hooks/hooks.md)
- **Services: the three plugin managers, EntityTypeWrapper, LanguageInflector, ComposeConfig/Context/Providers** →
  [api/services.md](api/services.md)

Key facts:
- Config name: `graphql_compose.settings.<server_id>` (default `graphql_compose.settings.graphql_compose_server`).
- Enable a bundle: `entity_config.<entity_type>.<bundle>.enabled: true` (+ `query_load_enabled` for a load-by-UUID query).
- Enable a field: `field_config.<entity_type>.<bundle>.<field>.enabled: true`.
- Global toggles under `settings.*` (e.g. `exclude_unpublished`, `expose_entity_ids`, `simple_queries`, `simple_unions`, `site_name`).
- Enabled submodules register in the server's `schema_configuration.graphql_compose.providers`.
- No `configure` route, no permissions.yml, no Drush.
