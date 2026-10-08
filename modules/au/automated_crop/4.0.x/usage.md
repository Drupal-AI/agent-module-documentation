Automated Crop provides an API and an image-effect for automatically cropping images (no manual crop UI): it computes a crop box from a Crop Type's aspect ratio / limits and applies it, integrating with the Crop module so image styles can crop consistently without a human placing the crop.

---

The module is primarily an **API plus one image effect**. It defines an `AutomatedCrop` plugin type
(manager `plugin.manager.automated_crop`, directory `Plugin/AutomatedCrop`, annotation
`@AutomatedCrop`, interface `AutomatedCropInterface`, base class `AbstractAutomatedCrop`) with a
fallback plugin id `automated_crop_default`; the default plugin centres a crop box sized from the
requested aspect ratio (or the image's own ratio when none/`NaN`), never exceeding the original
dimensions. It ships an image effect, `automated_crop` (`ConfigurableImageEffectBase`), that you add
to an **image style**; its configuration is `crop_type` (a Crop module crop type) and
`automatic_crop_provider` (which `AutomatedCrop` plugin to use, default `automated_crop_default`).
When the style is applied the effect first looks for a stored `crop` entity for that image+crop type
(e.g. a Focal Point crop), and if none exists it dispatches the Crop module's `AUTOMATIC_CROP` event;
the module's event subscriber then builds a crop with the chosen provider (deriving min sizes from
the crop type's hard/soft limits and its aspect ratio) and saves a `crop` entity. A second subscriber
registers every automated-crop plugin as a Crop-API automatic-crop provider (via the
`AUTOMATIC_CROP_PROVIDERS` event). There is no settings form, configure route, permission, config
schema, or Drush command of its own — configuration lives on the image style's effect and on the
Crop Type entities. It requires the `crop` module (plus core `image`/`user`).

---

- Add an "Automated Crop" effect to an image style so uploads are auto-cropped to a ratio.
- Auto-crop images to a 16:9 (or any) aspect ratio defined by a Crop Type without manual cropping.
- Generate consistent thumbnails across a site without editors placing crops by hand.
- Fall back to an automatic centre crop when no manual/Focal Point crop exists for an image.
- Pair with Focal Point: use its stored crop when present, auto-crop otherwise.
- Provide a default cropping strategy for bulk-imported or migrated images.
- Constrain crops to a Crop Type's hard/soft limits so images never exceed the original size.
- Implement a custom cropping strategy by writing an `@AutomatedCrop` plugin (e.g. rule-of-thirds).
- Select which automated-crop provider an image style uses via the effect's configuration.
- Crop responsive-image derivatives consistently by reusing one Crop Type across styles.
- Register a custom crop algorithm as a Crop-API automatic provider automatically.
- Auto-crop media library images to a card format for listings.
- Produce square avatars from arbitrary uploads via a 1:1 crop type + automated effect.
- Keep hero images to a fixed banner ratio regardless of source dimensions.
- Compute crop geometry programmatically via the `plugin.manager.automated_crop` service.
- Reduce editorial workload by removing the manual crop step for standard image styles.
- Ensure aspect-ratio consistency for a design system's image components.
- Auto-crop product images to a catalogue ratio in an e-commerce build.
- Derive min crop dimensions from a Crop Type's soft limit while honouring the original image.
- Add automatic cropping to an existing Crop-based workflow without changing the crop storage.
- Export the automated-crop image effect as part of an image style's configuration for deployment.
