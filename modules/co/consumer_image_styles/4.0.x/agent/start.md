# Consumer Image Styles — agent index

Bridges **Consumers** + **JSON:API**: a consumer declares which image styles it needs, and the
module adds derivative (image-style) links to image files in that consumer's JSON:API output.
Requires `image`, `consumers`, `jsonapi`. No admin settings page of its own.

- **Attach image styles to a consumer (the `image_styles` field) & config** →
  [configure/attach-styles.md](configure/attach-styles.md)
- **The provider service (`loadStyles`, `buildDerivativeLink`) & normalizer** →
  [api/provider.md](api/provider.md)
- **The `image_styles` JSON:API field enhancer plugin (via jsonapi_extras)** →
  [plugins/field-enhancer.md](plugins/field-enhancer.md)

Key facts: adds base field **`image_styles`** (entity_reference → `image_style`, unlimited) to
the `consumer` entity (`consumer_image_styles_entity_base_field_info()`). Provider service
`consumer_image_styles.image_styles_provider`. Derivative link rel is
`ImageStylesProvider::DERIVATIVE_LINK_REL`. The enhancer plugin id is `image_styles`.
