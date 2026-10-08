# HMS Field — service, render element, hooks

## Service `hms_field.hms` (`Drupal\hms_field\HMSService`, interface `HMSServiceInterface`)
Constructor arg: `@module_handler`. All duration conversion goes through it.

| Method | Signature | Purpose |
|---|---|---|
| `formattedToSeconds` | `(string $str, string $format='h:m:s', array $element=[], ?FormStateInterface $fs=null): int\|bool\|null` | Parse a formatted string to seconds. `null` for empty, `false` (and sets a form error if `$fs` given) for invalid input. Handles ISO formats and the space-separated `hms` format (`3h 15m 30s`, also `w`/`d`), commas as decimal separators, and a leading `-` for negatives. |
| `secondsToFormatted` | `(string\|int\|null $seconds, string $format='h:mm', bool $leading_zero=true): ?string` | Render seconds into the given format. `null` on empty. |
| `isValid` | `(string\|int $input, string $format, array $element=[], ?FormStateInterface $fs=null): bool` | True when `formattedToSeconds() !== false`. |
| `factorMap` | `(bool $return_full=false): array` | Unit → seconds factor. `w`=604800, `d`=86400, `h`=3600, `m`=60, `s`=1. With `true`, returns full entries incl. `label single`/`label multiple`. Result is `hook_hms_factor_alter`-ed. |
| `formatOptions` | `(): array` | The selectable input/display formats (grouped: "ISO 8601 based", "Space separated"). Result is `hook_hms_format_alter`-ed. |
| `normalizeFormat` | `(string $format): string` | Collapse repeated format chars (e.g. `hh`→`h`) for parsing. |

Example:
```php
$hms = \Drupal::service('hms_field.hms');
$seconds = $hms->formattedToSeconds('1h 30m', 'hms');   // 5400
$label   = $hms->secondsToFormatted(5400, 'h:mm');      // "1:30"
$ok      = $hms->isValid('90:00', 'm:ss');              // true
```

## Render element `hms` (`Drupal\hms_field\Element\HMS`, `@FormElement("hms")`)
A text input that parses/validates a duration. Useful in any custom form.
- Properties: `#format` (default `h:mm:ss`), `#placeholder`, `#size` (8), `#maxlength` (16),
  standard input properties.
- `valueCallback()` converts the stored `#default_value` (seconds) to the formatted string for
  display; `validateHms()` converts submitted text back to **seconds** (`setValueForElement`) or
  sets an error `"Please enter a correct hms value in format %format"`.

```php
$form['duration'] = [
  '#type' => 'hms',
  '#title' => t('Duration'),
  '#format' => 'h:mm:ss',
  '#default_value' => 5400,   // seconds in; you get seconds back in $form_state
];
```

## Hooks
Both alter the static maps returned by the service (implement in a `.module`):

- `hook_hms_format_alter(array &$format)` — add/remove selectable input & display formats.
  Structure mirrors `formatOptions()`: `['<group label>' => ['<format id>' => '<label>', …], …]`.
- `hook_hms_factor_alter(array &$factor)` — add/change units. Each entry:
  `'<char>' => ['factor value' => <seconds>, 'label single' => t('…'), 'label multiple' => t('…')]`.
  Add e.g. a month unit here (also make its char available in a format via `hook_hms_format_alter`).
