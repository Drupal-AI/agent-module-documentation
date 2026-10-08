<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image effect: Auto Rotate Lite (`auto_rotate_lite`)

Single plugin: `Drupal\auto_rotate_lite\Plugin\ImageEffect\AutoRotateLiteImageEffect`
(`src/Plugin/ImageEffect/AutoRotateLiteImageEffect.php`). Extends `ImageEffectBase`,
implements `ImageEffectInterface`, declared with the `#[ImageEffect(id: "auto_rotate_lite", ...)]`
attribute. It has **no configuration** — no `defaultConfiguration()` / `buildConfigurationForm()`,
so adding it to a style shows no options.

## Install / enable
```
composer require drupal/auto_rotate_lite   # or drop into modules/contrib
drush en auto_rotate_lite -y
```
Enabling core `image` is a hard dependency (it supplies the ImageEffect plugin type). No config,
schema, or restart needed. Requires the PHP `exif` extension for any effect; without it the plugin
is a no-op.

## Add it to an image style
UI: Configuration > Media > Image styles (`/admin/config/media/image-styles`) > edit a style >
"Add" > choose **Auto Rotate Lite** > Add effect. Put it before scale/crop effects so downstream
effects see the corrected orientation. Then use that style on any image/media field or responsive
image mapping. Config export lands under `image.style.<name>.yml` with an effect entry whose `id`
is `auto_rotate_lite` and empty `data`.

## Behavior (`applyEffect(ImageInterface $image)`)
1. Runs only if `function_exists('exif_read_data')` AND `$image->getMimeType()` is `image/jpeg` or
   `image/tiff`; otherwise returns TRUE unchanged.
2. Reads EXIF `Orientation` via `getImageOrientation($path)` where `$path = $image->getSource()`.
3. Maps orientation → rotation degrees: `3 → 180`, `6 → 90`, `8 → 270` (values 1/2/4/5/7 → 0, no
   rotation).
4. If `degrees > 0`, calls `$image->rotate($degrees)` (GD toolkit). On failure it logs an error to
   the module's logger channel (`%toolkit`, `%path`, `%mimetype`, `%dimensions`) and returns FALSE.
5. Runs during **derivative generation only** — the original source file is never rewritten.

## Dimension handling (`transformDimensions(array &$dimensions, $uri)`)
Casts width/height to int. If both are known and EXIF is available, reads orientation and, for
values `5,6,7,8` (90/270-type rotations), **swaps** width and height so the style reports correct
derivative dimensions. If dimensions are unknown, sets both to NULL. This runs without loading the
image, so responsive/`<img>` sizing is correct even before the derivative exists.

## `getImageOrientation($uri)` — path resolution
- No stream scheme → `\Drupal::service('file_system')->realpath($uri)`.
- Has scheme → `stream_wrapper_manager->getViaUri($uri)->realpath()`, falling back to the wrapper's
  `getExternalUrl()` when there is no local real path.
- Returns NULL if the path is empty or `exif_read_data` is missing.
- Calls `@exif_read_data($path)` (errors suppressed) and returns `$file_exif['Orientation']` when
  present, else NULL.

## Notes / gotchas
- JPEG/TIFF only — PNG/WebP/GIF carry no EXIF orientation and are skipped.
- Depends on GD toolkit `rotate()`; other toolkits work only if they implement rotate.
- Silent no-op when the `exif` extension is not compiled into PHP — verify with
  `php -m | grep exif` if rotation seems ignored.
- Order matters in the style: place before crop/scale so those effects act on the corrected image.
