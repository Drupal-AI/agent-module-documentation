# Single media thumbnail formatter

One field formatter. Class
`Drupal\single_image_formatter_media\Plugin\Field\FieldFormatter\SingleMediaFormatter`.

| Property | Value |
|---|---|
| Plugin id | `single_media_formatter` |
| Label | "Single media thumbnail" |
| Field type | `entity_reference` (media reference field) |
| Extends (core) | `Drupal\media\Plugin\Field\FieldFormatter\MediaThumbnailFormatter` |
| Requires module | `media` (core) |
| Config schema | `field.formatter.settings.single_media_formatter` → maps to `field.formatter.settings.media_thumbnail` |

## What it changes

The class adds a single override:

```php
protected function getEntitiesToView(EntityReferenceFieldItemListInterface $items, $langcode) {
  $files = parent::getEntitiesToView($items, $langcode);
  $file = reset($files);
  return $file ? [$file] : [];
}
```

`parent::getEntitiesToView()` resolves and access-filters the referenced media entities; this keeps
only the first. Everything else — the settings form, thumbnail build, image style, link handling,
cache metadata — is core `MediaThumbnailFormatter`, unchanged. Field cardinality and stored values are
untouched; only the number rendered changes (one). See the parent's
[configure/formatters.md](../../../../../2.0.x/agent/configure/formatters.md) for the shared
single-image pattern across the three family formatters.

## Settings

Inherited from `MediaThumbnailFormatter` with no additions: `image_style` (image style applied to the
thumbnail) and `image_link` (link the thumbnail to nothing / content / the media entity). Set them via
the Manage-display formatter cog or in `settings` when configuring via config.

## Select it (UI)

Structure → (entity type / bundle) → **Manage display** (for the target view mode) → set the media
reference field's Format to **Single media thumbnail**, then use the cog to set image style / link.

## Set it via config

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.teaser');
$vd->setComponent('field_media', [
  'type' => 'single_media_formatter',
  'label' => 'hidden',
  'settings' => ['image_style' => 'medium', 'image_link' => 'content'],
])->save();
```
