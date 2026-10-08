<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `Image_field_360` image field formatter

`Drupal\image_field_360\Plugin\Field\FieldFormatter\ImageField360` — annotation id
`Image_field_360` (note the capital `I`), label "Image field 360", `field_types = { "image" }`.
Extends core `FormatterBase`. Its `create()` injects `entity_type.manager`, used in
`viewElements()` to load the `file` entity for each item.

Select it on **Manage Display** for any `image` field ("Image field 360" in the format select).
There is **no admin route and no configure form** — everything lives on the field-formatter
instance and is stored under the config schema `field.formatter.settings.Image_field_360`
(`config/schema/image_field_360.schema.yml`).

## Prerequisite: the Photo Sphere Viewer library (not bundled)

The rendered viewer is driven by **Photo Sphere Viewer v2.9** (Jeremy Heleine). The module only
references it; you must install it yourself:

- `image_field_360.libraries.yml` loads `/libraries/photo-sphere-viewer/three.min.js` and
  `/libraries/photo-sphere-viewer/photo-sphere-viewer.min.js` (plus `js/photosphere.js`,
  `css/photosphere.css`; deps `core/drupalSettings`, `core/jquery`, `core/once`).
- `image_field_360_requirements()` (`image_field_360.install`) checks those two files exist under
  `\Drupal::root() . '/libraries/photo-sphere-viewer/'` and reports `REQUIREMENT_ERROR` at
  `admin/reports/status` until both are present. Source of the library:
  https://github.com/JeremyHeleine/Photo-Sphere-Viewer (tree `v2.9`).

Note: the README/`hook_requirements` are slightly inconsistent about the folder name — the README
text says `photo_sphere_viewer` but the actual `libraries.yml` paths and the requirements check both
use `/libraries/photo-sphere-viewer/`. Follow the hyphenated `photo-sphere-viewer` path used by the
code.

## Settings (`defaultSettings()` / `settingsForm()`)

| Key | Type (form) | Default | Effect |
| --- | --- | --- | --- |
| `loading_msg` | textfield | `Loading...` | Message shown by the viewer while the panorama downloads. Passed through `$this->t(...)` at render time. |
| `width` | textfield | `100%` | Viewer container width (any CSS length). |
| `height` | textfield | `500px` | Viewer container height (any CSS length). |
| `navbar_enable` | checkbox | `0` | Show the viewer navigation bar. All the `navbar_*` styling fields below are `#states`-hidden until this is checked (`#enable-navbar` id). |
| `navbar_backgroundColor` | textfield | `rgba(61, 61, 61, 0.5)` | Navigation bar background color. |
| `navbar_buttonsColor` | textfield | `rgba(255, 255, 255, 0.7)` | Button foreground color. |
| `navbar_buttonsBackgroundColor` | textfield | `transparent` | Button background color. |
| `navbar_activeButtonsBackgroundColor` | textfield | `rgba(255, 255, 255, 0.1)` | Active-button background color. |
| `navbar_buttonsHeight` | textfield | `20` | Button height (px). |
| `navbar_autorotateThickness` | textfield | `1` | Autorotate icon thickness (px). |
| `navbar_zoomRangeWidth` | textfield | `50` | Zoom range bar width (px). |
| `navbar_zoomRangeThickness` | textfield | `1` | Zoom range bar thickness (px). |
| `navbar_zoomRangeDisk` | textfield | `7` | Zoom range disk diameter (px). |
| `navbar_fullscreenRatio` | textfield | `4/3` | Fullscreen icon ratio (`width:height` or `width/height`). |
| `navbar_fullscreenThickness` | textfield | `2` | Fullscreen icon thickness (px). |

`settingsSummary()` prints only Width, Height, Loading message, and "Show Navbar: Yes/No".

The schema types some `navbar_*` keys as `integer` (buttonsHeight, autorotateThickness,
zoomRangeWidth, zoomRangeThickness, zoomRangeDisk, fullscreenThickness) while the form collects them
as free-text `textfield`s and the defaults are numeric strings — harmless in practice but worth
knowing if you set them programmatically.

## Rendering (`viewElements()`)

For each field item:

1. Loads the file entity: `entityTypeManager->getStorage('file')->load($item->getValue()['target_id'])`.
2. Builds an `$element_settings` array = `{ size:{width,height}, loading_msg (t()'d), navbar (bool),
   navbar_style:{ backgroundColor, buttonsColor, buttonsBackgroundColor, activeButtonsBackgroundColor,
   buttonsHeight, autorotateThickness, zoomRangeWidth, zoomRangeThickness, zoomRangeDisk,
   fullscreenRatio, fullscreenThickness } }`.
3. Emits:
   ```php
   $render[$delta] = [
     '#type' => 'container',
     '#attributes' => [
       'class' => 'photosphere',
       'data-photosphere' => json_encode($element_settings),
     ],
     'image' => [
       '#theme' => 'image',
       '#uri' => $file->getFileUri(),
       '#attributes' => ['class' => 'image-photosphere'],
       '#attached' => ['library' => ['image_field_360/image_field_360']],
     ],
   ];
   ```

Note: `#uri` is the file's stream URI and no image style is applied — the **original full-size
panorama** is delivered to the browser. There is no `#alt`/`#title` wiring, so alt text you enter on
the image field is not emitted by this formatter.

## Client side (`js/photosphere.js`)

`Drupal.behaviors.imageField360` runs `once('imageField360', '.photosphere')`. For each element it
reads the child `.image-photosphere` `src`, `JSON.parse`s the `data-photosphere` attribute, sets
`photosphereSettings.panorama = imgSrc` and `.container = element`, then
`new PhotoSphereViewer(photosphereSettings)`. A multi-value image field therefore yields one
independent viewer per delta.

## Programmatic setup

Set it on a display config like any formatter:

```php
$display->setComponent('field_panorama', [
  'type' => 'Image_field_360',
  'settings' => [
    'width' => '100%',
    'height' => '600px',
    'loading_msg' => 'Loading panorama...',
    'navbar_enable' => 1,
  ],
])->save();
```
