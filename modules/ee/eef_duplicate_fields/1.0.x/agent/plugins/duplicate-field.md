<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Duplicate Field plugin

`src/Plugin/ExtraFieldType/DuplicateFieldPlugin.php` —
`@ExtraFieldType(id = "duplicate_field", label = "Duplicate Field")`, extends
`DuplicateFieldPluginBase`. Renders a **second copy of a field already on the same
entity/bundle**, using an independently chosen field formatter.

## Install / enable

- `drush en eef_duplicate_fields` (pulls in `entity_extra_field`).
- No config, no permissions of its own. Adding/placing the extra field uses
  Entity Extra Field's UI on *Structure → …→ Manage display → Add extra field* (gated by the
  core Field UI display-management permission for that entity type). Choose field type
  **Duplicate Field**.

## Configuration form (`buildConfigurationForm()`)

Built with AJAX-rebuilt selects (`extraFieldPluginAjax()`), keyed under `field_type_config`:

1. `field_name` — required select, **Source Field**. Options from
   `getFieldOptions()` (all field definitions of the target entity type + bundle, label +
   machine name). If a saved `field_name` no longer exists, a `messages--warning` markup
   notice is shown (message built with `t()` / `%field` placeholder).
2. `formatter_type` — required select, **Formatter**, options from
   `getFormatterOptions($field_name)` = `FormatterPluginManager::getOptions($field_type)` for
   the chosen field's type.
3. `formatter_settings` — a `details` element built by `buildFormatterSubform()`: it
   `createInstance()`s the formatter (`view_mode => '_custom'`, `label => 'hidden'`) and
   embeds its `settingsForm()`, plus any `hook_field_formatter_third_party_settings_form`
   elements under `formatter_settings[third_party_settings]`. On failure it renders
   `t('Unable to load formatter settings.')`.

`submitConfigurationForm()` calls `extractThirdPartySettings()` (reads
`formatter_settings[third_party_settings]` from raw form values), then `parent::submit`
(`$this->configuration = $form_state->cleanValues()->getValues()`), then re-stores
`third_party_settings` so it is always preserved.

## Config keys (stored by entity_extra_field)

`field_name`, `formatter_type`, `formatter_settings` (array), `third_party_settings` (array).
No config schema ships with this module.

## Render (`build(EntityInterface $entity, EntityDisplayInterface $display)`)

- Reads `field_name` / `formatter_type` / `formatter_settings`; returns `[]` if either the
  field or formatter is unset.
- Delegates to base `renderFieldWithFormatter()`: requires a `FieldableEntityInterface` that
  `hasField($field_name)`, checks **`$field->access('view')`**, returns `[]` when the field is
  empty, else returns `$field->view(['type' => $formatter_type, 'settings' => …, 'label' =>
  'hidden', 'third_party_settings' => …])`. Output and cache metadata come from core's
  formatter pipeline.

## Dependencies (`calculateDependencies()`)

Adds `config` deps `field.field.{entity_type}.{bundle}.{field_name}` and
`field.storage.{entity_type}.{field_name}`, so the extra field is removed when the source
field/storage is deleted.
