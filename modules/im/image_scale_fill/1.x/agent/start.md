<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image Scale and Fill Background Effect (image_scale_fill) — agent index

One configurable **image-style effect** that scales the source into a fixed WxH canvas without
cropping the subject and fills the surrounding margins with a tiled copy, a blurred copy, the
dominant color, or a gradient. Package `Media`. Depends only on core **`image`**. GD toolkit only.
Core requirement `^10.3 || ^11 || ^12`. License GPL-2.0-or-later. Installed dir label **1.x**
(packaged 1.1.0).

- **The effect: plugin, every setting, config schema, how to add it, mechanics** →
  [plugins/scale_and_fill_background.md](plugins/scale_and_fill_background.md)

## What it actually is

- One plugin: `ScaleFillBackgroundEffect` (id **`scale_and_fill_background`**, label *"Scale and
  fill background"*), in `src/Plugin/ImageEffect/ScaleFillBackgroundEffect.php`, extending core
  `ConfigurableImageEffectBase` and declared with the `#[ImageEffect(...)]` attribute.
- One component helper: `GdGaussianBlur` (`src/Component/GdGaussianBlur.php`), a standalone
  pure-PHP GD Gaussian-blur utility adapted from the Image Effects module (kept in-tree to avoid a
  heavy dependency).
- **No** routes, permissions, services, hooks (only `hook_help`), fields, entities, Drush, or
  submodules. Configuration is per effect instance inside the image-style config entity.
- Provides config schema: `config/schema/image_scale_fill.schema.yml`
  (`image.effect.scale_and_fill_background`, marked `FullyValidatable`).
- Two `hook_post_update_N` functions in `image_scale_fill.post_update.php` re-cast numeric settings
  and add `transparent_handling` to styles created by 1.0.0.

## How to operate it

- Administered entirely through core's **Image styles** UI (`/admin/config/media/image-styles`,
  permission **`administer image styles`**). No settings route of its own (`configure` = null).
- Add the *Scale and fill background* effect to an image style, set **Width/Height** (the exact
  output size), pick a **Background type** (`tiled` / `scaled` / `dominant_color`), and for
  tiled/scaled optionally a **Background style** (`blurred` or colored overlay). Transparent-source
  images (logos) get a separate plain fill via **Transparent source handling**.

## Safety / bounds (from source)

- GD-only; falls back gracefully (logs an error, returns FALSE) on a non-GD toolkit.
- Canvas bounded to 10000 px/side and 40,000,000 px total; blur bounded by a fixed work budget;
  every numeric setting clamped to its range at apply time — imported/oversized config cannot
  exhaust memory/CPU. Hex colors are regex-validated with a white fallback.
- No shell-out, no external binary (pure GD), no file paths from untrusted input, no external
  network calls, no user-facing routes.

## Mechanism (from source)

- `applyEffect()`: allocates a true-color canvas (`getCanvasDimensions()`), paints the background
  by type, then centers the scaled source over it (`placeCenterImage()`), and swaps the toolkit
  image. `transformDimensions()` reports the fixed canvas size without loading the source.
  `getSummary()` renders the whole config on the styles list. See the plugin doc for per-method
  detail.
