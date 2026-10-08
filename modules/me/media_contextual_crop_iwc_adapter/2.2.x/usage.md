Media Contextual Crop IWC Adapter lets Image Widget Crop supply the cropping interface for Media Contextual Cropping.

---

One image often lives in several places and each place wants a different crop: a landscape photo works as a wide hero but needs a square, subject-centred crop as a thumbnail. Cropping the media entity once forces a single answer for every usage. Media Contextual Cropping solves this by allowing a crop *per usage context*, and this adapter plugs Image Widget Crop — the established cropping widget in the Drupal ecosystem — in as the interface for defining those per-context crops, rather than introducing a second crop tool with its own conventions.

That is the whole point of an adapter module and worth stating plainly: a site that already uses Image Widget Crop keeps one cropping experience and one set of crop types, so editors do not learn two tools. The adapter itself is thin — a single `MediaContextualCrop` plugin (id `image_widget_crop`) plus two form hooks that reword the crop "reuse" message and remove the Reset button inside the embedded IWC widget so the contextual-crop dialog behaves. It has no configuration screen of its own; you configure Image Widget Crop, crop types and image styles the native way. A "use-case" module such as Media Contextual Cropping Embed (WYSIWYG media embeds) or Media Contextual Cropping Field Formatter (media reference fields) actually invokes the plugin — the adapter alone does nothing visible. In 2.2 the plugin also skips re-saving a crop whose geometry is unchanged, so re-opening a context without moving the selection no longer writes a fresh crop entity.

---

- Crop one image differently per usage context.
- Give a hero and a thumbnail different crops of the same photo.
- Reuse Image Widget Crop's cropping interface for contextual crops.
- Keep a single cropping experience for editors across regular and contextual crops.
- Avoid introducing a second crop tool with different conventions.
- Reuse existing Image Widget Crop crop types for contextual cropping.
- Enable contextual cropping inside WYSIWYG media embeds (with Media Contextual Cropping Embed).
- Enable contextual cropping on media reference fields (with Media Contextual Cropping Field Formatter).
- Crop a portrait image to fit a landscape placement.
- Keep the subject in frame in every context.
- Configure per-context crops using crop types you already defined.
- Set up an image style with the "Manual crop" effect bound to a crop type for the widget.
- Reword the crop-reuse message so editors know an override affects only that usage.
- Hide the IWC Reset button that does not apply in the contextual-crop dialog.
- Fix the vertical-tabs layout inside the editor media embed dialog.
- Avoid redundant crop entities when a context is opened but not re-cropped (2.2).
- Plan storage for the extra image derivatives that multiple contexts produce.
- Audit derivative counts on a media-heavy site with many contexts and styles.
- Decide whether the adapter is needed at all (only if the site already uses Image Widget Crop).
- Standardise on Image Widget Crop across both entity-level and contextual cropping.
- Migrate a site from ad-hoc per-place image handling to contextual crops.
- Document the crop contexts a site defines for its editors.
- Train editors once on Image Widget Crop rather than on two crop UIs.
