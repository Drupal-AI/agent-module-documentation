# Configuration

## Global settings — `/admin/config/media/drimage_improved`
Route `drimage_improved.settings` (`_permission: 'administer image styles'`), form
`DrimageSettingsForm`, config object `drimage_improved.settings`. Defaults from
`config/install/drimage_improved.settings.yml`:

| Key | Default | Meaning |
|---|---|---|
| `threshold` | 200 | Min px width difference between two generated styles (fewer styles = less disk). |
| `ratio_distortion` | 60 | Max aspect-ratio distortion (arc-minutes) allowed to reuse an existing style. |
| `upscale` | 320 | Minimum generated image-style width (also the JS floor). |
| `downscale` | 3840 | Maximum generated image-style width (the JS ceiling). |
| `multiplier` | 1 | Device-pixel-ratio detection multiplier. |
| `lazy_offset` | 100 | Lazyloader offset in px. |
| `core_webp` | true | Convert derivatives to WebP via core toolkit. |
| `imageapi_optimize_webp` | false | Use imageapi_optimize_webp for WebP instead. |
| `automated_crop` | '' | automated_crop provider id (with image_widget_crop). |
| `fallback_style` | '' | Image style used when generation fails / dimensions invalid. |
| `cache_max_age` | 0 | Cache max-age for delivered images. |
| `placeholder_color` | '#ffffff' | Solid placeholder colour. |
| `placeholder_image_switch` | false | Use an image placeholder instead of a colour. |
| `placeholder_image` | '' | Placeholder image path. |
| `legacy_lazyload` | null | Use the drimage JS lazyloader. |

Schema: `config/schema/drimage_improved.schema.yml`.

## Field formatter — "Dynamic Responsive Image"
`DrImageFormatter` (id `drimage_improved`, field type `image`), extends core `ImageFormatter`.
Set it on an image field's *Manage display*. It **removes** the core `image_style` select (drimage
computes the style) and adds an `image_handling` radio:
- `scale` — scale to width, keep aspect ratio (height passed as 0).
- `aspect_ratio` — fixed aspect-ratio crop (`aspect_ratio.width` / `.height`).
- `background` — CSS background image (`attachment`, `position`, `size`).
- `container_size` — size to the container.
- `iwc` — image_widget_crop crop type (only shown when `image_widget_crop` is enabled).

A `DrImageUriFormatter` variant outputs the derivative URI.

## Optional integrations
`focal_point` (focal-aware crop styles, `drimage_improved_focal_*`), `image_widget_crop` (named
crop types via the `iwc_id` route arg), `automated_crop`, `imageapi_optimize_webp`,
`stage_file_proxy` (handled by an event subscriber). `hook_library_info_alter` is not used here —
assets ship in `drimage_improved.libraries.yml`.
