# API & mechanism

## Manager service

`plugin.manager.automated_crop` (`Drupal\automated_crop\AutomatedCropManager`). Build a crop
calculator directly:

```php
$provider = \Drupal::service('plugin.manager.automated_crop')
  ->createInstance('automated_crop_default', [
    'image'        => $image,        // Drupal\Core\Image\ImageInterface
    'min_width'    => 100,
    'min_height'   => 100,
    'aspect_ratio' => '16:9',        // or 'NaN' to keep the image's ratio
  ]);
$anchor = $provider->anchor();       // ['x' => .., 'y' => ..] top-left
$size   = $provider->size();         // ['width' => .., 'height' => ..]
```

`getProviderOptionsList()` returns `[id => label]` of all registered plugins.
`getFallbackPluginId()` returns `automated_crop_default` for unknown ids.

## Default plugin geometry (`automated_crop_default`)

`AutomatedCropDefault` (extends `AbstractAutomatedCrop`):

- **Size** — from the requested `aspect_ratio` (parses `W:H` or a numeric float). Ratio < 1 →
  vertical: width = `min(height*ratio, width)`, height = width/ratio. Ratio ≥ 1 → horizontal:
  height = `min(width/ratio, height)`, width = height*ratio. With no/`NaN` ratio it uses the image's
  own ratio. It never exceeds the original image dimensions.
- **Position** — centres the crop box: `x = origWidth/2 - cropWidth/2`, `y = origHeight/2 - cropHeight/2`.

## Crop-module event integration (how the effect gets a crop)

Two event subscribers (`automated_crop.services.yml`) tie into the **crop** module's events
(`Drupal\crop\Events\Events`):

1. **`AutomatedCropProvider::addProvider()`** on `AUTOMATIC_CROP_PROVIDERS` — registers every
   automated-crop plugin (`getProviderOptionsList()`) as a Crop-API automatic-crop provider, so they
   appear as selectable providers.

2. **`AutomatedCrop::generateAutomatedCrop()`** on `AUTOMATIC_CROP` (priority 100) — the workhorse.
   When the image style's effect finds no stored crop it dispatches `AUTOMATIC_CROP`; this subscriber:
   - checks the requested `automatic_crop_provider` is a known plugin (else returns);
   - reads the **Crop Type**'s hard/soft limits and aspect ratio to build `min_width` / `min_height`
     / `aspect_ratio` (soft limits are clamped to the image size);
   - `createInstance($provider, $configuration)` on the manager to compute anchor/size;
   - creates and **saves** a `crop` entity (`type`, `uri`, centre `x`/`y`, `width`, `height`) and
     sets it on the event so the effect can crop.

So the image effect (`AutomatedCropEffect`) and the crop module do the orchestration; the
`AutomatedCrop` plugin only computes geometry. See
[configure/image-effect.md](../configure/image-effect.md) for the effect config and
[plugins/automated-crop.md](../plugins/automated-crop.md) for writing a provider.

## Theme

`hook_theme()` registers `automated_crop_summary` (template
`templates/automated-crop-summary.html.twig`) used to render the effect's summary in the image-style
UI. No other hooks are invited; there is no `.api.php`.
