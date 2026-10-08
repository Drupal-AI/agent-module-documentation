<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `condition_field` field type, widget & formatter

No admin settings page — configuration is entirely per field instance.

## Field type

`ConditionFieldItem` (`@FieldType id="condition_field"`, label "Condition plugin field").
- Default widget: `condition_field_default`; default formatter: `condition_field_string`.
- Storage: one column `conditions` (`blob`, `serialize = TRUE`) — a map of
  `condition_id => condition_configuration`. Main property name: `conditions`.
- Schema for a stored value: `field.value.condition_field` (`conditions` sequence of
  `condition.plugin.[id]`).

## Per-field setting: `enabled_plugins`

Field settings schema: `field.field_settings.condition_field` → `enabled_plugins` (a map of
condition-plugin id => bool). The field settings form (`fieldSettingsForm()`) lists all condition
plugins whose context requirements are currently met, minus the always-skipped ones, as checkboxes.
Default: `[]` (none — you must enable at least one for the widget to show anything).

Always skipped (`ConditionFieldItem::SKIP_CONDITION_IDS`): `entity_bundle:webform_submission`,
`node_type`, `current_theme`, `webform`; plus `language` until the site is multilingual.

## Add the field (drush)

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;
FieldStorageConfig::create([
  'field_name' => 'field_conditions', 'entity_type' => 'node', 'type' => 'condition_field',
])->save();
FieldConfig::create([
  'field_name' => 'field_conditions', 'entity_type' => 'node', 'bundle' => 'article',
  'label' => 'Display conditions',
  'settings' => ['enabled_plugins' => ['request_path' => 'request_path', 'user_role' => 'user_role']],
])->save();
```

Read the enabled plugins back:

```bash
drush cget field.field.node.article.field_conditions settings.enabled_plugins
```

## Widget — `condition_field_default` ("Conditions")

Renders each enabled condition's own `buildConfigurationForm()` inside **vertical tabs** (attaches
`block/drupal.block`), closely following `Drupal\block\BlockForm::buildVisibilityInterface()`. It
tweaks a few conditions' labels/negate UI (Roles, Pages with show/hide radios, Language). Only
conditions listed in the field's `enabled_plugins` appear.

## Formatter — `condition_field_string`

Outputs an item list of `"<label>: <summary>"` for each stored condition (using each condition
plugin's `summary()`), so the rendered entity shows a readable list of its conditions.

`ConditionFieldItem::preSave()` filters out conditions left at their default configuration, so only
meaningfully-set conditions are stored.
