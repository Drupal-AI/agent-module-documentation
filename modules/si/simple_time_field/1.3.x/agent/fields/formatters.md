# Formatters for `simple_time_type`

Four `@FieldFormatter` plugins, all in `src/Plugin/Field/FieldFormatter/`. All render each item as
`['#markup' => TimeHelper::format(...)]`, skipping empty items. The formatted output is produced by
`date()` / `\DateTime::format()` on the stored digits, so it contains only time characters; `#markup`
is additionally passed through the render system's admin filter.

| Formatter id | Class | Label | Output | Configurable |
|---|---|---|---|---|
| `simple_time_formatter` (default) | `SimpleTimeFormatter` | Time (configurable format) | any PHP date format | yes |
| `simple_time_formatter_12h_lower` | `SimpleTimeDefaultFormatter` | Time — 12-hour lowercase am/pm | `02:30 pm` (`h:i a`) | no |
| `simple_time_formatter_12h_upper` | `SimpleTimeFormatterTwo` | Time — 12-hour uppercase AM/PM | `02:30 PM` (`h:i A`) | no |
| `simple_time_formatter_24h` | `SimpleTimeFormatterThree` | Time — 24-hour (HH:MM) | `14:30` (`H:i`) | no |

The three fixed formatters exist for backward compatibility; new displays should use the
configurable one.

## `simple_time_formatter` (configurable) settings

`defaultSettings()` / config schema `field.formatter.settings.simple_time_formatter`:

| Setting | Default | Meaning |
|---|---|---|
| `time_format` | `h:i a` | A preset PHP date format, or the literal `custom` to use `custom_format`. |
| `custom_format` | `''` | A custom PHP date format string; only used when `time_format === 'custom'`. Falls back to `H:i` if empty. |
| `timezone` | `''` | Optional target timezone to shift the displayed time into; blank = display exactly as stored. |

Preset format options come from `TimeHelper::getFormatOptions()`:
`h:i a`, `h:i A`, `H:i`, `H:i:s`, `h:i:s a`, `g:i a`, `g:i A` (plus the `custom` entry appended in
the settings form). `getEffectiveFormat()` resolves the active format string.

`viewElements()` adds `#cache => ['contexts' => ['timezone']]` so cached output varies per request
timezone. `settingsSummary()` renders a live example via `TimeHelper::format('14:30:00', …)`.

### Display-timezone caveat

A stored time has no date, so `TimeHelper::format()` pins it to a fixed date (`2000-01-01`) before
applying the timezone shift. The `timezone` setting is therefore a display-only offset relative to
UTC on that fixed date; it does not represent a real instant and does not track DST for the actual
day. Use it only for a constant regional offset, not for accurate cross-timezone scheduling.

### Set formatter settings via PHP

```php
$display = \Drupal::service('entity_display.repository')
  ->getViewDisplay('node', 'event', 'default');
$display->setComponent('field_open_time', [
  'type' => 'simple_time_formatter',
  'settings' => ['time_format' => 'g:i a', 'custom_format' => '', 'timezone' => ''],
])->save();
```
