# GraphQL Compose: Image Styles — agent index

Extends the schema's `Image` type with a `variations(styles: [ImageStyleAvailable])` field that
returns Drupal image-style derivatives (url/width/height). Depends on `graphql_compose` + `image`.
No settings form of its own.

- **Expose an image style, the enum/derivative types, the variations resolver** →
  [configure/image-styles.md](configure/image-styles.md)

Key facts:
- Enable a style: `entity_config.image_style.<style>.enabled: true`
  (e.g. `entity_config.image_style.thumbnail.enabled`); this adds it to the `ImageStyleAvailable` enum.
- SchemaTypes: `ImageStyleAvailable` (enum), `ImageStyleDerivative`. DataProducer: `ImageDerivatives`.
- Extension adds `variations` to `Image`.
