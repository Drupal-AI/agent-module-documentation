# JSON:API field enhancer: image_styles

The module implements a **jsonapi_extras** `ResourceFieldEnhancer` plugin (it does not define a
new plugin type). Class `Drupal\consumer_image_styles\Plugin\jsonapi\FieldEnhancer\ImageStyles`.

```
@ResourceFieldEnhancer(
  id = "image_styles",
  label = "Image Styles (Image field)",
  description = "Adds links for images with image styles applied to them."
)
```

Attach it to a specific **image field** on a JSON:API resource via jsonapi_extras
(`/admin/config/services/jsonapi/resource_types` → edit resource → the image field → enhancer
= "Image Styles (Image field)"). This adds the derivative links to just that field's image
data, scoped by the negotiated consumer's styles (same links as the response normalizer, but
per-field).

## Configuration (schema `jsonapi_extras.enhancer_plugin.image_styles`)

```yaml
styles:
  refine: true|false                 # limit to a custom selection instead of the consumer's full set
  custom_selection:                  # image_style ids to expose when refine is true
    - thumbnail
    - large
```

- `refine: false` (default) → expose the consumer's configured styles.
- `refine: true` + `custom_selection: [...]` → expose only those image styles for this field.

Use the field enhancer when different image fields should offer different derivative sets;
otherwise the response normalizer (see [../api/provider.md](../api/provider.md)) already covers
all image files for the consumer.
