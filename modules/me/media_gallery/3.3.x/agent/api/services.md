<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services, utilities, hooks, and the Pathauto alias type

## Services (`media_gallery.services.yml`)

| Service | Class | Purpose |
|---|---|---|
| `media_gallery.layout_manager` | `MediaGalleryLayoutManager` | Plugin manager for `MediaGalleryLayout` layouts. See [plugins/layouts.md](../plugins/layouts.md). |
| `media_gallery.item_renderer` | `MediaGalleryItemRenderer` | Renders a single media item (thumbnail + PhotoSwipe link) into a consistent render array; injected into every layout plugin. |

Create a layout instance in code:

```php
$plugin = \Drupal::service('media_gallery.layout_manager')
  ->createInstance('grid', ['grid_columns' => 4, 'thumbnail_image_style' => 'thumbnail', 'photoswipe_image_style' => '']);
$render = $plugin->build($mediaEntities);
```

## Utilities (`MediaGalleryUtilities`, all static)

| Method | Does |
|---|---|
| `getImageDimensionsForGallery(MediaGallery $g): array` | `[width, height]` from the gallery's thumbnail image style (fallback 300x180) |
| `getDimensionsForImageStyle(string $name): array` | width/height from an image style's effects; throws if none |
| `paginateMediaGallery(array $items, int $perPage, bool $reverse): ?array` | slices the `images` field render array to the current pager page |
| `alterNonImageMediaRendering(array &$field): void` | swaps in video/oEmbed formatters for non-image media in a gallery |
| `getRenderArrayForNonImageMedia(MediaInterface $m, array $dims): array` | render array for one non-image media item |
| `getLayoutBuilderImagesField(array &$build): ?array&` | locates the gallery `images` field inside a Layout Builder build (by reference) |

## Alter hook

`hook_media_gallery_layout_info_alter(array &$definitions)` — add, remove, or modify layout
plugin definitions. This is the only alter hook the module invokes; there is no `.api.php` file.

## Pathauto alias type

`src/Plugin/pathauto/AliasType/MediaGalleryAliasType.php` registers an `@AliasType` plugin
(id `media_gallery`, entity type `media_gallery`, provider `media_gallery`) extending
`EntityAliasTypeBase`. When the **pathauto** module is installed you can define URL alias patterns
for gallery entities (e.g. `gallery/[media_gallery:title]`). Pathauto itself is only a
`require-dev` dependency, so this plugin is inert until pathauto is enabled.

## Notes

- No Drush commands, no `drush.services.yml`.
- Both blocks read the field data table `media_gallery__images` (column `images_target_id`)
  directly for performance rather than running a reverse entity query.
