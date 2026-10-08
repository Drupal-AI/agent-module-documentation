# Drimage — agent index

Field formatter that generates image styles on the fly at the browser-measured width. JS
measures the element, requests `/drimage/{width}/{height}/{fid}/{iwc_id}/{format}`, and the
controller finds-or-creates an `ImageStyle` named `drimage_<w>_<h>` and delivers the derivative.
Depends on core `image`. Provides two formatters (`drimage`, `drimage_uri`), a config schema, a
Drush command, and two alter hooks. No permissions of its own.

- **Global settings (`/admin/config/media/drimage`) + the per-field formatter settings** →
  [configure/settings.md](configure/settings.md)
- **The `/drimage/...` route, controller flow, path processor, WebP/token handling, alter hooks** →
  [api/route.md](api/route.md)
- **Drush `drimage:delete-styles`** → [drush/commands.md](drush/commands.md)

Key facts:
- Formatters: `drimage` (image fields) and `drimage_uri`; select on *Manage display*. Handling modes:
  `scale`, `aspect_ratio`, `background`, `iwc` (Image Widget Crop).
- Route `drimage.image` → `DrImageController::image`, permission **`access content`** (regex:
  width/height/fid `\d+`, iwc_id `[a-z0-9_-]+`, format `[a-zA-Z0-9_]+`).
- Style names: `drimage_<w>_<h>`, `drimage_focal_<w>_<h>` (with focal_point), `drimage_<w>_<h>_<croptype>`.
- Global config `drimage.settings`: `threshold`, `upscale`, `downscale`, `ratio_distortion`,
  `multiplier`, `lazy_offset`, `core_webp`, `imageapi_optimize_webp`, `automated_crop`,
  `fallback_style`, `cache_max_age`, `legacy_lazyload`.
- Optional integrations: `focal_point`, `crop`/`image_widget_crop`, `automated_crop`,
  `imageapi_optimize_webp`. Optional Apache `.htaccess` rewrite (`htaccess.prepend.txt`) serves
  existing derivatives from disk.
