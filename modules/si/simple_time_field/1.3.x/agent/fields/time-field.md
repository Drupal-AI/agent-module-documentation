# The Time field type, storage & widget

## Field type `simple_time_type`

`src/Plugin/Field/FieldType/SimpleTimeFieldItem.php` (extends `FieldItemBase`).

- Annotation: `id = simple_time_type`, `label = Time`, `default_widget = simple_time_widget`,
  `default_formatter = simple_time_formatter`, `category = General`.
- **Single property** `value` — a `string` ("Time value").
- **Storage schema** (`::schema()`): one column `value`, `type: varchar`, `length: 8`,
  `not null: FALSE`, with a DB index on `value`. The stored value is the literal time string
  `HH:MM` or `HH:MM:SS` — it is **not** normalized to an integer number of seconds. Because it is
  a short varchar it sorts and filters correctly as a string in Views with no custom handler.
- **Field setting** `with_seconds` (bool, default `FALSE`); form checkbox added in
  `fieldSettingsForm()`. When off, values are stored as `HH:MM`; when on, `HH:MM:SS`.
- `isEmpty()` → true when `value` is `NULL` or `''`.
- `preSave()`: normalizes the value with `TimeHelper::normalize()`; if `with_seconds` keeps the
  full `HH:MM:SS`, otherwise truncates to the first 5 chars (`HH:MM`). If the value fails the
  normalize regex it is left unchanged (invalid strings never reach here through the widget, which
  validates first).
- `generateSampleValue()` produces a random valid time (respects `with_seconds`).
- Convenience method `getFormattedTime(string $format, ?string $timezone = NULL)` → delegates to
  `TimeHelper::format()`.

### Set the field setting via PHP

```php
// On an existing field storage of type simple_time_type.
$field = \Drupal\field\Entity\FieldConfig::loadByName('node', 'event', 'field_open_time');
$field->setSetting('with_seconds', TRUE)->save();
```

## Widget `simple_time_widget`

`src/Plugin/Field/FieldWidget/SimpleTimeDefaultWidget.php` (extends `WidgetBase`),
label "Time picker". Renders the reusable `simple_time_field_element` (HTML5 `<input type="time">`).

Settings (`defaultSettings()` / config schema `field.widget.settings.simple_time_widget`):

| Setting | Type | Default | Meaning |
|---|---|---|---|
| `min`  | string | `''` | Earliest allowed time (`HH:MM`); emitted as the input `min` attr and enforced server-side. Blank = no minimum. |
| `max`  | string | `''` | Latest allowed time; input `max` attr + server-side check. Blank = no maximum. |
| `step` | int (seconds) | `60` | Picker granularity + accepted precision. Select options: `1`, `60`, `300`, `600`, `900`, `1800`, `3600`. |

Behavior:
- `step === 1` (1-second) auto-enables seconds for the input even if the field's `with_seconds` is off
  (`$with_seconds = field setting OR step===1`).
- `settingsSummary()` shows the range and interval label.
- **Server-side validation** (`validateTimeElement()`, attached as `#element_validate`): checks
  `TimeHelper::isValid()` (structural `HH:MM[:SS]`), then compares `TimeHelper::toSeconds($value)`
  against `min`/`max` seconds, setting a form error for a bad format, too-early, or too-late value.
  This runs independently of the browser picker so REST/programmatic submits through the form are
  covered too.

Note: the widget exposes only `min`/`max`/`step`. The underlying form element also supports a
`#placeholder`, but the widget does not surface a placeholder setting.

## Config schema

`config/schema/simple_time_field.schema.yml` defines:
- `field.field_settings.simple_time_type` → `with_seconds` (boolean).
- `field.widget.settings.simple_time_widget` → `min` (string), `max` (string), `step` (integer).
- Formatter settings — see [formatters.md](formatters.md).

## Install / update notes

`simple_time_field.install`: `simple_time_field_update_9000()` re-applies field storage
definitions for existing `simple_time_type` fields; `simple_time_field_update_10000()` is an
intentional no-op documenting that pre-existing `HH:MM` data stays valid after seconds support
was added. No data migration is required across the 1.x line.
