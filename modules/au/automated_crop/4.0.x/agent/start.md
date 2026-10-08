# Automated Crop — agent index

An API + one image effect for **automatic** image cropping (no manual crop UI). Computes a crop box
from a Crop Type's aspect ratio / limits and saves a `crop` entity, integrating with the **crop**
module. No settings form, no configure route, no permissions, no config schema, no Drush.

- **Add the `automated_crop` image effect to an image style (`crop_type` + `automatic_crop_provider`)** →
  [configure/image-effect.md](configure/image-effect.md)
- **The `AutomatedCrop` plugin type: implement your own cropping strategy** →
  [plugins/automated-crop.md](plugins/automated-crop.md)
- **Manager service, the default plugin's geometry, and the Crop-module event integration** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Image effect plugin id `automated_crop`; config keys `crop_type` (a crop_type entity id) and
  `automatic_crop_provider` (an AutomatedCrop plugin id, default `automated_crop_default`).
- Plugin type: manager `plugin.manager.automated_crop`, dir `Plugin/AutomatedCrop`, annotation
  `@AutomatedCrop`, interface `AutomatedCropInterface`, base `AbstractAutomatedCrop`; fallback id
  `automated_crop_default`.
- Config lives on the image style: `image.style.<style>` → `effects[*].id = automated_crop`,
  `effects[*].data.crop_type` / `data.automatic_crop_provider`.
- Requires the `crop` module (crop types like `focal_point`, `freeform` come from crop/focal_point).
