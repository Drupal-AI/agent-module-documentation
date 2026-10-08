<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ebt_video — `ebt_settings_video` field widget

The module's only PHP class. It configures the editing UI for the shared `ebt_settings` design
field on the EBT Video block; it does **not** handle the video itself (that is the core
`media_library_widget` on `field_ebt_video`).

## Plugin

`src/Plugin/Field/FieldWidget/EbtSettingsVideoWidget.php`

```
@FieldWidget(
  id = "ebt_settings_video",
  label = @Translation("EBT Video settings"),
  field_types = { "ebt_settings" }
)
```

- Extends `Drupal\ebt_core\Plugin\Field\FieldWidget\EbtSettingsDefaultWidget` — the entire design
  form (margin, padding, border, colors, background, breakpoints, container width, edge-to-edge)
  is inherited from EBT Core.
- `formElement()` just calls `parent::formElement(...)` and returns the element unchanged — this
  subclass exists only to give EBT Video its own widget id so the form display can target it.
- `massageFormValues()` normalizes each delta with `$value += ['ebt_settings' => []]` before save,
  guaranteeing the `ebt_settings` key is present.

## Wiring

Selected in `core.entity_form_display.block_content.ebt_video.default` for `field_ebt_settings`
(`type: ebt_settings_video`). On display, `field_ebt_settings` uses the `ebt_settings_default`
formatter (EBT Core), which emits the block's design CSS. No config schema is shipped here; the
`ebt_settings` field type and its schema live in `ebt_core`.
