<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Contextual Cropping with image_widget_crop (media_contextual_crop_iwc_adapter) — agent index

Adapter that provides one **MediaContextualCrop plugin** so **Image Widget Crop** is the crop UI for
**Media Contextual Crop** (per-usage crops of media images). No routes, no permissions, no settings
page, no config schema. Core `^11`.

**Dependencies** (both required, both hard deps in `.info.yml`):
- `media_contextual_crop` (~2.2.0) — defines the `MediaContextualCrop` plugin type + `MediaContextualCropPluginBase`.
- `image_widget_crop` (^2.4 || ^3.0) — the crop widget + `image_widget_crop.manager` service.

Only useful with a **use-case module** that surfaces the plugin: Media Contextual Cropping Embed
(WYSIWYG filter) or Media Contextual Cropping Field Formatter.

**What it provides**
- Plugin `ImageWidgetCrop` (`@MediaContextualCrop` id `image_widget_crop`, `target_field_name`
  `image_crop`, `image_style_effect {"crop_crop"}`) — `src/Plugin/MediaContextualCrop/ImageWidgetCrop.php`.
- Hooks in `.module`: `hook_help`, `hook_form_alter` + custom after-build
  (`media_contextual_crop_iwc_adapter_widget_after_build`) that adapt the widget in the override context.
- Library `editor_media_dialog_fix` (CSS only) — fixes crop vertical-tabs in the WYSIWYG media dialog.

**Solution docs**
- [agent/plugins/image_widget_crop.md](plugins/image_widget_crop.md) — the plugin's methods, the
  form_alter/after-build behaviour, the library, install/operate notes.
