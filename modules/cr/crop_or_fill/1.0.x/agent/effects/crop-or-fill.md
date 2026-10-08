<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Crop or Fill image effect

## Install / enable
`composer require drupal/crop_or_fill` then `drush en crop_or_fill`. Requires the
[Crop API](https://www.drupal.org/project/crop) module (`drupal/crop:^2 || ^3`). ImageMagick
(`drupal/imagemagick`) is optional (dev/runtime) and enables the ImageMagick toolkit path.
Core `^10.3 || ^11`. No routes, permissions, services, hooks, or update hooks.

## Adding the effect
UI: *Configuration → Media → Image styles* (`/admin/config/media/image-styles`) → edit a style →
add the **Crop or fill** effect. Two settings:
- **Crop type** — inherited from Crop API's manual crop effect; selects a `crop` crop type entity.
- **Background color** — HTML5 `#type => color` picker, key `bgcolor`, default `#ffffff`. Only used
  in the fill (opposite-orientation) case.

## The effect plugin
`CropOrFillEffect` (`src/Plugin/ImageEffect/CropOrFillEffect.php`), `@ImageEffect` id
`crop_or_fill`, **extends** `Drupal\crop\Plugin\ImageEffect\CropEffect`.
- `defaultConfiguration()` = parent + `bgcolor => '#ffffff'`.
- `buildConfigurationForm()` / `submitConfigurationForm()` add and persist `bgcolor`.
- `applyEffect(ImageInterface $image)` decision flow:
  1. `getCropTypeRatio()` loads the crop type via `$this->typeStorage`; if the crop type is
     missing or has no aspect ratio (free-form crop), it logs an error and returns NULL →
     delegate to `parent::applyEffect()` (standard crop).
  2. Otherwise `getCrop($image)` (inherited) then `resolveTargetDimensions()` computes the largest
     rectangle of that ratio fitting inside the image.
  3. `isSameOrientation()` — true when either side is square (`w == h`) or both are landscape /
     both portrait → delegate to `parent::applyEffect()` (standard crop).
  4. Opposite orientation → `applyPillarbox()`.
- `transformDimensions(array &$dimensions, $uri)` mirrors the same branching so the theme layer
  predicts derivative size: same-orientation → parent prediction; opposite → `computeCanvasDimensions()`.

### Geometry helpers (protected)
- `resolveTargetDimensions([$w,$h], $iw, $ih)` — `scale = min($iw/$w, $ih/$h)`; returns
  rounded `width`/`height`.
- `computeCanvasDimensions($iw,$ih,$cw,$ch)` — keeps the image's larger dimension and extends the
  shorter one to the target ratio (landscape image → keep width, grow height; else keep height,
  grow width).
- `applyPillarbox()` — calls `$image->apply('pillarbox', [...])` with `canvas_width`,
  `canvas_height`, centered `x_offset`/`y_offset` (`(canvas − image)/2`), and
  `background_color => bgcolor`.

## Toolkit operations (the `pillarbox` op)
Both register `operation: "pillarbox"` and share `PillarboxTrait`
(`src/Plugin/ImageToolkit/Operation/PillarboxTrait.php`), which declares args
`canvas_width`, `canvas_height`, `x_offset`, `y_offset`, `background_color` and validates them:
dimensions cast to int and must be `> 0` (else `\InvalidArgumentException`), color must pass
`Drupal\Component\Utility\Color::validateHex()`.
- **GD** — `...Operation/gd/Pillarbox.php` (`#[ImageToolkitOperation(id: "crop_or_fill_gd_pillarbox",
  toolkit: "gd")]`): `create_new` a temp canvas, `imagefill` with `Color::hexToRgb` background,
  `imagecopy` the original at the offsets. Returns FALSE (restoring the original) on failure.
- **ImageMagick** — `...Operation/imagemagick/Pillarbox.php`
  (`id: "crop_or_fill_imagemagick_pillarbox"`, `toolkit: "imagemagick"`): appends
  `-background <color> -gravity none -extent WxH+dx+dy` and sets the toolkit width/height.

## Config object & schema
No config/install ships. Per-style effect config lives inside the image style entity. Schema:
`config/schema/crop_or_fill.schema.yml` defines `image.effect.crop_or_fill` extending
`image.effect.crop_crop` and adds `bgcolor` (`type: color_hex`).

## Orientation matrix
| Image | Crop/ratio | Result |
|-------|-----------|--------|
| Landscape | Landscape | Normal crop (parent) |
| Portrait | Portrait | Normal crop (parent) |
| Square (either side) | Any | Normal crop (parent) |
| Landscape | Portrait | Canvas with top/bottom color bars |
| Portrait | Landscape | Canvas with left/right color bars |
| any | Free-form / no ratio / missing type | Normal crop (parent), error logged |
