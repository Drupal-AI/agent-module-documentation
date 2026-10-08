<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field widget: `entity_browser_image_crop` — "ImageWidget crop (with browser)"

`src/Plugin/Field/FieldWidget/ImageBrowserCropWidget.php`. `@FieldWidget` id
`entity_browser_image_crop`, provider `entity_browser`, `multiple_values = TRUE`, applies to
`field_types = {"image"}`. Extends `entity_browser`'s `FileBrowserWidget`.

## What it does
Lets an editor select images through an Entity Browser (the shipped `image_browser` browser: a
select-from-library View tab plus an upload tab) and crop each selected image inline. In
`process()` it appends an `image_crop` render element (from `image_widget_crop`) to every selected
image row, wired with the configured crop types, preview image style, and required-crop settings.
`massageFormValues()` copies the `image_crop` submission plus `alt`/`title` back onto each field
item so `ImageWidgetCropManager::buildCropToEntity()` persists the crop. The per-usage file
duplication that makes independent crops possible happens later, in `CropImageManager` entity hooks
(see start.md) — the widget itself only collects crop input.

## Settings (`settingsForm` / `defaultSettings`)
- `regular_preview_image_style` — preview while editing (only without file_entity, image fields).
- `crop_preview_image_style` — image style for the crop-zone preview.
- `crop_list` (required, multiple) — crop types offered; only crop types whose image style uses the
  "manual crop" effect appear. An AJAX callback narrows `crop_types_required` to this selection.
- `crop_types_required` (multiple) — crop types the editor must set before saving.
- `show_crop_area` — always expand the crop area.
- `show_default_crop` — show the default crop area.
- `field_widget_remove` / `field_widget_replace` — show Remove / Replace buttons.
Defaults are seeded from `crop_image.settings` (`entity_browser_image_crop.*`), editable at
`/admin/config/media/crop-image`.

## Preconditions
- At least one crop type must exist whose image style uses the **manual crop** effect, or the
  settings form shows an error and refuses to configure (`getAvailableCropType()`).
- Requires `image_widget_crop` (the `image_crop` element and manager) and `entity_browser`.

## Related surfaces
- Media source `crop_image` (`src/Plugin/media/Source/CropImage.php`) makes the widget usable on
  Media entities and resolves a duplicate's display name back to its source filename.
- VBO action `crop_image_generate_default_crop` backfills centered default crops on files in bulk
  (requires `views_bulk_operations`).
