# Expose blocks in the schema

There is no dedicated settings form. Enable block content bundles the same way as any other
entity type in GraphQL Compose.

## Enable a block content bundle

Config object `graphql_compose.settings.graphql_compose_server`:

```bash
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("graphql_compose.settings.graphql_compose_server");
  $c->set("entity_config.block_content.basic.enabled", TRUE);
  $c->save();
'
drush cget graphql_compose.settings.graphql_compose_server entity_config.block_content.basic
```

In the UI: the GraphQL server's *GraphQL Compose → Schema* tab lists a **Block content** entity
type; tick a bundle's *Enable GraphQL*.

## What it adds to the schema

- SchemaType plugins: `BlockInterface` (common block fields), `BlockContent` (custom block
  entities), `BlockPlugin` (placed plugin blocks), and `BlockUnion` (return the right concrete type).
- FieldType `BlockField` — resolves a `block_field` field (a referenced block plugin).
- `BlocksSchemaExtension` registers the resolvers; DataProducers resolve id/label/render:
  `BlockLoad`, `BlockContentEntityLoad`, `BlockPluginId`, `BlockPluginLabel`, `BlockRender`.

## Resolve custom block classes into the union

```php
/** Implements hook_graphql_compose_blocks_union_alter(). */
function mymodule_graphql_compose_blocks_union_alter($value, ?string &$type): void {
  if ($value instanceof \Drupal\layout_builder\Plugin\Block\FieldBlock) {
    $type = 'BlockField';
  }
}
```

`$value` is the block being resolved; set `$type` to the GraphQL type name to use.
