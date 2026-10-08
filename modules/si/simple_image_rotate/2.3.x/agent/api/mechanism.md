<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Image Rotate — how rotation works

All logic is in `simple_image_rotate.module` (procedural hooks); there are no services or
plugins.

## Enabling the button (form + widget)

- `hook_form_field_config_edit_form_alter()` — on an **image** field's edit form, adds the
  "Enable rotate function" checkbox; an entity builder stores it as the third-party setting
  `simple_image_rotate.enable_rotate` on the `FieldConfig`.
- `hook_field_widget_complete_form_alter()` — for image widgets where the field has
  `enable_rotate` **and** the user has `rotate images`: attaches the library
  `simple_image_rotate/simple_image_rotate` (JS/CSS) and adds, per uploaded image, a hidden
  `rotate` value and (via a `#process` callback) a "Rotate image clockwise" button.

## Client side

`js/simple_image_rotate.js` rotates the image **preview** in the browser and writes the chosen
angle into the hidden `rotate` field. Nothing is written to disk yet.

## On save (the real rotation)

`hook_entity_presave()` → `simple_image_rotate_rotate_image()` runs for every content entity:

1. For each **image** field on the entity that has `enable_rotate`:
2. For each item with a non-zero `rotate` angle:
   - Load the `File`; compute a new URI by appending `_r<counter>` before the extension
     (incrementing the counter if the name is taken).
   - `\Drupal::service('file.repository')->move()` the file to the new URI.
   - Rotate with the image factory: `\Drupal::service('image.factory')->get($uri)->rotate($angle)`
     and `save()`.
   - Update the item's `width`/`height` and the file's size, and **reset `rotate` to 0**
     (so re-saving does not rotate again — idempotent).

## Implications

- Rotation mutates the **source file** (new `_r<n>` filename); image styles regenerate from it.
- It uses Drupal's configured image toolkit (e.g. GD).
- No effect on non-image fields, on fields without `enable_rotate`, or for users lacking
  `rotate images`.
