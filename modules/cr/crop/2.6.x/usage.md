Crop API provides the storage layer and programmatic API for image crops in Drupal: it defines crop types (named crop presets with aspect ratios and size limits), a `crop` content entity that records the position and size of a crop for a given image, and a `crop_crop` image effect that applies those crops in image styles.

---

Crop API is a foundational "API-only" module — it stores crops and exposes an API, but ships no cropping UI of its own; you pair it with a UI module such as Image Widget Crop or Focal Point. Site builders create **crop types** at Admin → Configuration → Media → Crop (`crop.overview_types`), each defining an aspect ratio plus optional soft and hard width/height limits, and then reference a crop type from a **Crop** image effect inside an image style. When an editor crops an image, the UI module saves a `crop` entity holding the crop's x/y center, width and height, keyed by the source file URI and crop type. The `crop_crop` image effect reads that entity so image derivatives are generated using the stored crop, and a `hook_file_url_alter` implementation appends a short hash to derivative URLs so browsers and CDNs pick up changes when a crop is re-edited. Crops are looked up in code through static helpers on the `Crop` entity (`Crop::findCrop()`, `Crop::cropExists()`, `Crop::getCropFromImageStyleId()`). Which entity types can be cropped is extensible via `CropEntityProvider` plugins (core File and Media are provided out of the box). By default derivative images are flushed whenever a crop changes, but this can be disabled (`crop.settings:flush_derivative_images`) for decoupled/cloud file storage such as S3. Crops are automatically cleaned up when their source file is deleted.

---

- Define a named crop type (e.g. "16:9 hero") with a fixed aspect ratio.
- Enforce minimum crop dimensions with soft and hard width/height limits.
- Apply a stored crop inside an image style using the `crop_crop` image effect.
- Store per-image crop coordinates (center x/y, width, height) as `crop` entities.
- Provide the storage backend for the Image Widget Crop editing UI.
- Provide the storage backend for the Focal Point module.
- Produce consistent thumbnails cropped to the important part of each photo.
- Generate multiple differently-cropped derivatives (square, banner, portrait) from one upload.
- Look up whether a crop already exists for an image URI in custom code.
- Load the crop that applies to a given image style programmatically.
- Create or update a crop entity in code (`setPosition()`, `setSize()`, `save()`).
- Bust browser/CDN caches automatically when a crop is re-edited (URL hash).
- Crop images stored on remote/cloud backends like Amazon S3.
- Disable derivative flushing when derivatives are generated out-of-band.
- Add crop support for a custom entity type via a `CropEntityProvider` plugin.
- Crop core File entities out of the box.
- Crop Media entities that reference an image or file field.
- Configure which image field of a media type is croppable.
- Auto-delete orphaned crops when the underlying file is deleted.
- Keep crop history via the crop entity's revision support.
- Translate/localize crops on multilingual sites (crop entity is translatable).
- Alter the list of available entity providers via `hook_crop_entity_provider_info_alter()`.
- Flush cached derivatives of a crop type from the admin UI.
- Support responsive images by cropping per breakpoint image style.
- Serve art-directed images where the subject stays framed at every size.
- Build a reusable crop preset library shared across many image styles.
- Export crop types as configuration and deploy them between environments.
- Restrict who can administer crop types via the "administer crop types" permission.
- Compute a short content hash of a crop for cache-busting or comparison.
