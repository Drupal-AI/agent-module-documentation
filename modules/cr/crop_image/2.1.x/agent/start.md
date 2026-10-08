<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Crop Image (crop_image) — agent index

Glue module that lets **one image be reused with an independent crop in each place it appears**.
It does not change where crops live; it gives every cropping usage its **own duplicate file**.
Hard-depends on `image_widget_crop` and `entity_browser (>=2.10)` (which pull in core `crop`).
Version **2.1.1**, core `^9.3 || ^10 || ^11`, license GPL-2.0-or-later.

## The problem it fixes
`image_widget_crop` stores crops in the core Crop API **keyed by the file's URI**. So the same
source image reused across several entities can hold only **one crop per crop type** — set a crop on
page A and it changes on page B. Crop Image sidesteps this by **duplicating the physical file per
usage** and cropping the copy, deleting the copy when it is no longer referenced. Editors notice no
change in workflow.

## Mechanism (read the source, not the guesswork)
- `crop_image.module` — three entity hooks driven by `CropImageManager`:
  - `hook_entity_presave` → `validateCropImages()`: for each image-field item using the widget,
    copy the source file into a `crop_duplicate`, swap the field `target_id` to the duplicate, and
    (if `automatic_crop`) fill a centered default crop. Also deletes duplicates no longer used.
  - `hook_entity_delete` → `removeCropImages()`: delete all `crop_duplicate`s for the entity.
  - `hook_entity_insert` → `moveOriginalFile()`: relocate/rename the original file to match the
    duplicate (filefield_paths compatibility); forced to run last via `hook_module_implements_alter`.
  - `hook_views_pre_render`: attach the `crop_image/image_browser` library to the `image_browser` view.
- `crop_duplicate` **content entity** (`src/Entity/CropDuplicate.php`, base table `crop_duplicate`):
  tracks `source_file_id`, `duplicate_file_id`, `entity_type`, `entity_uuid`, `field_name`,
  `field_delta`, `uid`. `preCreate()` copies the source to `crop-duplicate-N-for-<basename>`;
  `postSave()` adds file-usage for both files; `delete()` removes usage and deletes the copy file.
- **No custom cropper JS and no custom AJAX save/upload endpoint.** The Cropper.js UI and crop-
  coordinate persistence come from `image_widget_crop` / the core Crop API. This module's own JS
  (`js/image-browser.js`) is only click-to-select behavior in the Entity Browser grid.

## What it provides
- Field widget `entity_browser_image_crop` — "ImageWidget crop (with browser)" — see
  [fields/entity-browser-image-crop-widget.md](fields/entity-browser-image-crop-widget.md).
- Media source `crop_image` (extends core Image) — `src/Plugin/media/Source/CropImage.php`.
- VBO action `crop_image_generate_default_crop` ("Generate default crop"), needs
  `views_bulk_operations` — `src/Plugin/Action/GenerateDefaultCropAction.php`.
- Settings form `crop_image.settings` at `/admin/config/media/crop-image`
  (permission `administer site configuration`) — widget defaults + `automatic_crop`.
- Config install: an Entity Browser (`image_browser`) and a View (`image_browser`, base
  `file_managed`) providing the select-from-library + upload tabs.

## Dependencies & positioning
- Required: `image_widget_crop`, `entity_browser (>=2.10)`, core `crop`, `file`, `views`, `user`.
- Optional: `views_bulk_operations` (the bulk action), `file_entity` (rendered previews / per-file
  edit access), `filefield_paths` (filename sync), `media_library` (media source add form).
- Provides **no permissions** and **no Drush commands**. Provides a config schema.
- Uses the legacy jQuery `.once()` API in its JS (pre-`core/once`).
- Weigh against `focal_point` when a single focus point suffices, and against staying on core Media
  Library (Entity Browser is the older, heavier selection architecture).

## Files
- Manager/glue: `src/CropImageManager.php`
- Entity + storage: `src/Entity/CropDuplicate.php`, `src/CropDuplicate*.php`
- Widget: `src/Plugin/Field/FieldWidget/ImageBrowserCropWidget.php`
- Media source: `src/Plugin/media/Source/CropImage.php`
- Action: `src/Plugin/Action/GenerateDefaultCropAction.php`
- Settings: `src/Form/SettingsForm.php`
- Config: `config/install/*`, `config/schema/crop_image.schema.yml`
