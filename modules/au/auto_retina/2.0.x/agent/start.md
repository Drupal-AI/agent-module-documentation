<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Auto Retina (auto_retina) — agent index

On-demand high-magnification (retina/2x) derivatives for **any** core image style. A visitor appends a
configured suffix (default `@2x`, before the extension) to a signed image-style URL and the module
regenerates that style scaled by the multiplier, capped at the source image's native width.

- **Version dir:** 2.0.x (installed 2.0.3). Core `^9 || ^10 || ^11`, PHP 8.1.
- **Depends on:** core `image`. Optional: `image_style_quality`, `imageapi_optimize`, `crop`.
- **Provides:** no permissions, no entities of its own, no plugin types, no Drush.
- **Config:** `auto_retina.settings` (schema provided); settings form route `auto_retina.admin_settings`
  at `/admin/config/media/image-styles/auto-retina` (permission `administer image styles`).

## How it works (source map)

- `src/Routing/RouteSubscriber.php` — swaps the `_controller` of core routes `image.style_public` and
  `image.style_private` to the module's controller.
- `src/Controller/RetinaImageStyleDownloadController.php` — extends core
  `ImageStyleDownloadController`; `deliver()` detects retina paths, validates the core `itok` derivative
  token with `hash_equals`, then generates and streams the enlarged derivative. Non-retina paths fall
  through to `parent::deliver()`.
- `src/Service/AutoRetina.php` (service `auto_retina.core`) — path parsing/regex, suffix↔multiplier math,
  and `optimizeImageSize()` (upscale-cap logic).
- `src/Entity/RetinaImageStyle.php` — `image_style` entity class override; `createDerivative()` applies the
  quality multiplier. `src/Entity/RetinaImageStyleWithPipeline.php` — variant used when `imageapi_optimize`
  is enabled. Class swap done in `auto_retina_entity_type_alter()` (`auto_retina.module`).
- `auto_retina.module` — hooks: `preprocess_html` (JS settings), effect-alter math, `crop` derivative
  flush. `src/Event/*` — `LowQualityRetinaEvent` on `auto_retina.low_quality_retina`.
- `auto_retina.api.php` — alter hooks for integrators.

## Solution docs

- [Configuration & settings](config/settings.md) — config keys, schema, suffix/regex/quality, JS + logging.
- [Retina delivery pipeline](api/delivery.md) — routes, controller flow, token, suffix math, upscale cap.
- [Integration hooks & events](api/hooks-events.md) — alter hooks, `LowQualityRetinaEvent`, entity classes.
