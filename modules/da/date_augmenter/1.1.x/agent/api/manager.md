<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin manager, config structure & formatter integration

## The manager service

`plugin.manager.dateaugmenter` → `\Drupal\date_augmenter\Plugin\DateAugmenterManager`
(extends `DefaultPluginManager`). Discovery: `Plugin/DateAugmenter`, interface
`DateAugmenterInterface`, attribute + annotation, cache key `date_augmenter_plugins`,
alter id `date_augmenter_plugin_info`.

Key methods:

- `getDefinitions()` — all discovered augmenter definitions (empty until an augmenter-providing
  contrib module is installed).
- `getActivePlugins(?array $config)` — instantiates only the augmenters whose `status` is truthy in
  `$config`, **sorted ascending by** `$config['weights']['order'][<id>]['weight']`. Returns
  `[] ` when `$config` is empty or has no enabled statuses.
- `DateAugmenterManager::getThirdPartyFallback($entity, $property, $default = NULL)` (static) —
  reads a value stored as a third-party setting: uses `$entity->getThirdPartySetting('date_augmenter',
  $property, $default)` when available (field definitions, rule objects), else `$entity->getSetting()`.

## Config structure (formatter third-party settings)

Stored on the entity view display formatter component under the `date_augmenter` namespace. Schema
`config/schema/date_augmenter.schema.yml`:

- `field.formatter.third_party.date_augmenter` → mapping with optional `instances` and `rule`, each
  of type `date_augmenter_plugins`.
- `date_augmenter_plugins` →
  - `status`: sequence of booleans keyed by augmenter id (which are enabled).
  - `weights.order`: sequence keyed by augmenter id → `{ weight: int }` (ordering).
  - `settings`: sequence keyed by augmenter id → per-plugin settings (`date_augmenter.plugin.<id>`).

A formatter whose `supportsDateAugmenter()` returns an **array of set names** (e.g.
`['instances' => t('Individual Dates'), 'rule' => t('Recurring Rule')]`) gets a separate
config block per set; if it returns a plain truthy value, the config is stored flat (no set keys).

Example stored value:

```yaml
third_party_settings:
  date_augmenter:
    instances:
      status:
        add_to_calendar: true
      weights:
        order:
          add_to_calendar:
            weight: 0
```

## Making a formatter opt in

The alter `date_augmenter_field_formatter_third_party_settings_form($plugin, $field_definition,
$form_mode, $form, $form_state)` only injects the augmenter UI when the formatter plugin has a
`supportsDateAugmenter()` method returning a truthy value. So to make a custom date formatter
augmenter-aware, add that method; the module then renders the enabled-augmenters checkboxes, the
weight table, and per-augmenter settings tabs automatically, and persists them as the third-party
settings above. Contrib **Smart Date** is the primary formatter that already supports this.
