# GraphQL Compose: Blocks — agent index

Adds Drupal blocks (custom Block Content entities + rendered block plugins) to the GraphQL
Compose schema. Depends on `graphql_compose` + `block_content`. No settings form of its own;
you enable block content bundles through the GraphQL Compose schema config.

- **Expose a block content bundle, the schema types it adds, the union alter hook** →
  [configure/blocks.md](configure/blocks.md)

Key facts:
- Enable a block bundle: `entity_config.block_content.<bundle>.enabled: true` in
  `graphql_compose.settings.graphql_compose_server`.
- SchemaTypes: `BlockInterface`, `BlockContent`, `BlockPlugin`, `BlockUnion`; FieldType `BlockField`.
- DataProducers: `BlockLoad`, `BlockContentEntityLoad`, `BlockPluginId`, `BlockPluginLabel`, `BlockRender`.
- Extend the union with `hook_graphql_compose_blocks_union_alter($value, ?string &$type)`.
