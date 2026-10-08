<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Contextual Cropping with image_widget_crop Plugin (media_contextual_crop_iwc_adapter) — agent index

Adapter that lets **Image Widget Crop** (`image_widget_crop`) supply the cropping UI for
**Media Contextual Cropping** (`media_contextual_crop`). Package *Media Contextual Cropping*.
Version **2.2.0** (doc dir `2.2.x`). Core `^11`. License GPL-2.0-or-later.

**Dependencies** (both required, `.info.yml`): `media_contextual_crop:media_contextual_crop` (the
plugin type / API) and `image_widget_crop:image_widget_crop` (the crop widget). Composer
constraints (`composer.json`): `drupal/image_widget_crop:^2.4 || ^3.0`,
`drupal/media_contextual_crop:~2.2.0`. It does **nothing on its own** — a "use-case" module such as
Media Contextual Cropping Embed or Media Contextual Cropping Field Formatter drives the plugin.

## What it ships

- **One plugin**: `ImageWidgetCrop` (plugin type `@MediaContextualCrop`, id **`image_widget_crop`**,
  `target_field_name = "image_crop"`, `image_style_effect = {"crop_crop"}`) in
  `src/Plugin/MediaContextualCrop/ImageWidgetCrop.php`, extending
  `media_contextual_crop`'s `MediaContextualCropPluginBase`. Injects
  `image_widget_crop.manager` + `entity_type.manager`. → [plugins/image_widget_crop.md](plugins/image_widget_crop.md)
- **Two form hooks** in `media_contextual_crop_iwc_adapter.module`: `hook_form_alter` attaches an
  `#after_build` to any IWC widget (class `field--widget-image-widget-crop`); the after-build
  callback rewords the `crop_reuse` message (override vs non-override) and **removes the Reset
  button** from the embedded widget. → [plugins/image_widget_crop.md](plugins/image_widget_crop.md)
- **One CSS library** `editor_media_dialog_fix` (`css/editor_media_dialog_fix.css`) that fixes the
  vertical-tabs layout of the crop wrapper inside the editor media dialog; attached from the
  plugin's `finishElement()`. Depends on `media_library/widget` + `editor/drupal.editor.dialog`.
- **`hook_help`** for `help.page.…` (one About paragraph, points at `advanced_help`).

## What it does NOT ship

No routes/controllers, no AJAX callbacks, no permissions, no Drush commands, no config
(`configure: null`), no config schema, no `.install`, no entities, no services file, no submodules.

## New in 2.2 (vs 2.0.x)

Core narrowed to `^11` (Drupal 10 dropped); explicit Composer constraints added; `saveCrop()`
now short-circuits and returns the existing crop id when submitted geometry (x/y/width/height)
equals the stored crop, avoiding a redundant `Crop` save.

## Operate

Enable Image Widget Crop, define crop types and image styles (Manual crop effect → crop type) the
native way, enable this adapter plus a use-case module. No config of its own.
→ [plugins/image_widget_crop.md](plugins/image_widget_crop.md)
