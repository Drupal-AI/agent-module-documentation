<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Contextual Cropping API lets the same media image carry a different crop for each place it is used, instead of one crop shared by every usage. It is an API/base module: it ships the plugin types, service and delivery pipeline, but no crop UI of its own.

---

Core Drupal attaches a crop to the media entity and stores exactly one derivative per (image, image style), so a landscape photo that is a wide hero on the homepage, a square card thumbnail and a portrait in a sidebar is forced into a single crop that suits none of them. This module makes the crop a property of the *usage context* instead. A context string (`entity_type:bundle:id.field.delta`, or an embed) identifies where the image appears; a `@MediaContextualCrop` "mechanism" plugin (Focal Point / Image Widget Crop adapters) saves a context-specific `crop` entity; a `@MediaContextualCropUseCase` plugin says where the crop comes from (a reference-field formatter or a CKEditor embed). The `media_contextual_crop.service` service then generates a per-context derivative URL of the form `…/contextual/styles/{style}/{scheme}/{path}/{crop_id}.{ext}`, and a dedicated route + `ContextualImageStyleDownloadController` + inbound path processor serve it, reusing core's image-derivative token and file-access checks. Preprocess hooks quietly upgrade the ordinary core image, responsive-image and CQRI formatters so existing displays gain contextual crops without switching formatters; a deprecated `contextual_image` formatter and a `media_contextual_crop:migrateToImageFormatter` Drush command exist only for migrating older setups. Requires a patch on `crop` and a core patch refactoring `ImageStyleDownloadController`. Note that derivatives multiply (one image × several contexts × several styles), so plan storage and editorial guidance accordingly.

---

- Crop one media image differently per usage context.
- Give a hero, a card thumbnail and a sidebar their own crop of one photo.
- Keep the subject visible across every crop of an image.
- Store the crop against the referencing field/delta, not the media entity.
- Apply a per-context crop to a media/entity reference field's image.
- Apply a per-context crop to a CKEditor-embedded media image.
- Add a crop-widget adapter as a `@MediaContextualCrop` plugin.
- Add a context source as a `@MediaContextualCropUseCase` plugin.
- Generate a contextual derivative URL from code via `media_contextual_crop.service`.
- Serve per-context derivatives through the module's own image route.
- Bust CDN/proxy caches automatically when a crop changes (hash token).
- Upgrade existing core image displays to contextual crops without changing formatter.
- Add contextual crops to responsive-image `srcset` entries and fallbacks.
- Output a contextual image URL string with the `image_contextual_url` formatter.
- Detect whether an image style participates in multi-cropping.
- Flush contextual derivatives when an image style is flushed.
- Delete a crop's derivatives automatically when the crop is deleted.
- Migrate displays off the deprecated `contextual_image` formatter with one Drush command.
- Plan file-storage growth for multiplied derivatives on a media-heavy site.
- Reuse crop types across multiple contexts.
- Audit how many derivatives a media library actually generates.
- Decide which contexts genuinely warrant their own crop.
- Build a headless/JSON image pipeline that returns per-context cropped URLs.
