# GraphQL Compose: ECK — agent index

Makes ECK (Entity Construction Kit) entities available in the GraphQL Compose schema — one
GraphQL type per ECK entity type. Depends on `graphql_compose` + `eck`. No settings form, no
GraphQL types of its own; it reuses the parent module's machinery.

- **How ECK types are derived and exposed; the provider registration** →
  [configure/eck.md](configure/eck.md)

Key facts:
- Single EntityType plugin `eck` with `EckEntityTypeDeriver` → derives a GraphQL entity type per
  ECK entity type.
- Enable an ECK bundle like any type: `entity_config.<eck_entity_type>.<bundle>.enabled: true`.
- Enabling the submodule registers it as a provider:
  `schema_configuration.graphql_compose.providers.graphql_compose_eck` on the GraphQL server.
