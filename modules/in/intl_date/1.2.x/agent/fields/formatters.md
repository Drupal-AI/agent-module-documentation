# Field formatters

Two field formatter plugins render date/time field values through `IntlDate::format()` using a
chosen `intl_date_format` config entity. Both appear in Manage display and in Views field
settings under the label **Intl Default**. Assign them per field like any core formatter.

| Plugin id | Class | Field types | Settings |
|-----------|-------|-------------|----------|
| `datetime_intl_default` | `IntlDateTimeDefaultFormatter` (extends `DateTimeFormatterBase`) | `datetime` | `format_type` (default `medium`) + inherited `timezone_override` |
| `intl_timestamp` | `IntlTimestampFormatter` (extends core `TimestampFormatter`) | `timestamp`, `created`, `changed` | `date_format` (default `medium`), `timezone` (default site/user tz) |

## Behavior

- Both formatters build an option list from every `intl_date_format` entity, showing the format
  label plus a live preview of the current time.
- `datetime_intl_default::formatDate()` loads the selected format entity, resolves the timezone
  (`timezone_override` setting or the value's own timezone) and returns
  `IntlDate::format($timestamp, $pattern, NULL, $timezone)` — langcode is left NULL, so the
  *current* interface language decides the locale.
- `intl_timestamp::viewElements()` renders each item as `#markup` with a `timezone` cache
  context; `formatTimestamp()` loads the format entity and calls `IntlDate::format()` the same
  way. If the configured format id no longer exists, it returns an empty string.

## Set a formatter in code

Set on an entity view display (equivalent to choosing it in Manage display):

```php
$display = \Drupal::service('entity_display.repository')
  ->getViewDisplay('node', 'article', 'default');
$display->setComponent('field_event_date', [
  'type' => 'datetime_intl_default',
  'settings' => ['format_type' => 'long'],
])->save();
```

For a `created`/`changed`/timestamp field use `type => 'intl_timestamp'` with
`settings => ['date_format' => 'long', 'timezone' => 'Europe/Budapest']`.
