# On-the-fly image route & DrimageManager

## Route
`drimage_improved.image` → `/drimage/{width}/{height}/{fid}/{iwc_id}/{format}`,
`_permission: 'access content'` (near-anonymous on most sites). The JS
(`js/drimage_improved.js`) measures the placeholder, quantises the size to the
`upscale`/`downscale`/`threshold` grid, and builds this URL. `iwc_id` is `-` when
image_widget_crop is not used; `format` may be `webp`.

`DrImageController` extends core `ImageStyleDownloadController` and just calls
`DrimageManager::image()`.

## `DrimageManager` flow (`src/DrimageManager.php`)
`image($request, $width, $height, $fid, $iwc_id, $format)`:
1. Load `File::load($fid)`; 404 if missing/invalid image.
2. `checkRequestedDimensions($width, $height)` — validates against config: width must be an int,
   `upscale <= width <= downscale`, and (unless width == downscale) `(width - upscale) % threshold == 0`.
   **On failure it only sets `$error_msg`; it does not stop processing.**
3. Resolve `iwc_id` (`-` → NULL; must be an existing `crop_type` and image_widget_crop enabled).
4. `findImageStyle([$width,$height], $iwc_id)` — tries `ImageStyle::load('drimage_improved_<w>_<h>')`;
   if none, tries to reuse a same-width style within `ratio_distortion`; otherwise
   `createDrimageStyle()` **creates and saves a new ImageStyle config entity** (retried up to 10×).
5. If `$error_msg` was set, swap in `fallback_style` **only if one is configured** (default is empty).
6. Simulate the derivative token (drimage doesn't use `itok`; it self-signs via
   `$image_style->getPathToken()` unless `allow_insecure_derivatives` is on) and `deliver()` the file,
   else return a 500 with the error message.

`createDrimageStyle()` builds the style: optional `image_convert`→webp effect, optional
`crop_crop` (image_widget_crop), then `image_scale` (width only) or `image_scale_and_crop` /
`focal_point_scale_and_crop` (width+height), invokes `hook_drimage_improved_image_style_alter`,
and saves.

## Programmatic use
Service `drimage_improved.manager` (`DrimageManagerInterface`). Also
`drimage_improved.image_style_repository` (`ImageStyleRepository`) — `deleteAll()` /
`deleteByCropType()` for cleanup (used by the Drush command and `ConfigSubscriber`).
