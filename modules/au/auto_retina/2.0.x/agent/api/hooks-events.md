<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Auto Retina — integration hooks, events & entity classes

## Alter hooks (declared in `auto_retina.api.php`)
- `hook_auto_retina_create_derivative_alter(array &$style, &$source, &$destination)` — fires from
  `Entity\RetinaImageStyle::createDerivative()` (via `moduleHandler()->alter('auto_retina_create_derivative', …)`)
  before core builds any derivative. Auto Retina's own implementation
  (`auto_retina_auto_retina_create_derivative_alter()`) checks the destination is a retina path and then, for
  each style effect, dispatches `auto_retina_effect_<pluginId>_alter` and `auto_retina_effect_alter`.
- `hook_auto_retina_effect_alter(&$effect, $retina_info, $context)` — the module's own
  `auto_retina_auto_retina_effect_alter()` recomputes width/height for the magnification, forces
  `upscale = TRUE`, calls `AutoRetina::optimizeImageSize()`, and (when suboptimum) dispatches
  `LowQualityRetinaEvent` and optionally logs.
- `hook_auto_retina_effect_EFFECT_NAME_alter(&$effect, $context)` — per effect-plugin variant of the above.
- `hook_auto_retina_image_style_deliver_alter(array &$headers, $uri, $original_image_uri, array $style)` —
  fires once, when a derivative is first created and delivered, to alter the HTTP response headers.

## Event
- Class `Event\LowQualityRetinaEvent`, constant `Event\AutoRetinaEvents::LOW_QUALITY_RETINA`
  = `'auto_retina.low_quality_retina'`. Dispatched when a retina derivative can't reach optimum pixel
  width. Getters: `getSourceWidth()`, `getOptimumWidth()`, `getSubQuality()` (0–1), `getSourceUri()`,
  `getImageStyle()`, `getConfig()`. Subscribe via a normal `event_subscriber` service to react (e.g. queue
  a re-upload request) independently of the `log` setting.

## Entity class override
`auto_retina_entity_type_alter()` swaps the `image_style` entity class:
- default → `Entity\RetinaImageStyle` (applies quality multiplier, then `parent::createDerivative()`).
- if `imageapi_optimize` is enabled → `Entity\RetinaImageStyleWithPipeline` (same, plus runs the
  configured Image Optimize pipeline over the generated derivative). `auto_retina_module_implements_alter()`
  reorders this hook last so imageapi_optimize doesn't win the class swap.

## Other hooks (`auto_retina.module`)
- `auto_retina_preprocess_html()` — when `auto_retina.settings:js` is true, attaches
  `drupalSettings.autoRetina` (suffix + delimiter-trimmed regex) for front-end scripts.
- `auto_retina_crop_update($entity)` — on Crop entity save, if `crop.settings:flush_derivative_images` is
  set, flushes every configured-magnification retina URI (`image_path_flush`) for the cropped file.

## Service quick reference
`auto_retina.core` = `Service\AutoRetina`. Useful for other modules building retina URLs:
`getRetinaUri($uri, $magnification)`, `getMagnifications()`, `isPathRetina($path)`.
