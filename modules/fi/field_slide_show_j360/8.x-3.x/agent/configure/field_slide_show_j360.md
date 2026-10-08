<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Field Slideshow j360

## 1. Install the external library (required)
The slider JS is not bundled. Download `drupal_threesixty_slider`:
- https://github.com/code-rider/drupal_threesixty_slider
Extract into the site's `/libraries` directory and rename it so the file is at:
`/libraries/drupal_threesixty_slider/drupal-threesixty-slider.1.0.js`

`hook_requirements()` (runtime) reports OK once that file is found (via `library.libraries_directory_file_finder`, or legacy `libraries_get_path`), otherwise an error with the expected path.

## 2. Create the field
Add a content type with an **Image** field allowing an **unlimited** number of values — the images are the rotation frames, in upload order.

## 3. Choose the formatter (Manage display)
Select **Slideshow j360** for the image field. Settings:
- **Navigation Display** — `yes` (Display) / `no` (Not Display).
- **Width** — frame width in px (numeric, max 4 digits).
- **Height** — frame height in px (numeric, max 4 digits).

## How it renders
`ThreesixtyFormatter::viewElements()` gathers images via `getEntitiesToView()`, builds absolute URLs, attaches the `drupal_threesixty_slider` + `drupal.threeSixty` libraries, and renders the `slideShow360` theme. `template_preprocess_slideShow360()` builds classes `threesixty_images width-{w} height-{h} navigation-{yes|no}`; `js/trigger.js` parses those classes and initialises `$(...).ThreeSixty({...})` per element.

## Troubleshooting
If the rotation runs opposite to the drag direction, reverse the image upload order on the node (per README).
