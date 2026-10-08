<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Display Label — agent index

Lets a field render a **different label on display** than on its edit form. The whole module is two
hooks: it adds a "Display label" textfield to `field_config_edit_form`, stores the value as a
**third-party setting** on the `FieldConfig`, and swaps `$variables['label']` in
`hook_preprocess_field()`. Depends on `field`. No config page, permission, service, plugin, or Drush.

- **Set/read a field's display label, where it is stored, how it renders** →
  [configure/display-label.md](configure/display-label.md)

Key facts:
- Storage: `field.field.<entity>.<bundle>.<field>` →
  `third_party_settings.field_display_label.display_label: "<text>"`.
- Set programmatically: `$fieldConfig->setThirdPartySetting('field_display_label', 'display_label', 'My Label')->save();`
  (or unset to fall back to the default label).
- Applied by `FieldDisplayLabelHooks::preprocessField()` (`hook_preprocess_field`): overwrites the
  rendered `label` when the setting is non-empty. It is **per field instance / per bundle**.
- Config schema key: `field.field.*.*.*.third_party.field_display_label` (`display_label`, type `label`).
