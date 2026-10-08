<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin: ImageWidgetCrop (id `image_widget_crop`)

`src/Plugin/MediaContextualCrop/ImageWidgetCrop.php` — a `MediaContextualCrop` plugin (type defined by
the `media_contextual_crop` module) that makes the Image Widget Crop widget the UI for contextual
(per-usage) crops. Extends `Drupal\media_contextual_crop\MediaContextualCropPluginBase`.

## Annotation
```
@MediaContextualCrop(
  id = "image_widget_crop",
  target_field_name = "image_crop",
  label = "Image Widget Crop",
  image_style_effect = {"crop_crop"}
)
```
`target_field_name = image_crop` is the widget subtree it reads/writes; `image_style_effect {"crop_crop"}`
tells the host which image-style effect this plugin's styles must use (manual-crop / `crop_crop`).

## Dependency injection
Constructor + `create()` inject `entity_type.manager` (into the base) and `image_widget_crop.manager`
(`ImageWidgetCropManager`, stored as `$this->imageWidgetCropManager`).

## Methods (all overrides of the base API)
- `getComponentConfig($default_values, $image_style_crops, $preview_image_style = NULL)` — returns the
  widget render config: `type => image_widget_crop`, `progress_indicator => throbber`,
  `preview_image_style` (arg or `thumbnail`), `crop_preview_image_style => crop_thumbnail`,
  `crop_list => $image_style_crops`, `warn_multiple_usages => FALSE`, `show_crop_area => TRUE`,
  `show_default_crop => TRUE`.
- `saveCrop($crop_settings, $image_style_name, $old_uri, $context, $width, $height)` — loads the
  `ImageStyle`, derives the `crop_type` from the style's `crop.type.*` dependency, finds the matching
  entry in `$crop_settings['crop_wrapper']`, and (when `crop_applied == '1'`) computes the crop centre
  via `imageWidgetCropManager->getAxisCoordinates()`. **Idempotence:** if the retrieved crop is not new
  and its position/size already equal the submitted values it returns `$crop->id()` without re-saving;
  otherwise `setPosition()/setSize()/save()` and returns the id. Returns `NULL` when no crop applied.
  Crop retrieval is `retrieveContextualCrop($context, $crop_type, $old_uri)` (base method).
- `processFieldData($field_data)` (static) — drops `crop_wrapper` entries whose `crop_applied == 0`;
  returns `NULL` if none remain, else the filtered data.
- `finishElement(&$form, $source_field_name, $default_values)` — calls parent, attaches the
  `media_contextual_crop_iwc_adapter/editor_media_dialog_fix` library, and if
  `$default_values['data-crop-settings']` is non-empty seeds
  `$widget['#default_value']['image_crop']['crop_wrapper']` from it via
  `unserialize(..., ['allowed_classes' => FALSE])` (object instantiation disabled).
- `widgetSave($form, $form_state)` (static) — reads
  `field_media_image[0][image_crop][crop_wrapper]`, strips each entry's `crop_container.reset`,
  and stores `serialize($settings)` into `attributes.data-crop-settings` plus
  `attributes.data-crop-type = image_widget_crop`.
- `processEmbedData($embed_settings)` — `unserialize($embed_settings['crop'], ['allowed_classes' => FALSE])`,
  returns `['plugin_id' => 'image_widget_crop', 'crop_setting' => ['crop_wrapper' => ...],
  'context' => $embed_settings['context'], 'base_crop_folder' => 'multi_crop_embed']`.

## Module hooks (`media_contextual_crop_iwc_adapter.module`)
- `hook_help` — About text on `help.page.media_contextual_crop_iwc_adapter`, linking to `advanced_help`.
- `hook_form_alter` — scans top-level form elements; any element whose `#attributes[class]` contains
  `field--widget-image-widget-crop` gets an `#after_build` of
  `media_contextual_crop_iwc_adapter_widget_after_build`.
- `media_contextual_crop_iwc_adapter_widget_after_build($form, $form_state)` — when the build form_id is
  `override_entity_form` it reworders the `image_crop.crop_reuse` `#markup` ("affects ONLY this
  contextual usage") vs the default ("affects non-override usages"); in all cases it removes the
  per-crop `crop_container.reset` buttons inside each `crop_wrapper` `details` element.

## Library
`editor_media_dialog_fix` (`.libraries.yml`) → `css/editor_media_dialog_fix.css`, depends on
`media_library/widget` and `editor/drupal.editor.dialog`. CSS-only fix so the crop widget's
`vertical-tabs` render correctly inside `form.editor-media-dialog`.

## Install / operate
1. Enable the module (pulls in `media_contextual_crop` + `image_widget_crop`).
2. Also enable a use-case module (media_contextual_crop_embed or _field_formatter) — nothing surfaces
   the plugin on its own.
3. Native Image Widget Crop setup only: create a crop type with the desired constraint, then an image
   style using the manual-crop (`crop_crop`) effect selecting that crop type.
4. No settings form and no config objects/schema ship with this module (`configure => null`).
