GraphQL Compose: Image Styles extends the schema's `Image` type with a `variations` field so clients can request derivative images (URL/width/height) for the Drupal image styles you expose.

---

This submodule adds Drupal image styles to the GraphQL Compose schema. It registers an `ImageStyle` EntityType plugin (so image style config entities become selectable via `entity_config.image_style.<style>.enabled`), and SchemaType plugins `ImageStyleAvailable` (a GraphQL **enum** of the enabled image styles) and `ImageStyleDerivative` (a derivative's url/width/height). Its `ImageStyleSchemaExtension` adds a `variations(styles: [ImageStyleAvailable])` resolver to the `Image` type, backed by the `ImageDerivatives` DataProducer, which returns the requested style derivatives for an image field. Requires core `image`. Enabling an image style in the GraphQL Compose config adds it to the `ImageStyleAvailable` enum so a client may request that derivative; there is no settings form of its own.

---

- Request a thumbnail/large/etc. derivative of an image field via `image { variations(styles: [THUMBNAIL]) { url width height } }`.
- Expose only the image styles a front end needs by enabling them (`entity_config.image_style.<style>.enabled`).
- Serve responsive images to a decoupled client with multiple named derivatives.
- Provide derivative URLs, widths and heights for `<img srcset>` generation client-side.
- Keep image processing/cropping in Drupal while consuming derivatives over GraphQL.
- Add a new derivative to the API simply by enabling another image style.
- Drive art-directed/responsive images in Next.js/Nuxt from Drupal image styles.
- Return the original image plus several style variations in one query.
- Limit the exposed `ImageStyleAvailable` enum to approved styles for a lean schema.
- Generate WebP/optimized derivatives in Drupal and expose their URLs.
- Support retina/2x variants by exposing higher-resolution styles.
- Feed a media gallery with multiple thumbnail sizes.
- Avoid shipping full-size images to mobile clients by exposing smaller styles.
- Combine with the Media/Node types to resolve image fields with variations.
- Expose crop-based styles (focal point/manual crop) as derivatives.
- Provide consistent image dimensions to the client for layout stability.
- Let editors add a new image style and instantly make it queryable.
- Return null-safe derivatives when a style can't be generated.
- Standardize image sizes across a headless component library.
- Reduce front-end image-processing work by using Drupal-generated derivatives.
