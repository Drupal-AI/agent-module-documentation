<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How the WebP fallback works (mechanism)

No plugins, no services beyond one factory. Everything hangs off a preprocess hook, a route override
and a few file-lifecycle hooks. Central service: `wpf.image_factory`
(`Drupal\wpf\ImageFactory`, implements `ImageFactoryInterface`).

## 1. Swap the fallback `<img>` URI — `hook_preprocess_responsive_image()`

```php
function wpf_preprocess_responsive_image(&$variables): void {
  $variables['img_element']['#uri'] =
    \Drupal::service('wpf.image_factory')->getJpg($variables['img_element']['#uri']);
}
```

`ImageFactory::getJpg()` rewrites a `.webp` derivative URL (or each URL in a `srcset`, comma-split) to
the corresponding `.jpg` URL via `setDestinationUri()` / `getProcessedJpgUrl()`. So the responsive
`<picture>`'s fallback `<img>` points at a JPEG while the WebP `<source>`s are untouched.

## 2. Generate the JPEG lazily — `RouteSubscriber`

`Drupal\wpf\Routing\RouteSubscriber` overrides the `_controller` of the core routes
`image.style_public` and `image.style_private` to
`Drupal\wpf\Controller\ImageStyleDownloadController::deliver`. When a browser actually **requests** the
`.jpg` derivative URL, that controller triggers `ImageFactory::createImageCopy()`:

- Resolves the toolkit (`system.image` toolkit; imagick falls back to GD in this version).
- With **GD**: `imagecreatefromwebp($webpUri)` then `imagejpeg($image, $destination, $quality)`.
- With **ImageMagick**: `apply('convert', ['extension' => 'jpg', 'quality' => $quality])`.

This is why JPEGs are only ever created for fallback URLs that are genuinely requested — never eagerly.

## 3. Respect disabled styles

`setDestinationUri()` extracts the image style from the URL (`/styles/<style>/`). If that style is in
`wpf.settings` `styles.disabled`, it leaves the URL unchanged (no `.jpg`, no generation).

## 4. Cleanup hooks

- `hook_file_delete()` → `ImageFactory::fileDelete()` deletes the fallback JPEG for every image style
  derivative of the deleted file.
- `hook_crop_insert()` / `hook_crop_update()` → `invalidateFallbackImagesByCrop()` deletes stale
  fallbacks for the cropped file so they regenerate.

## Config it reads

`wpf.settings.quality` (default 75) and `wpf.settings.styles.disabled` (array), both read in the
`ImageFactory` constructor.
