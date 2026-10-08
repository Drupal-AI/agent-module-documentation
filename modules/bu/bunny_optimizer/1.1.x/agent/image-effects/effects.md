<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Effects & toolkit operations (parameter mapping)

Every effect/operation ultimately calls `setParameter($key, $value)` on `BunnyOptimizerToolkit`;
those params become the derivative URL's query string (see `image-toolkit/toolkit.md`). Add them to
image styles at *Configuration > Media > Image styles*. Source: `src/Plugin/ImageEffect/*` and
`src/Plugin/ImageToolkit/Operation/*`.

## Generic operation

- `BunnyOptimizerParam` (id `bunny_optimizer_param`, operation `bunny_optimizer_param`) — takes
  `key` + `value`, calls `setParameter($key, $value)`. Every effect below is a thin wrapper that
  invokes `$image->apply('bunny_optimizer_param', ...)`.

## Toolkit operations backing core effects

These are `ImageToolkitOperationBase` plugins (toolkit `bunny_optimizer`) that Drupal core's stock
effects (Resize, Scale, Crop, Convert, Desaturate, Scale-and-crop) route through when the toolkit is
active. They translate arguments to Bunny query params; no bytes are processed.

| Operation | id | Sets params |
|-----------|----|-------------|
| Resize | `bunny_optimizer_resize` | `width`, `height` (cast to positive ints, else `InvalidArgumentException`) |
| Scale | `bunny_optimizer_scale` | width/height (positive-int validation) |
| Crop | `bunny_optimizer_crop` | crop width/height (positive-int validation) |
| Scale and crop | `bunny_optimizer_scale_and_crop` | applies `resize` (scaleWidth/scaleHeight) then `crop` |
| Convert | `bunny_optimizer_convert` | **no-op** — format handled on the CDN (WebP only) |
| Desaturate | `bunny_optimizer_desaturate` | desaturate param |

`ConvertImageEffect` (extends core) and `ScaleAndCropImageEffect` are swapped in for the core
effect classes by `bunny_optimizer_image_effect_info_alter()` while the toolkit is default. The
Convert effect disables the extension field and warns that only CDN-side WebP conversion is possible.

## Bunny-specific image effects

Each is an `ImageEffect` whose `applyEffect()` sets the named query parameter. Configurable ones
extend `ConfigurableImageEffectBase` and store the value in the effect config; `getSummary()`
renders that value on the image-style admin listing.

| Effect | id | Query key | Value / form |
|--------|----|-----------|--------------|
| Automatically optimize | `bunny_optimizer_auto_optimize` | `auto_optimize` | radios low/medium/high (cast to int on submit) |
| Blur | `bunny_optimizer_blur` | `blur` | configurable |
| Brightness | `bunny_optimizer_brightness` | `brightness` | configurable |
| Contrast | `bunny_optimizer_contrast` | `contrast` | configurable |
| Hue | `bunny_optimizer_hue` | `hue` | configurable |
| Saturation | `bunny_optimizer_saturation` | `saturation` | configurable |
| Sepia | `bunny_optimizer_sepia` | `sepia` | configurable |
| Sharpen | `bunny_optimizer_sharpen` | `sharpen` | configurable |
| Quality | `bunny_optimizer_quality` | `quality` | configurable |
| Flip (vertical) | `bunny_optimizer_flip` | `flip` | fixed |
| Flop (horizontal) | `bunny_optimizer_flop` | `flop` | fixed |
| Smart Face Crop | `face_crop` | `face_crop` = `true` | non-configurable (`ImageEffectBase`) |

## Image classes — `BunnyOptimizerClassImageEffect` (id `bunny_optimizer_class`)

*"Apply a Bunny Optimizer image class"* — sets the query param `class` to a preset name you have
configured in Bunny Optimizer (`buildConfigurationForm()` requires a `class` textfield). An image
class replaces a whole set of parameters with one, so the effect **must be used alone**: the form
warns (a `status_messages` warning) when the style already has other effects. `getSummary()` shows
the class name.

## Behavior notes

- Effects run in style order inside `BunnyOptimizerImageStyle::buildUrl()`, each appending params;
  the final URL is `…/path?width=…&height=…&quality=…` (or `?class=…` alone).
- Operations only validate that width/height are positive integers; other values are passed to the
  CDN as-is via `http_build_query()` (URL-encoded).
- Values shown on the admin summary come from effect configuration set by users with *administer
  image styles*; they are not derived from any request or remote input.
