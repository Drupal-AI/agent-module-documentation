<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The four retina image effects

## Install & enable

```bash
composer require drupal/retina_images
drush en retina_images -y
drush cr
```

Only dependency is core **`image`**. No sub-modules, no Drush commands, no configuration form of
its own.

## How the effects are installed into core

`retina_images_image_effect_info_alter(&$effects)` (in `retina_images.module`) does **not** define
new plugins — it swaps the `class` of core's existing effect definitions, keeping their plugin IDs:

| Plugin ID | New class (all in `src/Plugin/ImageEffect/`) | Core parent |
|---|---|---|
| `image_resize` | `RetinaResizeImageEffect` | `ResizeImageEffect` |
| `image_scale` | `RetinaScaleImageEffect` | `ScaleImageEffect` |
| `image_scale_and_crop` | `RetinaScaleAndCropImageEffect` | `ScaleAndCropImageEffect` |
| `image_crop` | `RetinaCropImageEffect` | `CropImageEffect` |

Because the IDs are unchanged, **every existing image style that uses these effects automatically
gets the extra options** — nothing to re-add.

## Shared behaviour — `RetinaImageEffectTrait`

`src/RetinaImageEffectTrait.php` is `use`d by all four classes and supplies:

- `defaultConfiguration()` → adds `retinafy => FALSE` and `multiplier => 2` on top of the parent's.
- `$defaultMultiplier = 2` and `getMultiplier()` (returns `configuration['multiplier']`, else 2).
- `multiplyDimension($dimension, $multiplier = NULL)` — **the core logic**: if
  `configuration['retinafy']` is truthy, returns `(int) ($dimension * $multiplier)` (multiplier
  defaulting to `getMultiplier()`); otherwise returns `(int) $dimension` unchanged.
- `buildConfigurationForm()` / `prepareForm()` — adds two form elements:
  - `retinafy` — checkbox "Retinafy".
  - `retina_multiplier` — number field "Resolution multiplier", `#min => 1`, shown only when
    Retinafy is checked (`#states` visible). Its `#default_value` is `configuration['multiplier']`.
- `validateConfigurationForm()` — if Retinafy is on and `retina_multiplier` is **not numeric**, sets
  a form error ("Multiplier must be a valid number, such as '2' or '1.5'"). Non-integer multipliers
  like `1.5` are allowed; `multiplyDimension()` casts the product to int.
- `submitConfigurationForm()` — stores `retinafy` and copies `retina_multiplier` into
  `configuration['multiplier']`.

## What each `applyEffect()` does

Each subclass overrides `applyEffect(ImageInterface $image)` to call the same core toolkit method as
its parent, but feeds width/height through `multiplyDimension()`:

- `RetinaResizeImageEffect` → `$image->resize(multiplyDimension(width), multiplyDimension(height))`.
- `RetinaScaleImageEffect` → `$image->scale(multiplyDimension(width), multiplyDimension(height), $configuration['upscale'])`.
- `RetinaScaleAndCropImageEffect` → `$image->scaleAndCrop(multiplyDimension(width), multiplyDimension(height))`.
- `RetinaCropImageEffect` → resolves the anchor with `image_filter_keyword($x/$y, …)` against the
  **original** width/height, then `$image->crop($x, $y, multiplyDimension(width), multiplyDimension(height))`.

On toolkit failure each logs via `$this->logger->error(...)` (channel `image`) and returns `FALSE`.
When `retinafy` is off, `multiplyDimension()` is a no-op, so the effect behaves exactly like core.

## Summaries (`getSummary()`) + theme hooks

Each effect's `getSummary()` prepends a themed summary and merges the parent's. `hook_theme()`
registers `retina_images_image_crop_summary`, `_image_resize_summary`, `_image_scale_summary` (and
`_image_style_preview`). Templates in `templates/` (`retina-images-image-*-summary.html.twig`)
append "(retinafied)" to the effect summary when `data.retinafy` is set; the scale template also
shows "(upscaling allowed)". (Note: `RetinaScaleAndCropImageEffect::getSummary()` reuses the
`retina_images_image_resize_summary` theme.)

## Configuring it

UI: **Structure → Media → Image styles** → edit or add a style → add/edit one of the four effects →
tick **Retinafy** and optionally set **Resolution multiplier** → save. Maintainer tip: allow
upscaling and set the image quality to ~25 to offset the larger 2x file.

Config example (effect `data` inside an `image.style.*` config entity, as shipped in
`config/optional/*.yml`):

```yaml
effects:
  <uuid>:
    uuid: <uuid>
    id: image_scale
    weight: 0
    data:
      width: 220
      height: 220
      upscale: false
      retinafy: true
      # multiplier: 2   # optional; defaults to 2 when omitted
```
