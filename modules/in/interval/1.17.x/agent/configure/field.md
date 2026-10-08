<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure an interval field

There is **no admin settings page** (`configure` is `null`). You configure per field, per
bundle, exactly like any core field.

## Field type

- id: `interval`, label "Interval".
- default widget `interval_default`, default formatter `interval_default`.
- Storage columns (`IntervalItem::schema()`): `interval` (int, medium, default `0`) and
  `period` (varchar 20, default `day`). Both `not null`; indexed.
- Properties: `interval` (integer), `period` (string). `mainPropertyName()` is `NULL`, so
  set both when writing values: `$node->field_x->setValue(['interval' => 3, 'period' => 'day'])`.
- `isEmpty()` is true when `interval` is empty (0/blank).

## Widget: `interval_default` ("Interval and Period")

Renders a number input + a period `<select>`. One setting:

| Setting | Type | Meaning |
|---|---|---|
| `allowed_periods` | array of period ids | Periods offered in the dropdown. **Empty = all periods allowed.** |

Set it on the form display component, e.g.:

```php
$fd = \Drupal::service('entity_display.repository')
  ->getFormDisplay('node', 'article', 'default');
$fd->setComponent('field_x', [
  'type' => 'interval_default',
  'settings' => ['allowed_periods' => ['day' => 'day', 'week' => 'week', 'month' => 'month']],
])->save();
```

Config schema for the setting (`config/schema/interval.schema.yml`):
`field.widget.settings.interval_default` → `allowed_periods` is a sequence of strings.
The settings summary prints `Allowed periods: <list>`.

## Formatters (view display)

| Formatter id | Label | Output example (3 + `week`) |
|---|---|---|
| `interval_default` | Plain | `3 Weeks` (uses `formatPlural`, singular/plural labels, translatable) |
| `interval_php` | PHP date/time | `21 days` (result of `buildPHPString()` = count × multiplier + php unit) |
| `interval_raw` | Raw value | `3 Weeks` (same text as Plain but emitted via `#markup`) |

Plain/Raw wrap the value; Plain uses a `<div class="interval-value">`. None take settings.

## Drush / scripted creation

```bash
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  FieldStorageConfig::create(["field_name"=>"field_x","entity_type"=>"node","type"=>"interval"])->save();
  FieldConfig::create(["field_name"=>"field_x","entity_type"=>"node","bundle"=>"article","label"=>"Duration"])->save();
'
```
