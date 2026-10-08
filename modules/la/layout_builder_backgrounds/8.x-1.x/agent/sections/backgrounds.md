<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Section backgrounds — mechanism reference

All logic lives in `layout_builder_backgrounds.module` (no `src/`, no config, no library).

## The three moving parts

### 1. Form alter (edit UI)

`layout_builder_backgrounds_form_layout_builder_configure_section_alter(&$form, $form_state, $form_id)`

- Reads current values from the layout's configuration array:
  `$form_state->getFormObject()->getLayout()->getConfiguration()['layout_builder_backgrounds']`
  → `color`, `media`, `position` (position defaults to `'center center'`).
- Adds a `#type => details` **Background** group (`#open`, weight 95) with:
  - `color` — `#type => textfield`. Description points at MDN CSS `<color>`; examples `#336699`,
    `red`, `rgba(0,0,0,.5)`.
  - `media` — `#type => media_library`, `#allowed_bundles => ['image']`. Requires the
    `media_library_form_element` contrib module.
  - `position` — `#type => select` with nine fixed options.
- Bumps `$form['actions']['#weight']` to 100 and **unshifts** `_layout_builder_backgrounds_section_form_submit`
  onto `$form['#submit']` so it runs **before** core's handler (which persists section/component
  data to the Layout Builder tempstore).

The docblock types the form object as `\Drupal\layout_builder_styles\Form\ConfigureSectionForm` —
this is why `layout_builder_styles` is a hard dependency; the alter targets the
`layout_builder_configure_section` form as that module presents it.

### 2. Submit handler (persistence)

`_layout_builder_backgrounds_section_form_submit(array $form, FormStateInterface $form_state)`

- Reads `['background','color']`, `['background','media']`, `['background','position']` from form
  state.
- **If `color` OR `media` is truthy**, merges
  `['layout_builder_backgrounds' => ['color'=>…, 'media'=>…, 'position'=>…]]` into the layout
  configuration and calls `->getLayout()->setConfiguration($config)`.
- **Else** `unset($config['layout_builder_backgrounds'])` — so a section reverts to no background
  when both fields are emptied.
- Storage: this is the **section's** layout settings inside Layout Builder **section storage**.
  For a default layout it is the view-display's third-party/section config; for an overridden
  layout it lives in the entity's `layout_builder__layout` field. It is **not** a separate config
  entity and has **no schema**.

### 3. Preprocess (render)

`layout_builder_backgrounds_preprocess_layout(&$variables)`

- Guard: only runs when `$variables['settings']['layout_builder_backgrounds']` is set.
- Always appends class `layout-builder-backgrounds` to `$variables['attributes']['class']`.
- Builds `$variables['attributes']['style']` (an array of declaration strings):
  - `color` present → `'background-color: ' . $color . ';'`.
  - `media` present → `Media::load($media)`; if it loads,
    `$media_entity->getSource()->getSourceFieldValue($media_entity)` gives the file ID,
    `File::load($fid)->createFileUrl()` gives the URL, then four declarations are added:
    `background-image: url(<url>);`, `background-position: <position>;`,
    `background-size: cover;`, `background-repeat: no-repeat;`.
- The layout template renders `{{ attributes }}`, so these declarations become the wrapper's inline
  `style="…"` attribute.

## Edge cases / limitations

- **Original file only.** No image style, no responsive image — the raw uploaded image is used.
  Fit is fixed at `cover` / `no-repeat`.
- **Missing file.** If `File::load($fid)` returns NULL (file deleted but media reference remains),
  `->createFileUrl()` is called on NULL → PHP error at render.
- **No cache metadata** is added for the media entity; changing the file may not invalidate the
  rendered layout's cache.
- **Position** is constrained to the nine `select` values in the edit UI.
- Combining a color and an image renders both declarations; the color shows through transparency or
  before the image paints.
