<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Retina Images (retina_images) — agent index

Adds a **"Retinafy"** option to core's image-style effects so a style outputs **high-resolution
(2x / Nx) derivatives** for high-DPI displays. Package `Image styles`. Depends only on core
**`image`**. Core requirement `^8.8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version
8.x-1.1 (version-dir `8.x-1.x`). No config form of its own, no Drush, no external dependencies.

- **The four image effects, the trait, config keys, form, and summary templates** →
  [plugins/image-effects.md](plugins/image-effects.md)
- **The example image styles, the preview route/permission/controller, and hooks** →
  [config/styles-and-preview.md](config/styles-and-preview.md)

## What it actually is

- `hook_image_effect_info_alter()` in `retina_images.module` **reassigns the `class`** of four
  core effect plugin definitions to Retina subclasses (the plugin IDs stay
  `image_resize` / `image_scale` / `image_scale_and_crop` / `image_crop`):
  - `RetinaResizeImageEffect` extends core `ResizeImageEffect`
  - `RetinaScaleImageEffect` extends core `ScaleImageEffect`
  - `RetinaScaleAndCropImageEffect` extends core `ScaleAndCropImageEffect`
  - `RetinaCropImageEffect` extends core `CropImageEffect`
  All four are in `src/Plugin/ImageEffect/` and `use RetinaImageEffectTrait`.
- The shared **`RetinaImageEffectTrait`** (`src/RetinaImageEffectTrait.php`) adds config keys
  `retinafy` (bool, default FALSE) and `multiplier` (default 2), the form fields, validation, and
  `multiplyDimension()` — which multiplies a dimension by the multiplier only when `retinafy` is on.
- **No new plugin type**, no field/entity types, no services. One permission, one route/controller,
  four theme hooks, three optional example image styles.

## Dependencies / provides

- Requires core module **`image`** only. `require: {}` in composer.json.
- **Permission** (`retina_images.permissions.yml`): `retina images access preview page`.
- **Route** (`retina_images.routing.yml`): `retina_images.image_style_preview` at
  `admin/config/media/image-styles/retina_preview/{image_style}` → `PreviewController::preview`.
- **hooks** in `.module`: `hook_help`, `hook_image_effect_info_alter`, `hook_theme`,
  `hook_form_image_style_form_alter`, plus `template_preprocess_retina_images_image_style_preview`.
- **No `config/schema/`** (so `retinafy`/`multiplier` effect keys are unschemed); ships
  `config/optional/` example styles only.

## Security posture (public)

Display/derivative-generation module. The preview route is permission-gated and operates only on
the **site-configured** `image.settings:preview_image` (not a request-supplied path); the multiplier
is validated numeric and cast to int. No external calls, no user-supplied markup, no SQL. Weigh the
**bandwidth/disk** cost of 2x derivatives; maintainers suggest lowering image-style quality.
