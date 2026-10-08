<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Assign the Single DateTimePicker widget & its settings

There is **no configure route** (`configure: null`) and no admin settings page. You select the
widget per field, per form mode, on the entity's **Manage form display** page, or directly in the
`entity_form_display` config entity.

## Which widget for which field type

| Widget plugin id | Field types | Provided by |
|---|---|---|
| `single_date_time_widget` | `datetime` | single_datetime |
| `single_date_time_timestamp_widget` | `timestamp`, `created` | single_datetime |
| `single_date_time_range_widget` | `daterange` | single_datetime_range (submodule) |

## Where it is stored

Config entity: `core.entity_form_display.<entity_type>.<bundle>.<form_mode>`, e.g.
`core.entity_form_display.node.article.default`. The field's component looks like:

```yaml
content:
  field_event:
    type: single_date_time_widget
    settings:
      hour_format: '24h'
      allow_seconds: false
      allow_times: '15'
      allowed_hours: ''
      disable_days: {  }
      exclude_date: ''
      inline: false
      mask: false
      datetimepicker_theme: default
      start_date: ''
      min_date: ''
      max_date: ''
      year_start: ''
      year_end: ''
      allow_blank: false
    third_party_settings: {  }
```

## Widget settings (from `SingleDateTimeBase::defaultSettings()`)

| Setting | Type / options | Default | Effect |
|---|---|---|---|
| `hour_format` | `12h` \| `24h` | `24h` | 12-hour AM/PM vs 24-hour clock |
| `allow_seconds` | bool | `false` | keep seconds fixed at `00` |
| `allow_times` | `5`\|`10`\|`15`\|`30`\|`60` | `15` | minute granularity in the time picker |
| `allowed_hours` | CSV of hours e.g. `8,9,10` | `''` | restrict pickable hours (combined with granularity) |
| `disable_days` | array of `1`–`7` (Mon–Sun) | `[]` | grey out weekdays in the calendar |
| `exclude_date` | textarea, `d.m.Y` per line | `''` | block specific dates (holidays) |
| `inline` | bool | `false` | render the picker always-visible instead of a popup |
| `mask` | bool | `false` | input mask `__.__.____` |
| `datetimepicker_theme` | `default` \| `dark` | `default` | colour scheme |
| `start_date` | string | `''` | initial date shown for an empty input |
| `min_date` / `max_date` | string (e.g. `0`, `+1970/01/02`, `12:00`) | `''` | min/max pickable date-time |
| `year_start` / `year_end` | string year | `''` | range of the fast year selector |
| `allow_blank` | bool | `false` | allow clearing the value to unset a date |

## Via drush php:eval (scriptable)

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$fd->setComponent('field_event', [
  'type' => 'single_date_time_widget',
  'region' => 'content',
  'settings' => ['hour_format' => '12h', 'allow_times' => '30'] + [], // rest fall back to defaults
])->save();
```

## Read it back

```bash
drush cget core.entity_form_display.node.article.default content.field_event
# check .type == single_date_time_widget and .settings.hour_format / .allow_times
```

The chosen settings are emitted to the browser as `data-*` attributes (see
[api/form-element.md](../api/form-element.md)) and consumed by `js/drupal.single_datetime.js`.
Rendering requires the external `/libraries/jquery-datetimepicker` library.
