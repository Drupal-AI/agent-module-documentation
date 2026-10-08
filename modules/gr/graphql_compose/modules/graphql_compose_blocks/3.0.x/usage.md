GraphQL Compose: Blocks adds Drupal blocks to the GraphQL Compose schema — both custom Block Content entities and rendered block plugins — exposing them as GraphQL types you can query.

---

This submodule extends GraphQL Compose so that blocks become part of the generated schema. It registers a `BlockContent` EntityType plugin (making custom block content bundles selectable in the GraphQL Compose schema config, `entity_config.block_content.<bundle>.enabled`), a `BlockField` FieldType plugin (for the `block_field` field type), and several SchemaType plugins: `BlockInterface`, `BlockContent`, `BlockPlugin` and a `BlockUnion` that lets a query return whichever concrete block type applies. Its `BlocksSchemaExtension` wires resolvers, and DataProducer plugins (`BlockLoad`, `BlockContentEntityLoad`, `BlockPluginId`, `BlockPluginLabel`, `BlockRender`) resolve block ids, labels and rendered markup. A `hook_graphql_compose_blocks_union_alter($value, &$type)` lets you map custom block classes into the `BlockUnion`. Requires `block_content`. Depends on `graphql_compose`; it has no settings form of its own — you enable individual block content bundles through the GraphQL Compose schema UI/config like any other entity type.

---

- Expose custom Block Content entities (e.g. "Basic block", promo blocks) to a decoupled front end.
- Query a block's rendered HTML output via the `BlockRender` producer.
- Return mixed block results through the `BlockUnion` type and resolve each to its concrete type.
- Add a specific block content bundle to the schema by enabling `entity_config.block_content.<bundle>.enabled`.
- Expose reusable/"library" blocks so a headless site can place them in its own layout.
- Query block plugin id and label for a placed block.
- Surface `block_field` field values (a referenced block plugin) through the `BlockField` field type.
- Let a front end render Drupal-authored marketing blocks without duplicating content.
- Map a custom block plugin class into `BlockUnion` via `hook_graphql_compose_blocks_union_alter()`.
- Provide a `BlockInterface` so clients can request common block fields polymorphically.
- Combine with GraphQL Compose Layout Builder to resolve field blocks inside sections.
- Expose editor-managed call-to-action blocks to a mobile app.
- Query block content fields (body, image, links) as structured GraphQL data.
- Keep block editing in Drupal while consuming it through GraphQL.
- Enable only the block content bundles a given front end needs, keeping the schema lean.
- Serve hero/banner blocks to a Next.js/Nuxt site as typed data.
- Resolve a block's UUID for stable client-side references.
- Drive a component library where each Drupal block maps to a front-end component.
- Expose FAQ/notice blocks reused across many pages.
- Return a null-safe block union when a block type isn't exposed.
- Support A/B or campaign blocks authored in Drupal and rendered by the client.
