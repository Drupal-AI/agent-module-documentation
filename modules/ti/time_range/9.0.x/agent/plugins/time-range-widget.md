# The `time_range` field widget

`Drupal\time_range\Plugin\Field\FieldWidget\TimeRangeWidget` (id `time_range`, label
"Time range") — the module's only plugin. It handles the core **`daterange`** field type
(created as a "Date range" field with the *Date and time* type).

## What it does

Extends `TimeRangeWidgetBase` → core `DateRangeWidgetBase`. In `formElement()` it forces both
the start (`value`) and end (`end_value`) sub-elements to be **time-only**:

- `#date_date_element = 'none'`, `#date_date_format = 'none'` (no date input)
- `#date_time_element = 'time'`, `#date_time_format` = pattern of the `html_time` date format
  (an HTML5 `<input type="time">`)

The end input is cloned from the start, then titled with the two settings. Core Date range
still validates that end ≥ start. **No data is stored by the module** — the value is a normal
Date range field value; only the *editing* form changes.

## Settings

| Setting | Default | Effect |
|---|---|---|
| `start_label` | `Start time` | Title of the start (`value`) time input |
| `end_label` | `End time` | Title of the end (`end_value`) time input |

Schema: `field.widget.settings.time_range` (two `label` strings). The widget's
`settingsSummary()` prints both labels on the *Manage form display* row.

## Turn it on (UI)

1. Add a **Date range** field to a bundle; choose **Date type: Date and time** (field type
   `daterange`).
2. Go to the bundle's *Manage form display*.
3. Set that field's widget to **Time range**; open the cog to set *Start time label* /
   *End time label*; **Update**, then **Save**.

## Where the choice is stored

`core.entity_form_display.<entity_type>.<bundle>.<form_mode>`:

```yaml
content:
  field_shift:
    type: time_range
    settings:
      start_label: 'Shift start'
      end_label: 'Shift end'
    weight: 5
    region: content
```

## Scriptable (drush php:eval)

```php
$fd = \Drupal::service('entity_display.repository')
  ->getFormDisplay('node', 'article', 'default');
$fd->setComponent('field_shift', [
  'type' => 'time_range',
  'settings' => ['start_label' => 'Shift start', 'end_label' => 'Shift end'],
  'weight' => 5, 'region' => 'content',
])->save();
```

Read back:

```bash
drush cget core.entity_form_display.node.article.default content.field_shift
# look for type: time_range and settings.start_label / settings.end_label
```

## No plugin types, no API

The module defines no plugin manager, service, hook, or API. There is nothing to subclass —
to change behavior, pick the widget and set its two labels (config), or write your own widget.
