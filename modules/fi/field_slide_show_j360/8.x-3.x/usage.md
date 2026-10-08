<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Slideshow j360 provides an image-field display formatter that turns a multi-value image field into a 360-degree rotating image slider driven by the `drupal_threesixty_slider` jQuery library.

---

The formatter (`ThreesixtyFormatter`, id `SlideShowJ360`) extends the core `ImageFormatter`. Its settings add navigation (Display/Not Display) plus width and height (numeric, max 4 digits). In `viewElements()` it collects the field's images via `getEntitiesToView()` (which applies file access), builds absolute file URLs, attaches the `drupal_threesixty_slider` and `drupal.threeSixty` libraries, and renders the `slideShow360` theme. The Twig template outputs the images inside an `<ol>` whose classes encode the chosen width/height/navigation; `trigger.js` reads those classes and initialises the ThreeSixty plugin per element.

The third-party slider JS is not bundled: it must be placed at `/libraries/drupal_threesixty_slider/…`, and `hook_requirements()` reports whether it is present. To use the module, create a content type with an unlimited-value Image field, upload the frame sequence, then in Manage display choose the "Slideshow j360" formatter and set width/height/navigation. Image URLs are emitted through Twig auto-escaping and the numeric settings are length-limited, so there is no raw-output path.

---

- Turn a multi-image field into a 360-degree rotating slider.
- Let visitors drag to rotate a product through its frames.
- Select the "Slideshow j360" formatter for an image field.
- Set the slider frame width and height per display.
- Show or hide navigation controls.
- Use an unlimited-value image field to hold the frame sequence.
- Present a product from all angles (360 product view).
- Install the required drupal_threesixty_slider JS library.
- Verify the library is present via the status report (hook_requirements).
- Control rotation direction by ordering the uploaded images.
- Reuse the formatter across multiple content types.
- Combine with image fields on any entity that supports formatters.
- Display interactive spin views in nodes or teasers.
- Style the slider container via the module's threesixty.css.
- Serve absolute image URLs to the slider (access-checked file entities).