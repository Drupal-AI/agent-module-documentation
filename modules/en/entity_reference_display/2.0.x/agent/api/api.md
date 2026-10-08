<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API: ids, storage, settings, reading & setting values

## Plugin ids

| Kind | id | Notes |
|---|---|---|
| Field type | `entity_reference_display` | label "Display mode", category `reference`, default_widget `options_select`, default_formatter `list_default`. Class `EntityReferenceDisplayItem` implements `OptionsProviderInterface`. |
| Formatter | `entity_reference_display_default` | label "Selected display mode"; for field types `entity_reference` + `entity_reference_revisions`; extends core `EntityReferenceEntityFormatter`. |

There are **no** custom widgets — the module registers `entity_reference_display` onto every
core/contrib widget and formatter that already supports `list_string`
(`hook_field_widget_info_alter` / `hook_field_formatter_info_alter`).

## Storage schema

One column, `value`: `varchar(255)`, holding a single **view-mode machine name** string
(e.g. `default`, `teaser`, `full`). `isEmpty()` is true when the value is NULL or `''`.
Cardinality is locked to 1 (enforced by disabling the storage form's cardinality control).

## Field settings (defaults)

```php
['exclude' => [], 'negate' => FALSE]
```

- `exclude`: array of view-mode machine names to drop from the options.
- `negate`: when TRUE, `exclude` is treated as the *only allowed* modes.

Options come from `entity_display.repository` → `getAllViewModes()`, flattened & deduped
across entity types, `asort()`ed, with `['default' => 'Default']` prepended. The item class
exposes them through `getPossibleOptions()` / `getSettableOptions()` (OptionsProviderInterface).

## Formatter settings

```php
['display_field' => NULL] + EntityReferenceEntityFormatter::defaultSettings()
```

`display_field` = machine name of the `entity_reference_display` field whose value becomes
the view mode. If empty, the first display-mode field on the bundle is used. `isApplicable()`
returns TRUE only when the bundle has at least one `entity_reference_display` field.

## Read / set the value in code

```php
// Read the chosen display mode off a host entity.
$mode = $node->get('field_display_mode')->value;   // e.g. "teaser"

// Set it.
$node->set('field_display_mode', 'teaser');
$node->save();
```

## Detecting the field type programmatically

```php
$fields = \Drupal::service('entity_field.manager')->getFieldDefinitions('node', 'article');
foreach ($fields as $name => $def) {
  if ($def->getType() === 'entity_reference_display') { /* it's a display-mode field */ }
}
// or load field config entities of this type:
\Drupal::entityTypeManager()->getStorage('field_config')
  ->loadByProperties(['field_type' => 'entity_reference_display']);
```

## Update hook

`entity_reference_display_update_8001()` normalises the `negate` setting from int to bool on
existing fields — relevant only when upgrading older instances.
