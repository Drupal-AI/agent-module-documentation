<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Anonymize plugins

`@UserFieldAnonymize` plugins produce the masked build for a field type. Managed by `UserFieldAnonymizePluginManager` (service `plugin.manager.user_field_anonymize`), discovered under `Plugin/UserFieldAnonymize`.

## Built-in plugins
- `user_field_anonymize_default` (`DefaultPlugin`) — generic replacement for most field types (string, text, email, integer, link, list_*, entity_reference, boolean, decimal/float, timestamp, …).
- `user_field_anonymize_date` (`DatetimePlugin`) — datetime / daterange fields.
- `user_field_anonymize_image` (`ImagePlugin`) — image fields.

Field-type → plugin mapping lives in config `user_field_anonymize.settings: field_options` and is editable on the settings form.

## Plugin surface (`UserFieldAnonymizePluginInterface` / `UserFieldAnonymizePluginBase`)
- `buildAnonymizeSubForm()` / `validateAnonymizeSubForm()` / `submitAnonymizeSubForm()` — the per-field config widget shown on the field-config edit form (where the admin sets the replacement value).
- `getAnonymizeBuild(array $values, FieldItemListInterface $items)` — rewrites `$items` to the anonymized value when a viewer is not allowed.
- The manager also exposes `hasPluginForFieldType()`, `getExcludedFieldTypes()`, and `getInstance(['field_type' => ...])`.

## Adding support for a new field type
1. Create a plugin class under `src/Plugin/UserFieldAnonymize/` with the `@UserFieldAnonymize` annotation, extending `UserFieldAnonymizePluginBase`.
2. Implement the sub-form + `getAnonymizeBuild()`.
3. On the settings form, map the target field type to your plugin id.
