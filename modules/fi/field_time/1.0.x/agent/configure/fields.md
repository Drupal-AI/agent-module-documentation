# Field Time: fields, widgets, formatters, element

Add the fields through the normal **Field UI** (*Manage fields* → add field → "Time « human »" or
"Time Range « Human »"). No module settings page.

## Field types

### `time` (TimeType)
- One property `value` (string, maxlength 8, required), DB column `char(8)` mapped to SQL `TIME`
  (`mysql_type`/`pgsql_type` = `time`). Stores `HH:MM:SS`.
- `isEmpty()` true when blank; sample value `11:55:00`.
- Default widget `time_widget`, default formatter `time_formatter`.

### `time_range` (TimeRangeType)
- Properties `from` and `to` (both string, maxlength 8, required), two `char(8)` `TIME` columns.
- **Constraint:** a `Callback` (`validateTimeRange`) adds a violation on `to` when
  `strtotime(to) <= strtotime(from)` — end must be strictly later than start.
- Default widget `time_range_widget`, default formatter `time_range_formatter`.

## Widgets (Manage form display)

Both `time_widget` and `time_range_widget` share the same two settings:

| Setting | Key | Default | Effect |
|---|---|---|---|
| Add seconds parameter to input widget | `enabled` | `false` | Adds a `step` attribute to the `<input type="time">` so seconds can be entered. |
| Step to change seconds | `step` | `5` | The seconds increment; only visible when `enabled` is checked. |

Both call `massageFormValues()` to normalize each submitted value with
`(new \DateTimeImmutable($value))->format('H:i:s')`. `time_range_widget` renders `from`/`to` as two
`time` elements inside a fieldset (for single-cardinality fields).

## Formatters (Manage display)

### `time_formatter`
| Setting | Key | Default | Effect |
|---|---|---|---|
| Time Format | `time_format` | `h:i a` | PHP `date()` format string applied via `DateTimeImmutable::format()`. |

### `time_range_formatter`
| Setting | Key | Default | Effect |
|---|---|---|---|
| Time Range Format | `timerange_format` | `start ~ end` | Template string; the literal words `start` and `end` are replaced by the formatted `from`/`to` times. |
| Time Format | `time_format` | `h:i a` | Format applied to each end of the range. |

Format-letter help shown in the UI: `a`/`A` (am/pm), `g`/`G`/`h`/`H` (hours), `i` (minutes), `s`
(seconds), `B` (Swatch time).

## The `time` render element (custom forms)

```php
$form['start'] = [
  '#type' => 'time',
  '#title' => $this->t('Start time'),
  '#required' => TRUE,
  // Optional: '#attributes' => ['step' => 5] to allow seconds.
];
```

`TimeElement` (`@FormElement("time")`) renders an HTML5 `<input type="time">` (class `form-time`); its
`valueCallback` returns the submitted string (or the `#default_value`).
