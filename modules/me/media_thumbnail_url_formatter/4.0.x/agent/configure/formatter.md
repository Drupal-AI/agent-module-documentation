# Configure the Thumbnail URL formatter

No global settings page (`configure` null). Choose the formatter on an entity's **Manage
display** tab (`admin/structure/…/display`) for a media/entity-reference field, then open the
formatter cog.

## The formatter

| Formatter id | Label | Applies to | Class |
|---|---|---|---|
| `media_thumbnail_url` | Thumbnail URL | `entity_reference` fields (media reference) | `MediaThumbnailURLFormatter extends Drupal\media\Plugin\Field\FieldFormatter\MediaThumbnailFormatter` |

## Settings

| Key | Type | Default | Meaning |
|---|---|---|---|
| `image_style` | string | `''` (inherited from parent) | Image style machine name to build the thumbnail URL through. Empty = original file URL. |
| `absolute` | bool | `''` (falsey) | On → keep the URL absolute. Off → pass through `FileUrlGenerator::transformRelative()` to a root-relative path. |

The parent formatter's **Link image to** (`image_link`) option is removed by
`settingsForm()`, and the settings summary shows only the image-style line plus "Absolute URL"
when enabled.

## Where settings are stored

```
core.entity_view_display.<entity_type>.<bundle>.<view_mode>:
  content:
    <field_name>:
      type: media_thumbnail_url
      settings:
        image_style: ''      # e.g. 'thumbnail', 'medium'
        absolute: false
```

Schema: `field.formatter.settings.media_thumbnail_url` (extends
`field.formatter.settings.media_thumbnail`, adding the `absolute` boolean).

## Output behavior (`viewElements()`)

For each referenced media item:
1. Loads the media's `thumbnail` file URI (`$media->get('thumbnail')->entity->getFileUri()`).
2. If an image style is set → `$image_style->buildUrl($uri)` (an absolute style URL);
   else → `FileUrlGenerator::generateAbsoluteString($uri)`.
3. If `absolute` is not truthy (`== 1`) → `FileUrlGenerator::transformRelative($url)`.
4. Emits `['#markup' => $url]` per delta — a plain URL string, no `<img>`, no link.

Cacheability: each media entity and the image style are added as cacheable dependencies.

## Set the formatter with Drush (example)

```php
$d = \Drupal::entityTypeManager()->getStorage('entity_view_display')
  ->load('node.article.default');
$d->setComponent('field_media', [
  'type' => 'media_thumbnail_url',
  'settings' => ['image_style' => 'medium', 'absolute' => TRUE],
  'label' => 'hidden',
])->save();
```
