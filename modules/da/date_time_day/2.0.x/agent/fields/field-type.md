# Field type `datetimeday`

`src/Plugin/Field/FieldType/DateTimeDayItem.php` — `@FieldType(id = "datetimeday")`, extends core
`Drupal\datetime\Plugin\Field\FieldType\DateTimeItem`. Stores one date-only value plus a start and an
end time-of-day. `default_widget = datetimeday_default`, `default_formatter = datetimeday_default`,
`list_class = DateTimeDayFieldItemList`.

## Storage settings

`defaultStorageSettings()` returns (merged over the parent's):

| Setting | Values | Meaning |
|---|---|---|
| `datetime_type` | forced to `date` (`DateTimeItem::DATETIME_TYPE_DATE`) | The day part is always date-only (no time on the day column). |
| `time_type` | `time` (default) or `time_seconds` | Whether start/end times are stored/edited as `H:i` or `H:i:s`. |

`storageSettingsForm()` exposes only the `time_type` select (labelled "Day type", options
"Start, end time of day" / "…with seconds"); it is `#disabled` once the field has data. Edit these on the
field's **storage settings** tab in Field UI, or with:

```php
$storage = \Drupal\field\Entity\FieldStorageConfig::loadByName('node', 'field_hours');
$storage->setSetting('time_type', 'time_seconds')->save();
```

## Columns and properties (`schema()` / `propertyDefinitions()`)

Stored columns (added to the parent's `value` date column):

| Column | Description |
|---|---|
| `value` | The day, `Y-m-d` (core `DATE_STORAGE_FORMAT`). Indexed by parent. |
| `start_time_value` | Start time string (`H:i` or `H:i:s`). Indexed (`indexes['start_time_value']`). |
| `end_time_value` | End time string. Indexed (`indexes['end_time_value']`). |

Properties:

- `value` (string) + computed `date` → `Drupal\date_time_day\DateDayComputed` (day as `DrupalDateTime`,
  time normalised to 12:00:00 UTC via `setDefaultDateTime()`).
- `start_time_value` (string, required) + computed `start_time` → `DateTimeDayComputed`
  (`date source = start_time_value`).
- `end_time_value` (string, required) + computed `end_time` → `DateTimeDayComputed`
  (`date source = end_time_value`).

`DateTimeDayComputed::getValue()` parses the stored string with `H:i` or `H:i:s` depending on
`time_type`, and pads a 5-char value to `:00` when `time_seconds` is set. `isEmpty()` is true only when
`value`, `start_time_value` and `end_time_value` are all empty. `onChange()` invalidates the cached
`start_time` / `end_time` object when its `*_value` string changes.

## Default values (`DateTimeDayFieldItemList`)

`src/Plugin/Field/FieldType/DateTimeDayFieldItemList.php` extends core `DateTimeFieldItemList` and adds
independent default-value controls for the day, start time and end time (`defaultValuesForm`). Each
supports "Current date" (`DEFAULT_VALUE_NOW`) or a relative `strtotime` expression
(`DEFAULT_VALUE_CUSTOM`, e.g. `+90 days`). `defaultValuesFormValidate()` rejects an invalid relative
expression per part; `processDefaultValue()` converts NOW/relative values into stored strings in the
storage timezone. Config keys (`field.value.datetimeday`): `default_date_type`, `default_date`,
`default_start_time_type`, `default_start_time`, `default_end_time_type`, `default_end_time`.

## Sample values and update hook

- `generateSampleValue()` produces a random day and a one-hour start→end pair formatted per `time_type`.
- `date_time_day.install` → `date_time_day_update_8106()`: for existing `datetimeday` storage, copies the
  old `datetime_type` setting into the new `time_type` setting and resets `datetime_type` to date-only.

## Config schema

`config/schema/date_time_day.schema.yml`: `field.storage_settings.datetimeday`
(`datetime_type`, `time_type`), `field.field_settings.datetimeday` (inherits datetime field settings),
`field.value.datetimeday` (the six default-value keys above). (The schema also declares an unused
`field.formatter.settings.datetimeday_h_i_partial_time` mapping for which no formatter plugin exists.)
