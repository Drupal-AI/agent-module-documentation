# Configure — the `automated_crop` image effect

The module has **no settings page** (`configure = null`). You use it by adding its image effect to
an **image style**; the configuration lives on the style.

## In the UI

1. *Configuration → Media → Image styles* → **Add image style** (or edit one).
2. **Add** effect → **Automated Crop** → *Add*.
3. Configure:
   - **Crop type** (`crop_type`, required) — a Crop module crop type (e.g. `focal_point`,
     `freeform`, or a custom one; the aspect ratio + hard/soft limits come from it).
   - **Automatic crop provider** (`automatic_crop_provider`, required) — which `AutomatedCrop`
     plugin computes the crop; defaults to **Automated crop** (`automated_crop_default`). This
     select only appears when providers are registered.
4. Save the effect and the style.

## Where it is stored

On the image style config entity `image.style.<style_id>`:

```yaml
effects:
  <uuid>:
    id: automated_crop
    weight: 1
    data:
      crop_type: focal_point
      automatic_crop_provider: automated_crop_default
```

## Add the effect programmatically

```php
use Drupal\image\Entity\ImageStyle;

$style = ImageStyle::load('my_style');   // or ImageStyle::create(['name'=>'my_style','label'=>'My style'])
$style->addImageEffect([
  'id' => 'automated_crop',
  'weight' => 1,
  'data' => [
    'crop_type' => 'freeform',
    'automatic_crop_provider' => 'automated_crop_default',
  ],
]);
$style->save();
```

Inspect a style's effects:

```php
$style = \Drupal\image\Entity\ImageStyle::load('my_style');
foreach ($style->getEffects() as $effect) {
  printf("%s -> %s\n", $effect->getPluginId(), json_encode($effect->getConfiguration()['data'] ?? []));
}
```

## Runtime behaviour (what the effect does)

`AutomatedCropEffect::applyEffect()`:

1. Requires a valid `crop_type`; logs an error and aborts if it is missing.
2. Looks for an existing stored `crop` for this image URI + crop type (`Crop::findCrop()`), e.g. a
   Focal Point crop.
3. If none, dispatches the crop module's `AUTOMATIC_CROP` event; the module's subscriber builds and
   **saves** a crop entity using `automatic_crop_provider` (see [api/mechanism.md](../api/mechanism.md)).
4. Crops the image to the resulting anchor/size; `transformDimensions()` reports the crop's exact
   width/height for the derivative.

The effect declares a config dependency on the selected crop type.
