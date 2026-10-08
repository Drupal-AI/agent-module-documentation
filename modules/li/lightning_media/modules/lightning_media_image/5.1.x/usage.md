<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Image is the richest Lightning Media component: it installs an **Image** media type, makes core's `image` source input-matching, and — when Entity Browser and Image Widget Crop are present — wires up a dedicated image browser plus a freeform cropping workflow that every new image field on the site automatically adopts.

---

`hook_media_source_info_alter()` sets `$sources['image']['input_match']['field_types'] = ['image']`, swaps core's `image` source for the input-matching `Drupal\lightning_media_image\Plugin\media\Source\Image`, and sets `$sources['image']['entity_embed_display'] = 'media_image'` so embedded image media render through the parent module's image-formatter display plugin. `hook_field_widget_info_alter()` replaces the `image_widget_crop` widget class with `ImageCropWidget`. `hook_ENTITY_TYPE_insert()` on `crop_type` auto-creates a matching image style (`crop_<id>`, label "Cropped: <label>") containing a `crop_crop` effect, so a new crop type is immediately usable as a display style. `hook_ENTITY_TYPE_presave()` on `entity_form_display` is the aggressive bit: for every form display that is **not** the Image media type's own, it finds newly added image fields (via `DisplayHelper::getNewFields()`) and switches them to the `entity_browser_file` widget pointed at the `image_browser` entity browser, with edit/remove buttons and a thumbnail preview. `hook_install()` converts the Image media type's form displays from `image_image` to `image_widget_crop` with the `freeform` crop, prefers a locally installed Cropper library over the CDN copy, and grants `access image_browser entity browser pages` to the media roles when `lightning_roles` is present. Config includes the media type, `field_media_image` (extensions `png gif jpg jpeg webp`), a `media_browser` form mode, the `image_browser` entity browser and its backing view, and the `freeform` crop type.

---

- Add a ready-made Image media type in one `drush en`.
- Let editors drop a JPEG into the media library and have Drupal file it as an Image.
- Give every new image field on the site an Entity Browser widget automatically.
- Let editors pick an existing image from the library instead of re-uploading it.
- Crop images freeform at upload time with Image Widget Crop.
- Get a `crop_<type>` image style created automatically whenever a crop type is added.
- Add a "Square" crop type and immediately have a matching image style to display it.
- Render embedded image media through the image formatter instead of a bare thumbnail.
- Restrict which image formats editors may upload via `field_media_image`'s `file_extensions`.
- Enforce minimum or maximum image resolutions with the source field's settings.
- Use the dedicated `media_browser` form mode to show a stripped-down image form in the browser.
- Give the image browser its own view (`views.view.image_browser`) that you can re-sort or filter.
- Grant `access image_browser entity browser pages` to a limited editorial role.
- Hide working images from the media library with `field_media_in_library`.
- Give images an `embedded` view display used when inserted into body text.
- Give images a `thumbnail` view display for the library grid.
- Bulk-upload a photoshoot with Lightning Media Bulk Upload.
- Include images in a media slideshow with Lightning Media Slideshow.
- Serve SVG logos through image styles, with dimensions inferred by the parent module.
- Use `MediaHelper::createFromInput($file)` in custom code and get an Image media entity for a PNG.
- Validate an uploaded image against the Image type's resolution limits with `lightning_media_validate_upload()`.
- Prefer a locally installed Cropper JS library over the CDN copy for offline or CSP-strict sites.
- Migrate legacy image fields onto media entities with `image` as the target bundle.
- Cap the number of images an entity browser can select using the field's cardinality.
- Translate image alt text and titles on a multilingual site.
