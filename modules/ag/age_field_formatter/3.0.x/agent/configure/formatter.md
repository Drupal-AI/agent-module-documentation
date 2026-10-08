<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Age formatter

No global settings page (`configure` null). Pick **Age formatter** as the format for a `datetime` field on an entity's **Manage display** tab (`admin/structure/.../display`), then open the cog to set options. Settings persist in the `entity_view_display` config entity.

## Settings keys

Defaults from `defaultSettings()`; schema `field.formatter.settings.age_field_formatter`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `age_format` | select | `birthdate` (label mode) | Display mode: `birthdate` → `date (Age: NN)`; `birthdate_nolabel` → `date (NN)`; `age_only` → just `NN`. |
| `year_suffix` | bool | `true` | Append a pluralized `year`/`years` after the number (via `formatPlural()`). |
| `date_format` | string (PHP `date()` tokens) | `Y-m-d\TH:i:s` (`DATETIME_STORAGE_FORMAT`) | Format for the accompanying date; ignored/hidden when `age_format` is `age_only`. |
| `timezone_override` | string | `''` | Inherited core formatter setting; timezone used when rendering the date. |

Note: only `age_format` and `year_suffix` are declared in the module's own config schema; `date_format` and `timezone_override` are also read/stored via the formatter defaults.

## Behavior

- Age = `(new DrupalDateTime($item->date))->diff(new DrupalDateTime())->y` — completed years to today.
- Output is escaped with `Html::escape()` then `nl2br()`.
- `age_only` mode returns just the age (no forced "Age:" label prefix).
- `js/age_field_formatter.js` hides the Date/time format field in the settings form when the selected mode is `age_only`.

## Set the formatter with Drush (example)

```php
// drush php:eval — show age-only, no suffix, on node.person field_birthdate in the default view mode
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.person.default');
$vd->setComponent('field_birthdate', [
  'type' => 'age_field_formatter',
  'label' => 'hidden',
  'region' => 'content',
  'settings' => ['age_format' => 'age_only', 'year_suffix' => TRUE, 'date_format' => 'F j, Y'],
])->save();
```
