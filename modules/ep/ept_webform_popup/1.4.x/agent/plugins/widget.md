<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field widget: ept_settings_webform_popup

`src/Plugin/Field/FieldWidget/EptSettingsWebformPopupWidget.php`

```
@FieldWidget(
  id = "ept_settings_webform_popup",
  label = "EPT Webform Popup settings",
  field_types = { "ept_settings" }
)
```

Extends `Drupal\ept_basic_button\Plugin\Field\FieldWidget\EptSettingsBasicButtonWidget` (which in
turn extends `ept_core`'s default EPT settings widget). It edits the paragraph's `field_ept_settings`
value; the popup config is stored inside that `ept_settings` blob, not in separate fields.

## `formElement()`

Calls `parent::formElement()` (inherits all `ept_basic_button`/`ept_core` design + button-style
options), then customizes:

- **Removes** `ept_settings.add_nofollow` and `ept_settings.open_in_new_tab` (not meaningful for a
  dialog trigger).
- Sets hidden `ept_settings.pass_options_to_javascript = TRUE`.
- Adds `ept_settings.button_text` — textfield, **required**, default `Contact Us` (weight -10).
- Adds `ept_settings.popup_settings` details group (weight -9) containing:
  - `popup_width` — number, **required**, default `400` (weight -9).
  - `form_height` — number, optional; empty ⇒ height "auto" (weight -8).
  - `popup_title` — textfield, optional; empty ⇒ use the Webform name (weight -7).
  - `popup_type` — radios `modal` | `dialog`, default `modal` (weight -6).
  - `popup_styles` — radios, single option `default` (weight -6).
- Adds a `button_styles` `<h3>` heading label and re-weights `design_options` to -12.

## `massageFormValues()`

For each delta ensures an `ept_settings` key exists, then flattens
`values[0]['ept_settings']['link_options']` up into `values[0]['ept_settings']` (so link options are
stored at the top level of the settings blob). Returns the massaged values.

## Notes

- The widget defines form structure only; all rendering/escaping happens in the preprocess hook and
  template (see [../paragraphs/webform-popup.md](../paragraphs/webform-popup.md)). `button_text` and
  `popup_title` are plain admin-entered strings consumed there through Twig auto-escaping /
  JSON-encoding.
- The `field_ept_settings` schema lives in `ept_core` (`config/schema/ept_core.schema.yml`); this
  module ships no config schema of its own.
