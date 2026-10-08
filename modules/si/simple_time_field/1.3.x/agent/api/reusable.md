# Reusable pieces: form element, TimeHelper, Feeds target

## Form element `simple_time_field_element`

`src/Element/SimpleTimeField.php` (`@FormElement`, extends `FormElementBase`). A standalone HTML5
time input you can use in any form, independent of the field type.

Supported properties (`getInfo()`): `#min`, `#max`, `#step` (default 60), `#with_seconds`
(default FALSE), `#placeholder`, `#default_value`, `#maxlength` 8, `#size` 10.

```php
$form['open'] = [
  '#type'          => 'simple_time_field_element',
  '#title'         => $this->t('Opening time'),
  '#default_value' => '09:00',
  '#min'           => '08:00',
  '#max'           => '18:00',
  '#step'          => 900,        // 15-minute picker
  '#with_seconds'  => FALSE,
];
```

Mechanics:
- `preRenderSimpleTimeField()` maps `#min`/`#max`/`#step`/`#placeholder` to real HTML attributes and
  forces `type="time"`. With `#with_seconds` set it forces `step=1` (unless a finer custom step is
  given).
- `processSimpleTimeField()` adds the `simple-time-field` class, a `simple-time-field-wrapper`
  div, and attaches library `simple_time_field/time_field`.
- `valueCallback()` returns `trim((string) $input)`, falling back to `#default_value`.

`hook_theme()` in `.module` registers a `simple_time_field_element` theme hook, but the element
itself renders via `#theme => 'input__textfield'`.

## `Drupal\simple_time_field\Utility\TimeHelper`

Static helpers used across the field type, widget, formatters and Feeds target:

| Method | Returns | Notes |
|---|---|---|
| `format(string $value, string $format, ?string $timezone = NULL)` | formatted string, or `''` | Normalizes, anchors to `2000-01-01`, applies PHP date format; optional timezone shift. |
| `normalize(string $value)` | `HH:MM:SS` or `''` | Regex `^([01]\d\|2[0-3]):([0-5]\d)(?::([0-5]\d))?$`; missing seconds → `:00`. |
| `isValid(string $value, bool $with_seconds = FALSE)` | bool | Structural time validation. |
| `toSeconds(string $value)` | int or `FALSE` | Seconds since midnight (used for min/max comparison). |
| `getFormatOptions()` | array | `format_string => label` presets for the configurable formatter. |

## Feeds target `simple_time_field`

`src/Feeds/Target/SimpleTimeField.php` (`@FeedsTarget`, extends `FieldTargetBase`; only registered
when the optional Feeds module is present). Normalizes an arbitrary imported string to `HH:MM`:
`prepareValue()` → `prepareTimeValue()` → `normalizeTimeInput()` first tries `TimeHelper::normalize()`,
then falls back to `strtotime()` (accepting inputs like `2pm`, `14:00:00`, `02:30 PM`), and validates
the result via `DrupalDateTime::createFromFormat('H:i', …)`. Unparseable input maps to `''` (empty).
