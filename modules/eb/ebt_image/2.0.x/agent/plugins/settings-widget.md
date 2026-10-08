<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EbtSettingsImageWidget (ebt_settings_image field widget)

`src/Plugin/Field/FieldWidget/EbtSettingsImageWidget.php`

Annotation `@FieldWidget(id = "ebt_settings_image", field_types = {"ebt_settings"})`, label "EBT Image settings". Extends ebt_core's `EbtSettingsDefaultWidget`, so it inherits all EBT Core design controls (CSS box, background, edge-to-edge, container width, etc.) and adds image-specific options. It is the widget assigned to `field_ebt_settings` in the bundle's default form display.

## `formElement()`
Calls `parent::formElement()`, then builds an `$image_styles` option list = `['none' => 'Original image']` plus every `ImageStyle::loadMultiple()` entry (key → label), and appends these elements under `$element['ebt_settings']`:

| Key | Type | Default | Purpose |
|-----|------|---------|---------|
| `image_style` | select (image styles) | `none` | Style applied to the inline block image (used by `_ebt_image_apply_image_style`). Weight 4. |
| `image_lightbox` | checkbox | FALSE | Enable GLightbox popup on click. Weight 5. |
| `lightbox_image_style` | select (image styles) | `none` | Style for the image shown inside the lightbox (used by `_ebt_image_apply_lightbox_image_style`). Weight 6. |
| `greyscale` | checkbox | FALSE | Adds `greyscale` class to the block wrapper. Weight 7. |
| `colorful_on_hover` | checkbox | FALSE | Adds `colorful-on-hover` class (reveal color on hover when greyscale). Weight 8. |

Defaults read from `$items[$delta]->ebt_settings[...] ?? <fallback>`.

## `massageFormValues()`
Ensures every value has an `ebt_settings` key (`$value += ['ebt_settings' => []]`) so empty submissions store a well-formed structure.

## Notes
- These setting values are consumed by the preprocess helpers and Twig templates; they are select/checkbox values (image-style machine names, booleans), not free-text rendered into markup.
- No storage schema is defined here — the `ebt_settings` field type and its schema come from ebt_core.
