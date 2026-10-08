<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Elevate Image Zoom (elevate_image_zoom) — agent index

A single **image field formatter** that renders core image fields with the third-party **ElevateZoom**
jQuery plugin, adding a hover/lens/inner **magnify** effect and an automatic multi-image **gallery**.
Package `Media`. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version-dir 11.0.x (release 11.0.0).

- **The formatter, all settings, the library requirement, the theme/JS, how to enable it** →
  [fields/formatter.md](fields/formatter.md)

## What it actually is

- One plugin: `ElevateImageZoomFormatter` (id **`elevate_image_zoom_formatter`**, label *"Elevate Image
  Zoom"*) in `src/Plugin/Field/FieldFormatter/ElevateImageZoomFormatter.php`, **extending core
  `Drupal\image\Plugin\Field\FieldFormatter\ImageFormatter`**. `field_types = { "image" }` — core image
  fields only.
- No routes, no permissions, no services, no config entities, no config schema, no Drush, no submodules.
  Not a plugin *type* — just one formatter plugin.
- `info.yml` declares **no** module dependencies, but the code requires core **`image`** (extends its
  formatter, calls `image_style_options()`).

## Dependencies / requirements

- **External JS library (manual install):** ElevateZoom — `jquery.elevatezoom.js` must be placed at
  `/libraries/elevatezoom/jquery.elevatezoom.js`. `elevate_image_zoom.install`
  (`hook_requirements()`) reports `REQUIREMENT_ERROR` on install and runtime until that file exists.
- Drupal library `elevate_image_zoom/elevate_image_zoom_js` (declared as `elevate_image_zoom_js` in
  `elevate_image_zoom.libraries.yml`) loads `js/elevate_script.js` plus the external
  `/libraries/elevatezoom/jquery.elevatezoom.js`; depends on `core/jquery` and `core/drupal`.

## Mechanism (from source)

- `viewElements()` builds, per image, `images_url` (display style or original), `zoom_image_url`
  (a separate zoom image style) and `thumbnail` (thumbnail style), each passed through
  `file_url_generator` (`transformRelative`). It renders `#theme => 'elevate_image_zoom_template'`
  (`elevate_image_zoom_theme()` → `templates/elevate-image-zoom-template.html.twig`), attaches the JS
  library, and pushes five values into `drupalSettings` (tint colour, window position/width/height,
  lens size).
- Multi-value fields set `elevate_has_gallery = 'yes'` and append `_gallery` to the CSS id; the Twig
  template then emits a main `<img>` plus a thumbnail `<a><img></a>` list. `js/elevate_script.js`
  (`Drupal.behaviors.easyzoom`) initialises `elevateZoom(...)` on the id per zoom type.

## Settings (formatter `defaultSettings()`)

`image_style`, `elevate_zoom_image_style`, `elevate_zoom_type` (`basic_zoom` default; also
`tint_zoom`, `inner_zoom`, `lens_zoom`, `mousewheel_zoom`), `elevate_shadow_color` (`#000000`),
`elevate_window_position` (1–16), `elevate_window_width`/`elevate_window_height` (100–1000),
`elevate_lens_size` (100–300), `elevate_thumbnail` (`thumbnail`). Full table + how each maps to the
ElevateZoom JS options in [fields/formatter.md](fields/formatter.md).

## Notes

- Presentation-only: does not change media, files or access. Selected per view-display on *Manage display*.
- These formatter settings have **no config schema** in the module, so strict config-schema tooling may
  flag the view-display config; the settings still save and work.
