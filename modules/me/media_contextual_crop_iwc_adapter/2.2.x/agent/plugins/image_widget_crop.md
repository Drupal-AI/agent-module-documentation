<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `image_widget_crop` MediaContextualCrop plugin

## Install & enable

```bash
composer require drupal/media_contextual_crop_iwc_adapter
drush en media_contextual_crop_iwc_adapter -y
```

Pulls in both required modules: `media_contextual_crop` (the `@MediaContextualCrop` plugin type /
API) and `image_widget_crop` (the crop widget + `image_widget_crop.manager` service). This module
alone renders nothing — enable a **use-case** module too: Media Contextual Cropping Embed (WYSIWYG
media embeds) or Media Contextual Cropping Field Formatter (media reference fields). No
configuration screen ships here; configure Image Widget Crop, crop types and image styles natively.

Prep for use (from README): create a crop type with your constraint, then an image style using the
**Manual crop** effect bound to that crop type. The plugin advertises it handles the `crop_crop`
image-style effect (`image_style_effect = {"crop_crop"}`).

## The plugin

`src/Plugin/MediaContextualCrop/ImageWidgetCrop.php`, annotation:

```
@MediaContextualCrop(
  id = "image_widget_crop",
  target_field_name = "image_crop",
  label = "Image Widget Crop",
  image_style_effect = {"crop_crop"}
)
```

Extends `Drupal\media_contextual_crop\MediaContextualCropPluginBase`. `create()` injects
`entity_type.manager` and `image_widget_crop.manager` (`ImageWidgetCropManager`). It implements the
base plugin's contract; the use-case module calls these methods — this adapter never invokes them
itself.

### Methods (what each does)

- **`getComponentConfig($default_values, $image_style_crops, $preview_image_style = NULL)`** —
  returns the field-widget component config used to build the crop UI: `type => image_widget_crop`
  with settings `progress_indicator: throbber`, `preview_image_style` (arg or `thumbnail`),
  `crop_preview_image_style: crop_thumbnail`, `crop_list: $image_style_crops`,
  `warn_multiple_usages: FALSE`, `show_crop_area: TRUE`, `show_default_crop: TRUE`.
- **`finishElement(&$form, $source_field_name, $default_values)`** — calls the parent, then
  attaches library `media_contextual_crop_iwc_adapter/editor_media_dialog_fix` and, if
  `$default_values['data-crop-settings']` is a non-empty string, restores prior crop selections
  into `$widget['#default_value']['image_crop']['crop_wrapper']` via
  `@unserialize($default_values['data-crop-settings'], ['allowed_classes' => FALSE])` (object
  instantiation disabled).
- **`widgetSave(array $form, FormStateInterface $form_state)`** (static) — reads
  `['field_media_image', 0, 'image_crop', 'crop_wrapper']` from form state, strips each entry's
  `crop_container.reset`, and stores the result as the media attribute `data-crop-settings`
  (`serialize()`) plus `data-crop-type => image_widget_crop`.
- **`processFieldData($field_data)`** (static) — drops any `crop_wrapper` entry whose
  `crop_container.values.crop_applied == 0`; returns `NULL` when nothing remains, else the pruned
  data. This is how "no crop was actually drawn" becomes "no crop stored".
- **`processEmbedData($embed_settings)`** — unserializes `$embed_settings['crop']`
  (`['allowed_classes' => FALSE]`) and returns `['plugin_id' => 'image_widget_crop',
  'crop_setting' => ['crop_wrapper' => …], 'context' => $embed_settings['context'],
  'base_crop_folder' => 'multi_crop_embed']`.
- **`saveCrop($crop_settings, $image_style_name, $old_uri, $context, $width, $height)`** — the
  actual write. Loads the `ImageStyle`, reads its dependencies to find the bound `crop.type.*`,
  and for the matching `crop_wrapper` entry: if `crop_applied == '1'`, converts the widget's
  top-left `x/y` + `width/height` to a **centre** coordinate via
  `imageWidgetCropManager->getAxisCoordinates(...)`, then `setPosition()` / `setSize()` on the
  `Crop` entity (from `retrieveContextualCrop($context, $crop_type, $old_uri)`) and `save()`s it,
  returning the crop id. Returns `NULL` if no crop applied. **2.2 change**: before saving an
  existing (non-new) crop it compares stored `position()`/`size()` to the submitted geometry and
  returns the existing id unchanged when they match — no redundant save.

## The form hooks (`.module`)

- **`hook_form_alter`** — scans top-level form elements; when an element's
  `#attributes[class]` contains `field--widget-image-widget-crop`, appends
  `media_contextual_crop_iwc_adapter_widget_after_build` to that widget's `#after_build`.
- **`…_widget_after_build($form, $form_state)`** — for each delta with an `image_crop` array:
  (1) rewrites the `crop_reuse` `#markup` to either *"This crop definition affects ONLY this
  contextual usage of this image"* (when the build form id is `override_entity_form`) or
  *"…affects non-override usages of this image"*; (2) walks `image_crop.crop_wrapper` `details`
  containers and **unsets** any `crop_container.reset` element (removes the Reset button that does
  not belong in the contextual-crop dialog). All strings go through `t()`.

## Notes / caveats

- **`composer.json` is mislabelled upstream**: its `name` says `media_contextual_crop_fp_adapter`
  and `description` mentions `focal_point`. Copy-paste error — the real project, `.info.yml` name
  and namespace are all `media_contextual_crop_iwc_adapter` (Image Widget Crop, not focal point).
  Composer install still works because the package is resolved by the drupal.org project name.
- Both `unserialize()` calls pass `['allowed_classes' => FALSE]`, so restoring stored crop
  settings cannot instantiate PHP objects.
- `widgetSave()` hard-codes the source field name `field_media_image` when reading form state.
- Contextual crops multiply derivatives: one image × N contexts × M image styles = N·M files.
  Size storage accordingly and verify derivatives are not generated per request on busy pages.
