<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Single media / single rendered-entity formatters

Two field formatters in this submodule (namespace
`Drupal\single_image_formatter_media\Plugin\Field\FieldFormatter`).

## `single_media_formatter` — "Single media thumbnail"

Class `SingleMediaFormatter` extends core `MediaThumbnailFormatter`.

| Property | Value |
|---|---|
| Plugin id | `single_media_formatter` |
| Field type | `entity_reference` (media reference field) |
| Extends (core) | `Drupal\media\Plugin\Field\FieldFormatter\MediaThumbnailFormatter` |
| Requires module | `media` (core); `responsive_image` (core) only for the responsive option |
| Config schema | `field.formatter.settings.single_media_formatter` → extends `field.formatter.settings.media_thumbnail`, adds `responsive_image_style` (string) |

`getEntitiesToView()` calls the parent (which resolves and access-filters the referenced media
entities) and keeps only the first (`reset()`).

### Settings

Inherits the core thumbnail settings — `image_style`, `image_link` (nothing / content / media entity),
`image_loading` — and adds one:

- `responsive_image_style` (default `''`). The settings form lists only responsive image styles that
  have mappings; options are empty unless `responsive_image` is enabled.

When `responsive_image_style` is **empty**, `viewElements()` defers entirely to the parent (plain
thumbnail). When **set** (and `responsive_image` is enabled), `viewElements()` renders each media
item's original source image through that style using `#theme => 'responsive_image_formatter'` and a
`<picture>` element, merging the responsive/image-style cache tags; the source image is found via
`getSourceImageItem()` (the media source's `source_field`, which must be an `image` field). If a media
item has no renderable source image, it falls back to the core thumbnail build for that item. The
`image_link` ("Link image to") setting still applies. `calculateDependencies()` adds the selected
responsive image style as a config dependency.

## `single_entity_formatter` — "Single rendered entity"

Class `SingleEntityFormatter` extends core `EntityReferenceEntityFormatter`.

| Property | Value |
|---|---|
| Plugin id | `single_entity_formatter` |
| Field type | `entity_reference` |
| Extends (core) | `Drupal\Core\Field\Plugin\Field\FieldFormatter\EntityReferenceEntityFormatter` |
| Requires module | `media` (submodule dependency) |
| Config schema | `field.formatter.settings.single_entity_formatter` → reuses `field.formatter.settings.entity_reference_entity_view` |

Only override is `getEntitiesToView()` → keep the first referenced entity. All settings (`view_mode`,
`link`) and rendering are inherited unchanged from the core rendered-entity formatter.

Both formatters change only *how many* items render (one); field cardinality and stored values are
untouched. See the parent's
[configure/formatters.md](../../../../../2.1.x/agent/configure/formatters.md) for the whole family.

![Manage display formatter select showing the "Single media thumbnail" / "Single rendered entity" options](../../../../../../../../../screenshots/single_image_formatter_media/2.1.x/manage-display-formatter-select.png)

## Set it via config

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.teaser');
// Media thumbnail (optionally responsive via responsive_image_style):
$vd->setComponent('field_media', [
  'type' => 'single_media_formatter',
  'label' => 'hidden',
  'settings' => ['image_style' => 'medium', 'image_link' => 'content', 'responsive_image_style' => ''],
])->save();
// Or render only the first referenced entity:
$vd->setComponent('field_related', [
  'type' => 'single_entity_formatter',
  'label' => 'hidden',
  'settings' => ['view_mode' => 'teaser', 'link' => FALSE],
])->save();
```
