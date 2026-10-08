<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Crop or Fill (crop_or_fill) — agent index

**Image-style effect: crop when the image and the crop's target ratio share an orientation, or pillarbox the image onto a solid-color canvas when they differ (no content lost).**

- **Version:** 1.0.x  **Core:** `^10.3 || ^11`  **License:** GPL-2.0-or-later
- **Depends:** `crop:crop` (Crop API, `drupal/crop:^2 || ^3`). Optional: `drupal/imagemagick` for the ImageMagick toolkit path.
- **Provides:** no routes, permissions, services, hooks, config/install, or update hooks.

## Plugins
- **Image effect** `crop_or_fill` — `CropOrFillEffect` extends Crop's `CropEffect`
  (`src/Plugin/ImageEffect/CropOrFillEffect.php`); adds a `bgcolor` setting (default `#ffffff`).
- **Toolkit operation** `pillarbox` for `gd` (`crop_or_fill_gd_pillarbox`) and `imagemagick`
  (`crop_or_fill_imagemagick_pillarbox`), sharing `PillarboxTrait`
  (`src/Plugin/ImageToolkit/Operation/**`).

## Behavior
Free-form/no ratio or matching orientation (including a square image or square crop) →
delegates to the parent standard crop. Opposite orientation → `applyPillarbox()` composes the
image, centered, onto a background-colored canvas matching the target aspect ratio.

## Config
Added per image style at *Configuration → Media → Image styles*. Settings: **Crop type**
(inherited) and **Background color** (`bgcolor`). Schema `image.effect.crop_or_fill` extends
`image.effect.crop_crop` (`config/schema/crop_or_fill.schema.yml`).

## Solution docs
- [effects/crop-or-fill.md](effects/crop-or-fill.md) — the effect plugin, decision flow, geometry
  helpers, GD/ImageMagick `pillarbox` operations, config schema, and orientation matrix.
