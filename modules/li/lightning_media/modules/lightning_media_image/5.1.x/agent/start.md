<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Image (`lightning_media_image`) — agent index

The largest Lightning Media component. **No routes, no permissions file, no services, no
settings form (`configure` = null), no config schema, no Drush, no plugin types.** Depends
only on `lightning_media`; integrates opportunistically with `entity_browser`,
`image_widget_crop` and `lightning_roles`.

## Hooks (all of the behaviour)

| Hook | Effect |
|---|---|
| `hook_media_source_info_alter()` | `input_match.field_types = ['image']`; swaps the `image` source for the input-matching subclass; sets `entity_embed_display = 'media_image'` |
| `hook_field_widget_info_alter()` | swaps the `image_widget_crop` widget class for `Plugin\Field\FieldWidget\ImageCropWidget` (only if Image Widget Crop is installed) |
| `hook_ENTITY_TYPE_insert()` (`crop_type`) | creates an image style `crop_<id>` labelled "Cropped: <label>" containing a `crop_crop` effect |
| `hook_ENTITY_TYPE_presave()` (`entity_form_display`) | for every display **except** `media.image.*`, switches newly added image fields to the `entity_browser_file` widget using the `image_browser` browser |
| `hook_modules_installed()` | grants `access image_browser entity browser pages` to `media_creator`, `media_manager` and the Lightning `creator` role (needs `lightning_roles`); creates the `freeform` crop type when `image_widget_crop` appears |
| `hook_install()` | converts `media.image.*` form displays from `image_image` to `image_widget_crop` (`crop_list: [freeform]`, `show_crop_area: TRUE`) and points `image_widget_crop.settings` at a local Cropper build if one is present |
| `hook_form_FORM_ID_alter()` | attaches `lightning_media/browser.styling` to the image browser form |

Helper `_lightning_media_image_browser_exists()` gates the entity-browser bits on
`entity_browser` being installed **and** an `image_browser` entity browser existing.

## Configuration it installs (all `config/optional/`)

| Config | Value |
|---|---|
| `media.type.image` | label **Image**, source `image`, source field `field_media_image` |
| `field.storage.media.field_media_image` + `field.field.media.image.field_media_image` | image field, default extensions **`png gif jpg jpeg webp`** |
| `field.field.media.image.field_media_in_library` | "Show in media library" boolean |
| `core.entity_form_mode.media.media_browser` | a dedicated **media_browser** form mode |
| `core.entity_form_display.media.image.{default,media_browser,media_library}` | form displays |
| `core.entity_view_display.media.image.{default,embedded,media_library,thumbnail}` | view displays |
| `entity_browser.browser.image_browser` + `views.view.image_browser` | the image browser and its view |
| `crop.type.freeform` | the freeform crop type |

## Recipes

```bash
drush config:get media.type.image
drush config:get field.field.media.image.field_media_image settings.file_extensions
drush config:get entity_browser.browser.image_browser
# what widget is the Image media form actually using?
drush php:eval '
  print json_encode(\Drupal::entityTypeManager()->getStorage("entity_form_display")
    ->load("media.image.default")->getComponent("field_media_image")) . "\n";
'
```

A live install typically shows
`{"type":"image_widget_crop","settings":{"crop_list":["freeform"],"show_crop_area":true,…}}`
for `field_media_image`, and an image style `crop_freeform` created by the crop-type hook.

Create an Image media item:

```php
use Drupal\media\Entity\Media;
Media::create(['bundle' => 'image', 'name' => 'Hero'])
  ->set('field_media_image', ['target_id' => $file->id(), 'alt' => 'Hero image'])
  ->save();
```

Parent module API (input matching, `MediaHelper`, the `media_image` embed display):
[`../../../../5.1.x/agent/api/media-helper.md`](../../../../5.1.x/agent/api/media-helper.md)
and [`../../../../5.1.x/agent/plugins/implemented-plugins.md`](../../../../5.1.x/agent/plugins/implemented-plugins.md).
