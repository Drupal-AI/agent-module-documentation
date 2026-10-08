<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rendering hooks: bypass image styles for animated GIFs

The module's behavior on normal image displays comes from `#[Hook]`-attribute classes (no procedural
hooks). Each checks the file with the `AnimatedGif` service and, for animated GIFs, removes the image
style so the raw animated file is rendered. **Just enabling the module activates all of this** — no
configuration required.

## `Drupal\animated_gif\Hook\Preprocess`

- `#[Hook('preprocess_image_formatter')]` — for the core **Image** formatter: if the item's file is
  an animated GIF, sets `#theme = 'image'` and unsets `#style_name` / `image_style`.
- `#[Hook('preprocess_responsive_image_formatter')]` — for the **Responsive image** formatter:
  same idea, unsets the responsive image style id / `image_style`.
- `#[Hook('preprocess_image_style')]` — for a rendered `image_style` element: swaps the styled
  `#uri` for the original `uri` and unsets `#style_name` / `style_name`.
- `#[Hook('preprocess_responsive_image')]` — unsets the `<img>` `srcset` and points `#uri` at the
  original file (so browsers don't fetch a flattened derivative).

The file is resolved from the preprocess variables (by `ImageItem` value, or loaded by URI), then
tested with `AnimatedGif::isFileAnAnimatedGif()`.

## `Drupal\animated_gif\Hook\FieldWidgetFormAlter`

- `#[Hook('field_widget_single_element_image_image_form_alter')]` — on the image upload widget, if
  the already-uploaded file is an animated GIF, appends a **warning message**:
  *"GIF images are not being processed by image styles, use with caution!"* so editors understand
  the file will be served un-styled.

## Net effect

With the module enabled, any image / responsive-image field that renders an animated GIF serves the
original file (animation preserved), while static images continue to use their image style normally.
No settings to toggle; the switch is per-file, decided by frame count.
