<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image effect: Scale and crop (without upscale)

The module contributes one image-style effect plugin. It is NOT a new plugin *type* — it is a plugin
instance of core's image-effect type (`plugin.manager.image.effect`, annotation `@ImageEffect`), so
it appears in the "Add effect" dropdown on any image style.

## Plugin definition

| Property | Value |
| --- | --- |
| id | `image_scale_and_crop_without_upscale` |
| label | `Scale and crop (without upscale)` |
| annotation | `@ImageEffect` |
| class | `Drupal\image_scale_and_crop_without_upscale\Plugin\ImageEffect\ScaleAndCropWithoutUpscaleImageEffect` |
| extends | core `Drupal\image\Plugin\ImageEffect\ScaleAndCropImageEffect` |
| file | `src/Plugin/ImageEffect/ScaleAndCropWithoutUpscaleImageEffect.php` |

Because it subclasses core's Scale and Crop, it does **not** define its own config form or summary — it
reuses the parent's `buildConfigurationForm()`/`getSummary()`. The admin config UI is therefore
identical to core Scale and Crop.

## Configuration fields (per image style)

Set when you add the effect to an image style. Stored under `effects.<uuid>.data`:

| Key | Type | Meaning |
| --- | --- | --- |
| `width` | int | Target width (px). Inherited from core. |
| `height` | int | Target height (px). Inherited from core. |
| `anchor` | string | Crop anchor, `<horizontal>-<vertical>` (e.g. `center-center`, `left-top`, `right-bottom`). Where the crop is taken from when the source overflows the target box. |

Config schema (`config/schema/image_scale_and_crop_without_upscale.schema.yml`):

```yaml
image.effect.image_scale_and_crop_without_upscale:
  type: image_size          # core type: integer width + height mapping
  label: 'Image scale and crop (without upscale)'
  mapping:
    anchor:
      label: 'Anchor'
      type: string
```

## Add it to a style with drush/PHP

```php
$style = \Drupal\image\Entity\ImageStyle::load('thumbnail');
$style->addImageEffect([
  'id' => 'image_scale_and_crop_without_upscale',
  'weight' => 0,
  'data' => [
    'width' => 300,
    'height' => 200,
    'anchor' => 'center-center',
  ],
]);
$style->save();
```

(`drush php:eval "..."` works too.) Saving the style flushes its existing derivatives, so they
regenerate with the new effect on next request.

## How the no-upscale logic works (runtime)

`applyEffect(ImageInterface $image)`:
1. If the source is already exactly `width` x `height`, return `TRUE` (no-op).
2. Otherwise call `adjustTargetDimensionsToPreventUpscale($sourceWidth, $sourceHeight)`, overwrite
   `$this->configuration['width'|'height']` with the adjusted values, then delegate to
   `parent::applyEffect()` (core's real scale + crop against the GD/ImageMagick toolkit).

`adjustTargetDimensionsToPreventUpscale($sourceWidth, $sourceHeight)` (private) computes the target the
parent will actually use, rounding both ratios to 2 decimals (`PHP_ROUND_HALF_UP`):
- Source is larger than the target in **both** dimensions → target unchanged (parent downscales + crops).
- Source is `<=` target in **both** dimensions → shrink the target to the source: if the ratios match,
  target becomes the source size exactly; otherwise the limiting dimension is set to the source and the
  other is derived from `targetRatio` (so no upscaling, aspect ratio kept).
- Only width is `<=` target width → set width to source width, height = `round(sourceWidth / targetRatio)`.
- Only height is `<=` target height → set height to source height, width = `round(sourceHeight * targetRatio)`.

`transformDimensions(array &$dimensions, $uri)` runs the same adjustment for lazy/derivative size
prediction (e.g. `<img>` width/height attributes): if both dims are known it adjusts them the same way;
if either is empty both are set to `NULL` (unknown until the derivative is generated).

Worked examples (source 200x200, from the module's functional test `tests/src/Functional/ImageEffectsTest.php`):

| Target (w x h) | Result (w x h) | Note |
| --- | --- | --- |
| 400 x 400 | 200 x 200 | same ratio, both smaller → source size |
| 400 x 300 | 200 x 150 | both smaller, different ratio → shrunk to fit ratio |
| 300 x 200 | 200 x 133 | width smaller → derive height |
| 100 x 100 | 100 x 100 | both larger, same ratio → normal downscale |
| 100 x 300 | 66 x 200 | width larger, height smaller → downscale + crop |
| 100 x 50  | 100 x 50  | both larger → normal downscale + crop |

## Post-update hook

`image_scale_and_crop_without_upscale.post_update.php` →
`image_scale_and_crop_without_upscale_post_update_fix_data_types(&$sandbox)`: iterates every
`image.style.*` config, and for effects with id `image_scale_and_crop_without_upscale` whose stored
`width`/`height` are strings, casts them to int and saves. It edits config directly (via
`configFactory()->getEditable()`) rather than loading/saving the ImageStyle entity, deliberately to
**avoid** the entity's `postSave()` derivative flush on large sites. Runs on `drush updatedb`.
