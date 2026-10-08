# Expose image styles

No dedicated settings form. Enable image styles through the GraphQL Compose schema config;
each enabled style becomes a value of the `ImageStyleAvailable` enum and can be requested via
the `Image.variations` field.

## Enable an image style

Config object `graphql_compose.settings.graphql_compose_server`:

```bash
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("graphql_compose.settings.graphql_compose_server");
  $c->set("entity_config.image_style.thumbnail.enabled", TRUE);
  $c->save();
'
drush cget graphql_compose.settings.graphql_compose_server entity_config.image_style.thumbnail
```

`image_style` is a config-entity type, so the GraphQL Compose schema form lists your image
styles (thumbnail, large, medium, custom crops, …). Tick a style's *Enable GraphQL* to add it.

## Query shape it enables

```graphql
{
  node { ... on Article { image { variations(styles: [THUMBNAIL, LARGE]) { url width height } } } }
}
```

## What it adds

- EntityType `ImageStyle` (config entity).
- SchemaTypes: `ImageStyleAvailable` (GraphQL enum of enabled styles), `ImageStyleDerivative`
  (url/width/height of a derivative).
- `ImageStyleSchemaExtension` adds `variations(styles: [ImageStyleAvailable])` to the `Image`
  type; the `ImageDerivatives` DataProducer resolves the requested derivatives.
