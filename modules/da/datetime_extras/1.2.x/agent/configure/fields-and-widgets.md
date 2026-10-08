<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field type, widgets & formatter

No global config. You select these plugins per field on the bundle's *Manage form display*
(widgets) and *Manage display* (formatter), or set them directly in
`entity_form_display` / `entity_view_display` config. The time-only field is added like any
field at *Manage fields*.

## Field type: `time_only_field`

Stores **only a time** (extends core `DateTimeItem`, `datetime_type: time`). Storage setting
`datetime_type` is fixed to `time`. Default widget and formatter are both
`time_only_field_default`.

Create with drush:

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;
FieldStorageConfig::create([
  'field_name' => 'field_opening_time', 'entity_type' => 'node',
  'type' => 'time_only_field', 'settings' => ['datetime_type' => 'time'],
])->save();
FieldConfig::create([
  'field_name' => 'field_opening_time', 'entity_type' => 'node',
  'bundle' => 'article', 'label' => 'Opening time',
])->save();
```

Formatter `time_only_field_default` settings: `format_type` (a date format id),
`timezone_override`.

## Widgets for core `datetime` fields

Set these as the widget on a core **datetime** field in *Manage form display*.

- **`datetime_datelist_no_time`** — "Select list, no time". Date-part select lists with
  **no** time element (core's datelist always includes time). Settings: `increment`,
  `date_order`, `time_type`, `date_year_range`.
- **`datatime_configurable`** — "Configurable Date and time". Settings: `year_range`
  (e.g. `-3:+3`), `increment` (minutes).
- **`datatime_extras_configurable_list`** — "Configurable list" — **deprecated**; avoid on
  new fields.

## Widget for core `daterange` fields

- **`daterange_duration`** — "Date and time range with duration". Editor sets a start, then
  either an absolute end (core behaviour) or a **duration** offset. Settings:
  `default_duration` (`y/m/d/h/i/s`), `duration_granularity`, `time_increment`.
  **Requires the contrib `duration_field` module** (>= 8.x-2.0-rc3); until it is enabled the
  widget is removed by `hook_field_widget_info_alter()` and will not appear in the widget list.

## Set a widget in config (scriptable)

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$fd->setComponent('field_when', [
  'type' => 'datetime_datelist_no_time', 'region' => 'content', 'weight' => 10,
  'settings' => ['date_order' => 'YMD', 'time_type' => '24'],
])->save();
```

Read back: `drush cget core.entity_form_display.node.article.default content.field_when`
(look at `type` and `settings`). Config schema keys are in
`config/schema/datetime_extras.schema.yml`.
