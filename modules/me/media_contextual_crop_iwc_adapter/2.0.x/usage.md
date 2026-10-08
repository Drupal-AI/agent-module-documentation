<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Contextual Crop IWC Adapter supplies a MediaContextualCrop plugin so Image Widget Crop becomes the cropping interface for per-usage (contextual) crops of media images.

---

Media Contextual Crop lets one media image be cropped differently for each place it appears — a wide hero, a square thumbnail, an embed inside body text — instead of forcing a single crop on the media entity. That API defines a pluggable crop UI; this adapter is one such plugin, wiring in Image Widget Crop (the established crop-widget module) as that UI. The plugin (`ImageWidgetCrop`, id `image_widget_crop`, target field `image_crop`) extends `MediaContextualCropPluginBase` and implements the API's hooks: `getComponentConfig()` builds the widget render array, `saveCrop()` persists a `crop` entity for a context (skipping the save when geometry is unchanged), `processFieldData()`/`processEmbedData()` normalise submitted and serialized crop data, `finishElement()` seeds default values and attaches a CSS fix, and `widgetSave()` serialises the crop settings into the embed's `data-crop-settings` attribute. A `hook_form_alter`/after-build pair adjusts the widget when it appears in the override context (rewording the reuse notice and removing the per-crop Reset buttons), and a small library (`editor_media_dialog_fix`) fixes the vertical-tabs layout of the crop widget inside the WYSIWYG media dialog. The module has no settings page: it relies on native Image Widget Crop configuration (crop types + image styles using the manual-crop effect) and on a "use-case" module (Media Contextual Cropping Embed or Field Formatter) to actually surface the plugin. On a site that already uses Image Widget Crop this keeps a single cropping experience and one set of crop types; a site not using Image Widget Crop does not need it.

---

- Use the Image Widget Crop widget as the UI for contextual (per-usage) crops.
- Crop one media image differently for a hero versus a thumbnail context.
- Reuse existing Image Widget Crop crop types for contextual cropping.
- Keep a single cropping experience for editors instead of two tools.
- Provide the crop UI inside the WYSIWYG media-embed dialog.
- Fix the crop vertical-tabs layout inside the editor media dialog.
- Crop a portrait image for a landscape embed context.
- Set a per-context crop that affects only that contextual usage of the image.
- Distinguish override-context crops from non-override (shared) usages.
- Remove confusing per-crop Reset buttons in the override form.
- Skip redundant crop saves when the crop geometry is unchanged.
- Preview the crop using a configurable preview image style.
- Serialise crop settings into a media embed's data-crop-settings attribute.
- Restore crop defaults on an embed from its stored settings.
- Bridge Media Contextual Cropping Embed to the Image Widget Crop widget.
- Bridge Media Contextual Cropping Field Formatter to Image Widget Crop.
- Limit ghost crops/images by carrying embed context (2.0.x).
- Configure crop types with the constraints each context needs.
- Create image styles using the manual-crop effect for each crop type.
- Preserve the image subject across every contextual crop.
- Plan storage for the derivatives contextual cropping multiplies.
- Decide whether the adapter is needed (only if Image Widget Crop is in use).
- Standardise on Image Widget Crop across normal and contextual cropping.
- Document the crop contexts and crop types a site defines.
- Audit crop quality per context after a theme or layout change.
