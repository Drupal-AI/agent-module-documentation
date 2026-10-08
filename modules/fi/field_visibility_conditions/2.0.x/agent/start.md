# Field Visibility Conditions — agent index

Attach Condition plugins to individual fields so a field is shown/hidden on **entity forms** when
its conditions evaluate true. Built on the `conditions_helper` module. No plugin types of its own,
no Drush.

- **The global settings page, per-field third-party settings, config schema, how evaluation works** →
  [configure/conditions.md](configure/conditions.md)
- **The `..._available_conditions_alter` developer hook** → [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Global "which conditions are available" config: `field_visibility_conditions.settings`
  (`enabled_conditions`), form route `field_visibility_conditions.settings`
  (`/admin/config/content/field-visibility-conditions`), permission
  `administer field visibility conditions` (`restrict access: TRUE`).
- Per-field conditions stored as field-config **third-party settings** key
  `field_visibility_conditions` (schema `field.field.*.*.*.third_party.field_visibility_conditions`,
  sequence of `condition.plugin.*`).
- Enforcement: `src/FormAlters.php` via `hook_form_alter` + `hook_inline_entity_form_entity_form_alter`
  sets `$form[$field_name]['#access'] = FALSE` when `conditions_helper.evaluator` returns false.
- **Not a security boundary.** This controls whether a field widget renders on a form (edit-form
  convenience), not read access to stored data; a field with no conditions renders normally.
