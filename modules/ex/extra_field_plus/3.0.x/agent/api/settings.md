<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Reading settings, the manager service, Layout Builder

## Reading configured settings from your plugin

Instance methods (on `ExtraFieldPlusDisplayInterface`, via `ExtraFieldPlusDisplayTrait`):

| Method | Returns |
|---|---|
| `getEntityExtraFieldSettings(): array` | all settings for the current entity instance/view mode |
| `getEntityExtraFieldSetting(string $key)` | one setting value (or NULL) |

Static helpers (when you have the field id / entity type / bundle / view mode):

| Method | Returns |
|---|---|
| `getExtraFieldSettings($field_id, $entity_type_id, $bundle, $view_mode='default'): array` | merged defaults + stored settings |
| `getExtraFieldSetting($field_id, $key, $entity_type_id, $bundle, $view_mode='default')` | one setting |
| `getDefaultExtraFieldSettings(): array` | the plugin defaults |
| `getExtraFieldSettingsForm(...)` | the settings form with defaults applied |
| `getExtraFieldSettingsSummary(...)` | the summary render array |
| `getExtraFieldComponentId($field_id): string` | the `extra_field_<id>` machine name |
| `getExtraFieldComponentType(): string` | `'extra_field'` |

`getExtraFieldSettings()` loads the `entity_view_display` for the given
type/bundle/view_mode (falling back to `default` if that view mode has no display), reads the
component's `settings`, and merges them over `defaultExtraFieldSettings()`.

## The plugin manager service

Service id **`plugin.manager.extra_field_plus_display`** → class
`ExtraFieldPlusDisplayManager` (extends Extra Field's `ExtraFieldDisplayManager`),
`PLUGIN_INTERFACE = ExtraFieldPlusDisplayInterface`.

```php
$m = \Drupal::service('plugin.manager.extra_field_plus_display');
$m->fieldInfo();                                   // adds ['plugin_id'] per extra field
$m->getSettings($pluginId, $field_id, $entity_type, $bundle, $view_mode);
$m->getSettingsForm($pluginId, $field_id, $entity_type, $bundle, $view_mode);
$m->getSettingsSummary($pluginId, $field_id, $entity_type, $bundle, $view_mode);
```

It reuses Extra Field's discovery: plugins in `*/src/Plugin/ExtraField/Display`, annotation
`@ExtraFieldDisplay`; `fieldInfo()` decorates the info array with each `plugin_id`.

## Layout Builder support

When the display is Layout Builder-enabled, settings are **not** in a component array. They
live on the `extra_field_block` section component under the custom key
`extra_field_plus_settings`. `getExtraFieldSettings()` transparently finds the matching
section component and reads that key. The module's `hook_form_alter()` /
`extra_field_plus_form_submit()` inject and save the settings form on the Layout Builder
add/update-block forms (as `settings.third_party_settings.extra_field_plus.settings`).

## No hooks / no Drush

The module invites no `hook_*` of its own and provides no Drush commands. The extension points
are the plugin base classes and the manager service above.
