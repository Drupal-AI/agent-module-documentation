<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Auto Retina — retina delivery pipeline

## Route takeover
`Routing\RouteSubscriber::alterRoutes()` reassigns the `_controller` of core's `image.style_public` and
`image.style_private` routes to
`\Drupal\auto_retina\Controller\RetinaImageStyleDownloadController::deliver`. Access requirements,
paths and the `image_style` / `scheme` parameters are core's; only the controller changes. Auto Retina
defines **no** delivery route of its own.

## Requesting a retina image
Take a working, signed image-style derivative URL and insert a configured suffix before the extension:

```
/sites/default/files/styles/thumbnail/public/photo.jpg?itok=<token>       ← base derivative
/sites/default/files/styles/thumbnail/public/photo@2x.jpg?itok=<token>    ← 2x retina (same itok)
```

## Controller flow — `RetinaImageStyleDownloadController::deliver()`
Extends core `ImageStyleDownloadController`. `$target = $request->query->get('file')`.
1. `autoRetina->isPathRetina($target)` — if the filename has no configured suffix, delegate straight to
   `parent::deliver()` (core behaviour, unchanged).
2. `autoRetina->prepareStyle($image_style, $target)` — stamps `suffix` / `multiplier` /
   `quality_multiplier` third-party settings onto the style and returns `$original_target` (the base,
   non-retina path). Builds `$image_uri` (retina) and `$original_image_uri` (base) from `$scheme`.
3. **Token check:** validates the core image-derivative token with
   `hash_equals($image_style->getPathToken($original_image_uri), $request->query->get(IMAGE_DERIVATIVE_TOKEN))`.
   The token is computed against the **base** URI, which is why the base derivative's `itok` also authorises
   its `@2x` sibling. Skipped only when `image.settings:allow_insecure_derivatives` is true and the path is
   not under `styles/` — same policy as core. Failure → `NotFoundHttpException` (404, not 403, for DDoS/cache
   reasons).
4. **Private scheme:** invokes `hook_file_download`; a `-1` or empty result → `AccessDeniedHttpException`.
5. **Source resolution:** if `$original_image_uri` is missing, retries after stripping an extension
   (handles style-converted names like `image.png.jpeg`); logs and returns a 404 if still absent.
6. **Generate under lock:** acquires `image_style_deliver:<id>:<hash>`; if held →
   `ServiceUnavailableHttpException(3)`. Calls `$image_style->createDerivative($original_image_uri,
   $derivative_uri)` unless the derivative already exists.
7. **Deliver:** builds a `BinaryFileResponse` with Content-Type/Length, firing
   `hook_auto_retina_image_style_deliver_alter` on the headers; on failure logs and returns 500.

## Magnification / upscale math
- `Service\AutoRetina::optimizeImageSize($effect_width, $effect_height, $magnification, $source_width)`
  computes the retina target width, then caps it: if the standard derivative was upscaled, or the source is
  narrower than `magnification × effect_width`, the width is capped at the source width. It returns
  `optimum_width`, `is_suboptimum` and `percent_of_optimum` — the basis for low-quality logging.
- The per-effect recalculation runs in `auto_retina_auto_retina_effect_alter()` (see hooks doc), always
  setting `upscale = TRUE` and clamping to the optimized width. So a retina derivative is at most the
  source image's real width — never fabricated detail.

## Quality
`Entity\RetinaImageStyle::createDerivative()` applies `quality_multiplier`: if the style has an
`image_style_quality` effect it scales that effect's `quality`; otherwise it overrides
`imagemagick.settings:quality` or `system.image.gd:jpeg_quality` for this generation only.
