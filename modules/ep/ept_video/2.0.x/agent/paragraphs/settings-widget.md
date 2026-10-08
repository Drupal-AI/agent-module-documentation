<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `ept_settings_video` field widget

`Drupal\ept_video\Plugin\Field\FieldWidget\EptSettingsVideoWidget` (annotation id
`ept_settings_video`, field type `ept_settings`). This is the module's **only** PHP class. It
extends `ept_core`'s `EptSettingsDefaultWidget` and **adds no controls of its own** — its
`formElement()` just calls `parent::formElement()` and returns it. It therefore inherits the whole
EPT **Design options** / **Title options** panel from ept_core:

- **ID (Anchor)** — free-text; applied as the wrapper `id` (Html::escape'd in ept_core's
  `entity_view_alter`).
- **Margin / Border / Padding** boxes (top/right/bottom/left) — validated numeric-only
  (`validateBoxElement`).
- **Border color / Background color / (video/image) Overlay color** — validated as hex
  (`Color::validateHex`, `validateColorElement`).
- **Border style** (select), **Border radius** (select), **Background Image Style** (select),
  **Background Image Position** (select), **Edge to Edge** (checkbox), **Container Max Width**
  (select).
- **Background Image/Video** media library reference (image / oembed:video / video_file bundles),
  with background-video options (autoplay, mute, loop, overlay, etc.) and background-image options.
- **Custom Background Position** and **Custom Background Size** — free-text CSS values.
- **Additional CSS classes** — free-text.
- **Title options**: title wrapper tag (select h1–h5/none), strip-tags checkbox.

The widget is set for `field_ept_settings` in the default form display; it appears on the paragraph
edit form's **Settings** tab (closed by default). It attaches ept_core's `colorpicker` and
`ept_settings` libraries and, if `field_group` is enabled, `field_group/element.horizontal_tabs`.

## `massageFormValues()`

The only overridden method beyond `formElement()`. It ensures every value has an `ept_settings`
key (`$value += ['ept_settings' => []]`) — identical to the parent's behavior.

## Who can set these

Anyone with permission to edit the host content / paragraph (a content editor). Most inherited
controls are constrained (numeric boxes, hex-validated colors, fixed-option selects). The
**free-text** fields — ID anchor, additional classes, and the **Custom Background Position / Custom
Background Size** values — are the exception; they flow into ept_core's `GenerateCSS` service, which
runs each value through `Html::escape()` before concatenating it into the inline `<style>` block
that the template prints with `{{ styles|raw }}` (see theme/rendering.md).

## Reading/writing in PHP

The value is stored on the paragraph's `field_ept_settings` as a nested array under `ept_settings`
(design options live under `design_options`). Example:

```php
$paragraph->field_ept_settings->ept_settings = [
  'design_options' => [
    'box1' => ['margin_top' => '20', 'margin_bottom' => '20'],
    'other_settings' => [
      'background_color' => '#000000',
      'container_width' => 'large',
      'edge_to_edge' => 0,
    ],
    'additional_classes' => 'my-video-section',
  ],
];
$paragraph->save();
```
