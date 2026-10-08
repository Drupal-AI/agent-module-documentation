# Autofill — agent index

Copies one `string` field's value into another as the user types, on entity edit forms.
Implemented entirely via core field-widget third-party settings + a JS behavior. No
dependencies beyond core, no admin page (`configure` null), no permissions, no Drush, no plugin
types. Provides config schema `field.widget.third_party.autofill`.

- **Enabling it per field on Manage form display, the source-field option list, where settings
  are stored, and the JS mirroring rules** → [configure/widget.md](configure/widget.md)

Key facts:
- Adds an "Enable Autofill" checkbox + "source field" select to any `string`-field widget via
  `hook_field_widget_third_party_settings_form` (provider `autofill`: `enabled`, `source_field`).
- `hook_field_widget_single_element_form_alter` attaches library `autofill/autofill` and
  `drupalSettings.autofill.field_mapping[target] = source`.
- `js/autofill.js` (`core/once`) mirrors source `input` → target, but stops once the target is
  edited (`keypress`) or already differs at load. Single-value `string` fields only.
