# Drimage route, controller & hooks

## Route `drimage.image`

```
path: /drimage/{width}/{height}/{fid}/{iwc_id}/{format}
controller: \Drupal\drimage\Controller\DrImageController::image
permission: access content
requirements: width \d+  height \d+  fid \d+  iwc_id [a-z0-9_-]+  format [a-zA-Z0-9_]+
```

The URL the JS actually requests appends the source file path after `{format}`
(`.../{iwc_id}/sites/default/files/foo.jpg`). `PathProcessorImageStyles` (inbound path processor,
priority 299) strips that trailing path into request query params and derives `format` from the
file extension, leaving the 5 route params. This lets the optional `htaccess.prepend.txt` rewrite
serve an already-generated derivative directly from disk (302) without bootstrapping Drupal.

## `DrImageController::image()` flow

1. `File::load($fid)` — 404 if missing/invalid image.
2. `checkRequestedDimensions($width, $height)` — validates **width** only: rejects unless
   `upscale ≤ width ≤ downscale` and `((width - upscale) % threshold == 0)` (or width == downscale).
   On failure it sets an error and later uses `fallback_style`.
3. `iwc_id == '-'` means "no crop"; otherwise requires `image_widget_crop` + a matching `crop_type`.
4. `findImageStyle()` — exact match `drimage_<w>_<h>`; else (height > 0) reuse a same-width style
   within `ratio_distortion`; else `createDrimageStyle()` (retried up to 10× under contention).
5. `createDrimageStyle()` — builds an `ImageStyle` config entity with effects: optional
   webp `image_convert`, optional `crop_crop` (iwc), then `image_scale` (no height) or
   `image_scale_and_crop` / `focal_point_scale_and_crop` (with height); fires
   `hook_drimage_image_style_alter`; `->save()`.
6. Delivery via core `ImageStyleDownloadController::deliver()`. Drimage does not put `itok` in URLs;
   unless `image.settings:allow_insecure_derivatives` is on, it recomputes the derivative token
   server-side (`$image_style->getPathToken()`). Private-scheme file access still runs through core's
   deliver logic.
7. WebP: when `format == 'webp'` and webp is enabled, returns the `.webp` derivative
   (`BinaryFileResponse`) if it exists, else a 500. `cache_max_age` sets the response cache headers.

## Style naming (`getDrimageId`)
- default: `drimage_<w>_<h>`
- with `focal_point`: `drimage_focal_<w>_<h>`
- with `image_widget_crop` + valid crop type: `drimage_<w>_<h>_<iwc_id>`

## Alter hooks (`drimage.api.php`)

```php
// Alter each generated image style before it is saved.
function hook_drimage_image_style_alter(\Drupal\image\Entity\ImageStyle &$style) { … }

// Alter the selectable proxy cache periods.
function hook_drimage_proxy_cache_periods_alter(array &$periods) { $periods[] = 32400; }
```

## Maintenance behavior
- `ImageStyleRepository::deleteAll()` / `deleteByCropType()` remove `drimage_*` styles (used by the
  Drush command and by config-import / module install-uninstall cleanup hooks in `drimage.module`).
- `hook_theme` provides the `drimage_formatter` template (`templates/drimage-formatter.html.twig`).
