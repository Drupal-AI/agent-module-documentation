# Formatter (output on Manage display)

One formatter, `datetimeday_default` (label "Default"),
`src/Plugin/Field/FieldFormatter/DateTimeDayDefaultFormatter.php`, for field type `datetimeday`. It
extends core `Drupal\datetime\Plugin\Field\FieldFormatter\DateTimeDefaultFormatter` and is the field's
`default_formatter`. Choose it on **Manage display**.

## What it renders

`viewElements()` outputs, per item:

```
date  <day_separator>  start_time  <time_separator>  end_time
```

- The day is rendered by the inherited `buildDateWithIsoAttribute()` (core `#theme => 'time'` with a
  `datetime` ISO attribute).
- `start_time` / `end_time` use `buildTimeWithAttribute()` — core `#theme => 'time'`, `#html => FALSE`,
  a `time` attribute, and a `timezone` cache context.
- The two separators are emitted as `['#plain_text' => …]` (auto-escaped). `end_time` (and the
  time_separator) are only shown when the value is present.

## Settings (`field.formatter.settings.datetimeday_default`)

| Setting | Default | Meaning |
|---|---|---|
| `format_type` | `html_date` | Date-format machine name (from `system.date_format` config entities) for the **day**. Titled "Day format" in the settings form. |
| `time_format_type` | `html_time` | Date-format machine name used for the **start/end times** (see `formatTime()`). |
| `day_separator` | `,` | String between the day and the start time. |
| `time_separator` | `-` | String between start and end time. |
| `timezone_override` | `''` | Inherited. Optional timezone name applied to display. |

`defaultSettings()` sets the above (overriding the parent's `format_type` to `html_date`).
`settingsForm()` adds the time-format select and the two separator textfields; `settingsSummary()`
previews the day format, time format, and both separators. `formatTime()` formats a `DrupalDateTime`
via `dateFormatter->format($ts, $time_format_type, '', $timezone)`.

Set the formatter from code:

```php
\Drupal::service('entity_display.repository')
  ->getViewDisplay('node', 'event', 'default')
  ->setComponent('field_hours', [
    'type' => 'datetimeday_default',
    'settings' => [
      'format_type' => 'html_date',
      'time_format_type' => 'html_time',
      'day_separator' => ', ',
      'time_separator' => ' – ',
    ],
  ])->save();
```
