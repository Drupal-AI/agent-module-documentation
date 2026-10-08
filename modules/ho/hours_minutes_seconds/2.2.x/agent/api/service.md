# Service, form element & theme

## The conversion service

Service id **`hours_minutes_seconds.hour_minutes_seconds`**
(class `Drupal\hours_minutes_seconds\HoursMinutesSecondsService`, interface
`HoursMinutesSecondsServiceInterface`). All parsing/formatting lives here; reuse it directly rather
than reimplementing.

| Method | Behaviour |
|---|---|
| `secondsToFormatted($seconds, $format = 'h:mm', $leading_zero = TRUE): ?string` | Seconds → formatted string. NULL for NULL/'' input. |
| `formattedToSeconds($str, $format = 'h:m:s'): int\|false\|null` | Formatted string → seconds. **FALSE if the string is invalid**, NULL for empty. |
| `isValid($input, $format): bool` | TRUE unless `formattedToSeconds()` returns FALSE. |
| `toArray($seconds): ?array` | Decompose to `['w'=>…,'d'=>…,'h'=>…,'m'=>…,'s'=>…]`. |
| `toIso8601($seconds): ?string` | e.g. `9045` → `PT2H30M45S`; zero → `PT0S`; negatives prefixed `-`. |
| `fromIso8601($iso): int\|false\|null` | Parse `PT2H30M45S` / `P1W2D` → seconds; FALSE if malformed. |
| `factorMap($return_full = FALSE): array` | Unit→seconds map (`w`=604800 … `s`=1); full form includes singular/plural labels. Runs `hook_hour_minutes_seconds_factor_alter`. |
| `formatOptions(): array` | The selectable format strings. Runs `hook_hour_minutes_seconds_format_alter`. |
| `normalizeFormat($format): string` | Collapse doubled unit letters (`hh`→`h`). |

```php
$hms = \Drupal::service('hours_minutes_seconds.hour_minutes_seconds');
$hms->secondsToFormatted(9045, 'h:mm:ss');   // "2:30:45"
$hms->formattedToSeconds('2:30:45', 'h:mm:ss'); // 9045
$hms->toIso8601(9045);                         // "PT2H30M45S"
$hms->fromIso8601('PT2H30M45S');               // 9045
```

Note `factorMap()` cannot exceed weeks (months/years have variable length) — that is by design; use
the factor-alter hook to add fixed-length units only.

## The reusable form element

`#type 'hour_minutes_seconds'` (class `Element\HoursMinutesSeconds`) is a text input that validates
against `#format` and converts the submitted value to **seconds** in `$form_state`.

```php
$form['duration'] = [
  '#type' => 'hour_minutes_seconds',
  '#title' => $this->t('Duration'),
  '#format' => 'h:mm:ss',      // default 'h:mm:ss'
  '#default_value' => 3600,     // stored seconds; displayed formatted
  '#placeholder' => 'h:mm:ss',
  '#min' => 60, '#max' => 86400, // seconds; enforced in validation
  '#required' => TRUE,
];
// After submit: $form_state->getValue('duration') is an int number of seconds.
```

It attaches the admin CSS library `hours_minutes_seconds/hours_minutes_seconds_admin` and exposes
`data-hms-format` on the input.

## Theme hooks (render directly)

- `hour_minutes_seconds` — variables: `value` (seconds), `format`, `leading_zero`, `running_since`
  (0 = static; `-1` = "start now"; a timestamp = running since then), `offset`, `default_value`,
  `countdown` (bool). Preprocess attaches the display library and, for live modes, the `data-hms-*`
  attributes + `drupalSettings` server time.
- `hour_minutes_seconds_natural_language` — variables: `value`, `format` (e.g. `w:d:h:m:s`),
  `separator`, `last_separator`; renders translatable pluralised fragments (zero-value units hidden).

## Views & migrate

- Views field handler id `hour_minutes_seconds` (`@ViewsField("hour_minutes_seconds")`) renders the
  stored seconds as formatted / natural / ISO / raw.
- Migrate: the field is a plain integer, so `hours_minutes_seconds.migrate.inc` documents that **no
  custom handler is needed** — map raw seconds with the core `get` process plugin.
