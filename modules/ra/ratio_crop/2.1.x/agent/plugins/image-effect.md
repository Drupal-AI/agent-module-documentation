# The `image_crop_ratio` image effect

Ratio Crop provides a single configurable image effect plus the GD operation it delegates to.

| Plugin | Type | ID |
|---|---|---|
| `RatioCropImageEffect` | `@ImageEffect` (extends `ConfigurableImageEffectBase`) | `image_crop_ratio` (label "Ratio crop") |
| `RatioCrop` | `@ImageToolkitOperation`, toolkit `gd`, operation `crop_ratio` | `gd_crop_ratio` (extends core GD `Crop`) |

There is **no** configure route or settings form — you attach the effect to an **image style**.

## Configuration (two keys)

```yaml
# inside image.style.<name>  ->  effects:
effects:
  <uuid>:
    id: image_crop_ratio
    weight: 1
    data:
      aspect_ratio: '16:9'      # 'W:H', validated against ^[0-9]+:[0-9]+$ (default '1:1')
      anchor: 'center-center'   # which part to keep (default 'center-center')
```

`anchor` options (a 3×3 grid, `horizontal-vertical`):
`left-top`, `center-top`, `right-top`, `left-center`, `center-center`, `right-center`,
`left-bottom`, `center-bottom`, `right-bottom`.

## Add it via the UI

1. Go to *Configuration → Media → Image styles* (`/admin/config/media/image-styles`).
2. **Add image style** (or edit one), then in "Add a new effect" pick **Ratio crop** and *Add*.
3. Enter an **Aspect Ratio** as `W:H` (e.g. `16:9`) and choose an **Anchor**, then *Add effect* / *Save*.

## Add it programmatically (drush php:eval)

```php
use Drupal\image\Entity\ImageStyle;
$style = ImageStyle::create(['name' => 'card_16_9', 'label' => 'Card 16:9']);
$style->addImageEffect([
  'id' => 'image_crop_ratio',
  'data' => ['aspect_ratio' => '16:9', 'anchor' => 'center-center'],
]);
$style->save();
```

## Read it back

```bash
drush cget image.style.card_16_9
# effects.<uuid>.id: image_crop_ratio ; effects.<uuid>.data.aspect_ratio: '16:9'
```

## How it behaves

- Keeps the **largest** area matching the ratio; only the longer dimension is trimmed (never upscales).
- `applyEffect()` computes width/height from the ratio and the chosen anchor (via
  `image_filter_keyword()`), then calls `$image->apply('crop_ratio', [...])` → the `gd_crop_ratio`
  GD operation (a required-arguments subclass of core `Crop`, using PHP `imagecrop()`).
- Implements `transformDimensions()`, so derivative dimensions are computed **without** generating
  the file — markup `width`/`height` and responsive image `srcset` stay correct.
- Invalid ratios are rejected at form validation ("Should be defined in H:W form.").
