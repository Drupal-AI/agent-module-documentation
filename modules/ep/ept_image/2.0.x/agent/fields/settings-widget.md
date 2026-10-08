<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `ept_settings_image` field widget

`Drupal\ept_image\Plugin\Field\FieldWidget\EptSettingsImageWidget` (annotation id
`ept_settings_image`, field type `ept_settings`). Extends `ept_core`'s `EptSettingsDefaultWidget`,
so it inherits the whole EPT **Design options** panel (ID/anchor, margin/border/padding boxes,
border color/style/radius, background color, background media image/video + overlay, edge-to-edge,
container width, spacing) and adds five image-specific controls on top.

Set as the widget for `field_ept_settings` in the default form display; appears on the paragraph
edit form's **Settings** tab.

## Added form elements (in `formElement()`)

| `ept_settings` key | `#type` | Options / default | Consumed by |
|---|---|---|---|
| `image_style` | select | all image styles + `none` ("Original image"); default `none` | `_ept_image_apply_image_style()` — swaps `#image_style` on the rendered image formatter |
| `image_lightbox` | checkbox | default FALSE | `_ept_image_apply_lightbox_image_style()` — builds the GLightbox link |
| `lightbox_image_style` | select | image styles + `none`; default `none` | lightbox popup image URL (full-size if `none`) |
| `greyscale` | checkbox | default FALSE | adds `greyscale` class on the wrapper (template) |
| `colorful_on_hover` | checkbox | default FALSE | adds `colorful-on-hover` class (restores color on hover) |

Image-style selects are populated from `ImageStyle::loadMultiple()`.

`massageFormValues()` just ensures each value has an `ept_settings` key (`$value += ['ept_settings' => []]`).

## Who can set these

Anyone with permission to edit the paragraph (i.e. edit the host content). The added options are all
constrained input — two `select`s limited to existing image-style machine names and three
`checkbox`es — so no free-form value reaches markup from this widget. (The inherited ept_core design
options such as margins/colors are rendered as an inline `<style>` block by ept_core's
`GenerateCSS` service, which passes every value through `Html::escape()`.)

## Reading/writing in PHP

The value is stored on the paragraph's `field_ept_settings` as a nested array under `ept_settings`.
Example — enable lightbox with a `large` popup image on a paragraph:

```php
$paragraph->field_ept_settings->ept_settings = [
  'image_style' => 'medium',
  'image_lightbox' => 1,
  'lightbox_image_style' => 'large',
  'greyscale' => 0,
  'colorful_on_hover' => 0,
  // 'design_options' => [...]  // inherited ept_core keys
];
$paragraph->save();
```
