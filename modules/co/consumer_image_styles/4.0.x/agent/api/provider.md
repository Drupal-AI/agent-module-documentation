# Provider service & response normalizer

## Service: consumer_image_styles.image_styles_provider

`Drupal\consumer_image_styles\ImageStylesProvider` (implements `ImageStylesProviderInterface`),
args: `@entity_type.manager`, `@image.factory`, `@file_url_generator`, `@stream_wrapper_manager`.

- `loadStyles(Consumer $consumer): ImageStyleInterface[]` — loads the image styles referenced by
  the consumer's `image_styles` field.
- `buildDerivativeLink($uri, ImageStyleInterface $image_style, ?CacheableMetadata $cm = null): array`
  — returns a JSON:API link array: `href` (absolute derivative URL via
  `$image_style->buildUrl($uri)`), `title`, `rel`/`meta.rel` = `DERIVATIVE_LINK_REL`, and for
  local images `meta.width`/`meta.height` (dimensions transformed by the style) + `type`
  (mime). For remote/non-local streams it skips dimension inspection. Pass `$cacheable_metadata`
  (required from 5.0.0).
- `entityIsImage(EntityInterface $entity): bool` — true if the entity is a `File` that is an image.

## Normalizer decorator

`serializer.normalizer.link_collection.consumer_image_styles`
(`Drupal\consumer_image_styles\Normalizer\LinkCollectionNormalizer`) **decorates**
`serializer.normalizer.link_collection.jsonapi` (priority 1025, format `api_json`). Using the
`consumer.negotiator` to identify the requesting consumer, for image file resources it appends
one derivative link per style from `loadStyles()` to the resource's link collection. If no
consumer is negotiated (`MissingConsumer`), it falls through to the inner normalizer unchanged.

So the end-to-end flow: request identifies a consumer → its `image_styles` are loaded → each
image `File` in the response gains derivative links (URL + dimensions) the client can use for
`srcset`/responsive rendering.
