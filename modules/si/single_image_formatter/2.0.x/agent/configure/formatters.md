# The single-image formatters

Each plugin extends a core formatter and overrides `getEntitiesToView()` to return only the first
delta (`$file = reset($files); return $file ? [$file] : [];`). Settings and schema are inherited from
the parent formatter unchanged.

| Formatter id | Provided by | Field type | Extends core | Enable module |
|---|---|---|---|---|
| `single_image_formatter` | single_image_formatter | `image` | `ImageFormatter` | image (core) |
| `single_responsive_image_formatter` | single_image_formatter_responsive | `image` | `ResponsiveImageFormatter` | responsive_image |
| `single_media_formatter` | single_image_formatter_media | `entity_reference` (media) | `MediaThumbnailFormatter` | media |

## Select it (UI)

Structure → (entity) → **Manage display** → set the field's Format to "Single image formatter"
(or "Single responsive image" / "Single media thumbnail"), then use the formatter cog to set the
inherited options (image/responsive style, link to content/file, etc.).

## Set it via config (example)

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.teaser');
$vd->setComponent('field_gallery', [
  'type' => 'single_image_formatter',
  'label' => 'hidden',
  'settings' => ['image_style' => 'medium', 'image_link' => 'content'],
])->save();
```

The formatter changes only *how many* items render (one); every other behavior is core's. Field
cardinality is untouched — all values remain stored and available to other view modes.
