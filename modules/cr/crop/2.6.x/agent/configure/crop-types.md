# Crop types & settings

![Crop types list](../../../../../../../screenshots/crop/2.6.x/crop-types.png)

**Crop types** are config entities (`crop.type.*`) — reusable crop presets. Manage at
`/admin/config/media/crop` (route `crop.overview_types`, add: `crop.type_add`). Requires the
`administer crop types` permission.

Per crop type fields (config schema `crop.type.*`):
- `label`, `id`, `description`
- `aspect_ratio` — string `W:H` (e.g. `16:9`); validated against `#^[0-9]+:[0-9]+$#`, or empty for free.
- `soft_limit_width` / `soft_limit_height` — recommended minimum (UI warns).
- `hard_limit_width` / `hard_limit_height` — enforced minimum.

Accessors on `CropTypeInterface`: `getAspectRatio()`, `getSoftLimit()`, `getHardLimit()`,
`getCropTypeNames()`, `validate()`.

## Applying a crop type
A crop type does nothing until referenced by a **Crop** image effect (`crop_crop`) inside an
image style (`/admin/config/media/image-styles`). The effect config (`image.effect.crop_crop`)
stores `crop_type` and optional `automatic_crop_provider`. At render time the effect loads the
matching `crop` entity for the file URI and applies the stored coordinates.

## Module settings (`crop.settings`)
- `flush_derivative_images` (bool, default `true`) — flush image derivatives when a crop
  changes. Set `false` for decoupled/cloud file storage (e.g. S3) where derivatives are
  generated out-of-band, to avoid serving 404s:
  ```php
  // settings.php
  $config['crop.settings']['flush_derivative_images'] = FALSE;
  ```

## Media integration
On a media type edit form the module adds a **Crop configuration** fieldset to pick which
image/file field is croppable (stored as media type third-party setting `crop:image_field`).
