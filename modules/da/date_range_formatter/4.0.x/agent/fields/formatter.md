# Field formatter: `date_range_without_time`

Single formatter this module provides. Plugin id `date_range_without_time`, label
**"Date range"**, applies to core `daterange` fields.
Class `Drupal\date_range_formatter\Plugin\Field\FieldFormatter\DateRangeFormatterRangeFormatter`,
extends core `Drupal\datetime\Plugin\Field\FieldFormatter\DateTimeCustomFormatter`.

## What it does

For each field item it picks ONE PHP `date()` format string based on how far apart the
start and end are, formats the start date with it, then substitutes any `{X}` tokens with
the corresponding element of the END date. Output is a core `time` render element
(`#theme => 'time'`) whose `datetime` attribute is the RFC3339 start (single) or
`start/end` interval (range); the visible text is Twig-escaped.

Granularity selection (`viewElements()`, later checks win):

| Condition (start vs end) | Setting used | Default pattern | Example output |
|---|---|---|---|
| End missing, or start == end | `single` | `d F Y` | `10 June 2026` |
| Same day (`d.m.Y` equal, but distinct timestamps) | `one_day` | `d F Y` | `10 June 2026` |
| Same month+year, different day | `one_month` | `d - {d} F Y` | `10 - 12 June 2026` |
| Same year, different month | `several_months` | `d F - {d} {F} Y` | `10 June - 12 July 2026` |
| Different year | `several_years` | `d F Y - {d} {F} {Y}` | `10 June 2026 - 12 July 2027` |

An item with an empty `start_date` renders nothing.

## Brace `{X}` syntax

A bare `date()` letter formats the START date. A letter wrapped in braces — `{d}`, `{F}`,
`{Y}`, etc. — formats the same element of the END date. So `d - {d} F Y` prints the start
day, a literal ` - `, the end day, then the shared month and year. Any single ASCII letter
in braces is supported (matched by `/\{([a-zA-Z])\}/`). Literal separators (the ` - `) are
written directly into the pattern; see the note on `separator` below.

Format values are passed through `t()`, so a matching translation of the exact pattern
string (e.g. `t("d F Y")`) is used as the runtime format — useful for localizing element
order but it means the strings are treated as translatable literals.

## Settings

| Key | In defaults / schema? | Purpose |
|---|---|---|
| `one_day` | yes / yes | Pattern for a same-day range. |
| `one_month` | yes / yes | Pattern for a same-month (different day) range. |
| `several_months` | yes / yes | Pattern for a same-year (different month) range. |
| `several_years` | yes / yes | Pattern for a cross-year range. |
| `single` | no / no | Pattern for a single date (no end, or end == start). Read at runtime. |
| `single_all_day` | no / no | Present in the settings form only; NOT read by `viewElements()` in 4.0.x. |
| `separator` | yes / yes | Declared default `-` and schema-mapped, but NOT read by the render code; the actual separator is whatever literal you put inside each pattern. Vestigial. |
| `date_format` | inherited | From `datetime_custom`; the form UNSETS this field so it is not shown. |
| `timezone_override` | inherited | From `datetime_custom` base; standard timezone override. |

`defaultSettings()` sets `separator => '-'`, `one_day => 'd F Y'`,
`one_month => 'd - {d} F Y'`, `several_months => 'd F - {d} {F} Y'`,
`several_years => 'd F Y - {d} {F} {Y}'`, plus the inherited datetime_custom defaults.
`single`/`single_all_day` have no default; the settings form supplies `d F Y` as a
fallback via `?: 'd F Y'`, so they are stored when the display form is saved.

The settings form (`settingsForm()`) removes the inherited `date_format` field and adds
text fields for `single`, `single_all_day`, `one_day`, `one_month`, `several_months`,
`several_years`, plus help text about `date()` letters and the brace end-date syntax.
`settingsSummary()` echoes the four range patterns.

## Config schema

`config/schema/date_range_formatter.schema.yml`:

```yaml
field.formatter.settings.date_range_without_time:
  type: field.formatter.settings.datetime_custom
  label: 'Date range (without time)'
  mapping:
    separator: { type: string }
    one_day: { type: date_format }
    one_month: { type: date_format }
    several_months: { type: date_format }
    several_years: { type: date_format }
```

`single` and `single_all_day` are intentionally NOT in the schema; update
`date_range_formatter_update_8703()` strips any leftover `single`/`single_all_day` keys
from stored `views` and `entity_view_display` configs that use this formatter.

## Apply it via PHP (on an entity view display)

```php
$display = \Drupal::service('entity_display.repository')
  ->getViewDisplay('node', 'event', 'default');
$display->setComponent('field_dates', [
  'type' => 'date_range_without_time',
  'settings' => [
    'one_day'        => 'd F Y',
    'one_month'      => 'd - {d} F Y',
    'several_months' => 'd F - {d} {F} Y',
    'several_years'  => 'd F Y - {d} {F} {Y}',
    'single'         => 'd F Y',
  ],
])->save();
```

Via UI: Manage display for the entity/view mode → set the `daterange` field's format to
"Date range" → open the gear to edit the patterns.
