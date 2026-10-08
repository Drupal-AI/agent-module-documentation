# Configure Drimage

Two layers: **global settings** at `/admin/config/media/drimage`, and **per-field formatter
settings** on each entity's *Manage display* tab.

## Global settings — `drimage.settings` (route `drimage.settings`, perm `administer image styles`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `threshold` | int | `200` | Minimum pixel difference between two generated styles; the requested width must land on a multiple of this (above `upscale`). Larger = fewer styles. |
| `ratio_distortion` | int | `60` | Max allowed ratio distortion (in 1/60 rad units) for reusing a near-matching style instead of creating a new one. |
| `upscale` | int | `320` | Minimum generated style width. Requests below this are rejected (fallback used). |
| `downscale` | int | `3840` | Maximum generated style width. Requests above this are rejected (fallback used). |
| `multiplier` | bool | `1` | Enable device-pixel-ratio detection (retina/HiDPI) in the JS. |
| `lazy_offset` | int | `100` | Lazy-loader offset in px before the element enters the viewport. |
| `core_webp` | bool | `false` | Add a core GD `image_convert`→webp effect to generated styles. |
| `imageapi_optimize_webp` | bool | `false` | Serve WebP through the `imageapi_optimize_webp` pipeline instead. |
| `automated_crop` | string | `''` | `automated_crop` provider id to use for crops (when the module is present). |
| `fallback_style` | string | `''` | Image style delivered when dimensions are invalid or generation fails. |
| `cache_max_age` | int | `0` | Browser cache max-age for delivered derivatives; `0` = `must-revalidate, no-cache, private`. |
| `legacy_lazyload` | bool | (hidden) | Use drimage's own JS lazyloader instead of native lazy loading. Only shown if already on. |

Only `width` is validated against `upscale`/`downscale`/`threshold` in
`DrImageController::checkRequestedDimensions()`.

## Per-field formatter settings (`drimage` / `drimage_uri`)

Set the formatter on *Manage display*; it extends core `ImageFormatter` (so it keeps
image-link + loading-attribute options) but **removes the image-style select** — drimage computes
the style itself. Schema: `field.formatter.settings.drimage`.

| Setting | Options / type | Meaning |
|---|---|---|
| `image_handling` | `scale` \| `aspect_ratio` \| `background` \| `iwc` | How the image is fit. `iwc` only appears if `image_widget_crop` is enabled. |
| `aspect_ratio` | `{width:1-100, height:1-100}` | Target ratio when `image_handling = aspect_ratio` (default 1×1). |
| `background` | `{attachment: scroll\|fixed, position, size}` | CSS background rules when `image_handling = background`. |
| `iwc.image_style` | string | Crop-type style when `image_handling = iwc`. |
| `image_link` / `image_loading.attribute` | inherited from core `ImageFormatter` | Link target and native `loading` attribute. |

### Set the formatter with Drush

```php
// drush php:eval
$fd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$fd->setComponent('field_image', [
  'type' => 'drimage',
  'region' => 'content',
  'settings' => ['image_handling' => 'aspect_ratio', 'aspect_ratio' => ['width' => 16, 'height' => 9]],
])->save();
```

## Notes
- Generated styles are named `drimage_<w>_<h>` (`drimage_focal_*` with `focal_point`,
  `drimage_<w>_<h>_<croptype>` with `image_widget_crop`). Do not create these by hand.
- On config import and on relevant module install/uninstall, drimage prunes its auto-generated
  styles (`drimage_*`) so they regenerate cleanly.
- To wipe all generated styles use Drush (`drimage:delete-styles`) — see [../drush/commands.md](../drush/commands.md).
