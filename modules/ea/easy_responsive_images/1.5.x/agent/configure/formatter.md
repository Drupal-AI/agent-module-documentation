<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Easy Responsive Images field formatter

Plugin id **`easy_responsive_images`** (class `EasyResponsiveImagesFormatter extends`
core `ImageFormatter`, for `image` field types). Set it on an image field in *Manage display*
(`core.entity_view_display.<entity>.<bundle>.<view_mode>` → component `type:
easy_responsive_images`).

## Settings (`defaultSettings`)

| Setting | Values | Meaning |
|---|---|---|
| `image_handling` | `scale` \| `aspect_ratio` | Scale = flexible height keeping ratio; aspect_ratio = crop to a chosen ratio. `aspect_ratio` is only offered when aspect-ratio styles exist. |
| `aspect_ratio` | e.g. `16_9` | Which generated aspect ratio to use (only for `image_handling = aspect_ratio`). |
| `multiplier` | `1x`, `1.25x`, `1.5x`, `2x`, `3x`, `4x` | Load a larger derivative for higher quality / DPI. |
| `cover` | boolean | Also use container **height** to pick the best image (for `object-fit`). |

The formatter does **not** use a single image style — it emits `#src` (smallest derivative) and
`#srcset` (all matching `responsive_*` derivatives) via the `easy_responsive_images.manager`
service, themed by `easy_responsive_images_formatter` (renders `<img src>` + `data-srcset`).
The `easy_responsive_images/resizer` JS then loads the best derivative for the real container
width (and height when `cover` is on). Output is cached per `headers:accept` + `route.name`
so WebP/Avif negotiation works.

## Example (Drush)

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_image', [
  'type' => 'easy_responsive_images',
  'label' => 'hidden',
  'settings' => ['image_handling' => 'scale', 'multiplier' => '1.5x', 'cover' => FALSE],
])->save();
```

> Requires the `responsive_*` image styles to have been generated first (see
> [generate.md](generate.md)); for `aspect_ratio` handling the chosen ratio's styles must exist.
