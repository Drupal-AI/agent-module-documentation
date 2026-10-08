<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Token Value — agent index

A Field API field type (`field_token_value`) whose stored value is generated from a **token
string** on every entity save. Depends on `token`. No configure route (per-field settings only),
no permissions, no Drush.

- **Add/configure the field: field settings (`field_value`, `remove_empty`), widget, formatter
  (`wrapper`, `link`), token browser** → [configure/field.md](configure/field.md)
- **How the value is generated (`hook_entity_presave` → `FieldValueGenerator` → `Token::replace`)** →
  [api/generator.md](api/generator.md)
- **Wrapper plugin type: define an HTML wrapper in `EXTENSION.field_token_value.yml`** →
  [plugins/wrappers.md](plugins/wrappers.md)
- **Alter hooks (`field_token_value_output_alter`, `field_token_value_wrapper_info_alter`)** →
  [hooks/hooks.md](hooks/hooks.md)

Key facts: field type `field_token_value`, widget `field_token_value_default` (a hidden input —
editors never type the value), formatter `field_token_value_text`. Field instance settings:
`field_value` (the token string, stored under `field.field.<...>.settings.field_value`) and
`remove_empty` (clear unresolved tokens). Formatter settings: `wrapper` + `link`.
