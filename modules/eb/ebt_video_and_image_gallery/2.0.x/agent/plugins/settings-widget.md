<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field widget: ebt_settings_video_and_image_gallery

`src/Plugin/Field/FieldWidget/EbtSettingsVideoAndImageGalleryWidget.php`

```
@FieldWidget(
  id = "ebt_settings_video_and_image_gallery",
  label = "EBT Video and Image Gallery settings",
  field_types = { "ebt_settings" }
)
```

Extends `Drupal\ebt_core\Plugin\Field\FieldWidget\EbtSettingsDefaultWidget`. It is the widget for the
block type's `field_ebt_settings` field (an `ebt_settings` field type from EBT Core). Constructor injects
`config.factory` and loads `ebt_core.settings` into `$this->config` (loaded but not otherwise used here).

## formElement()

Calls the parent (which renders EBT Core's design options — spacing/border/background/container) and then
adds, under `ebt_settings`:

- `pass_options_to_javascript` — hidden, value `FALSE` (this block does not pass options to JS).
- `image_gallery_styles` — an `<h3>` "Gallery styles:" heading (`html_tag`, weight -21).
- `styles` — `radios`, weight -20, default `four_columns` (from `$items[$delta]->ebt_settings['styles']`).
  Fixed `#options` (no free text): `one_column`, `two_columns`, `three_columns`, `four_columns`,
  `five_columns`, `fixed_size_image`, `fluid_grid`, `featured_images_grid`.
- Re-weights `design_options` to -32.

The chosen `styles` value is later emitted as a CSS class in the block templates to select the grid
layout (see blocks/video-and-image-gallery.md); it is constrained to the radio options above.

## massageFormValues()

Ensures every value has an `ebt_settings` key (`$value += ['ebt_settings' => []]`) before save.

The widget is assigned to `field_ebt_settings` in the block's form display
(`core.entity_form_display.block_content.ebt_video_and_image_gallery.default.yml`). The block's *view*
display uses the plain `ebt_settings_default` formatter for that field.
