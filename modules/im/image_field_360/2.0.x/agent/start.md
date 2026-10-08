<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image Field 360 (image_field_360) — agent index

A single **image field formatter** (`Image_field_360`, label "Image field 360", field type `image`)
that renders each image item as an interactive **360 degree equirectangular panorama** — drag to
rotate, zoom, autorotate, fullscreen. Version **2.0.2**, core `^10 || ^11`, package Fields. No admin
route, no permissions, no Drush, no services. Ships a config schema, one library, one JS behavior,
one CSS file.

Mechanism in one line: `viewElements()` emits per item a `<div class="photosphere"
data-photosphere="{...json settings...}">` wrapping `<img class="image-photosphere">`; the behavior
in `js/photosphere.js` reads the image `src`, `JSON.parse`s the settings, sets `panorama`/`container`,
and calls `new PhotoSphereViewer(...)`.

## Critical operational fact — the viewer library is NOT bundled

The actual 360 viewer is **Photo Sphere Viewer v2.9 by Jeremy Heleine**, loaded from
`/libraries/photo-sphere-viewer/three.min.js` and `/libraries/photo-sphere-viewer/photo-sphere-viewer.min.js`
(see `image_field_360.libraries.yml`). These files do **not** come with the module. `hook_requirements()`
(`image_field_360.install`) raises `REQUIREMENT_ERROR` on the status report (`admin/reports/status`)
until both are present. Until you download the library (https://github.com/JeremyHeleine/Photo-Sphere-Viewer,
tree v2.9) into that path, the formatter renders an `<img>` and container but no working viewer.

## What you'd do → where

- **Use / configure the formatter (all settings, defaults, config schema, render output)** →
  [fields/formatter.md](fields/formatter.md)

## Key facts (real machine names)

- Formatter plugin id: `Image_field_360` (capital I). Class
  `Drupal\image_field_360\Plugin\Field\FieldFormatter\ImageField360` (extends core `FormatterBase`,
  injects `entity_type.manager` to load the `file` entity per item). Field type: `image`.
- Config schema key: `field.formatter.settings.Image_field_360` (`config/schema/image_field_360.schema.yml`).
- Library: `image_field_360/image_field_360` — external `three.min.js` + `photo-sphere-viewer.min.js`
  (from `/libraries/...`), `js/photosphere.js`, `css/photosphere.css`; deps `core/drupalSettings`,
  `core/jquery`, `core/once`.
- Settings + defaults (`defaultSettings()`): `loading_msg`=`Loading...`, `width`=`100%`,
  `height`=`500px`, `navbar_enable`=`0`; when navbar on: `navbar_backgroundColor`=`rgba(61,61,61,0.5)`,
  `navbar_buttonsColor`=`rgba(255,255,255,0.7)`, `navbar_buttonsBackgroundColor`=`transparent`,
  `navbar_activeButtonsBackgroundColor`=`rgba(255,255,255,0.1)`, `navbar_buttonsHeight`=`20`,
  `navbar_autorotateThickness`=`1`, `navbar_zoomRangeWidth`=`50`, `navbar_zoomRangeThickness`=`1`,
  `navbar_zoomRangeDisk`=`7`, `navbar_fullscreenRatio`=`4/3`, `navbar_fullscreenThickness`=`2`.
- No `hook_theme` — output is a raw `#type => container` + `#theme => image` render array, not a Twig
  template. Only styling hook is `css/photosphere.css` (`.photosphere { max-width:100%; margin:0 auto }`).

## Practical constraints (accuracy / accessibility / performance)

1. **Images must be true equirectangular (360x180) panoramas.** A flat photo renders smeared — the
   README warns of this explicitly.
2. **No keyboard path and no built-in text alternative.** It is a canvas/WebGL drag interaction;
   add descriptive alt text and treat it as inaccessible to keyboard-only users.
3. **One large texture is heavy on mobile.** One panorama per page is a sensible rule; a multi-value
   field renders one independent viewer per delta, so a gallery of them multiplies the cost.
