<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Simplify" and "Intl" field formatters

## Install & enable

```bash
composer require drupal/daterange_simplify
drush en daterange_simplify -y
```

`composer require` pulls the `openpsa/ranger:^0.5` library. Core dependency is **`datetime`**.
For any non-`en` locale the server needs the PHP **`php-intl`** extension installed. No sub-modules,
no permissions, no Drush commands, no admin config page — you configure it per view-display.

## The two formatters

| Plugin id | Class | Label | `field_types` |
|---|---|---|---|
| `daterange_simplify` | `SimplifyFormatter` | *Simplify* | `daterange` |
| `intl_formatter` | `IntlFormatter` | *Intl* | `date`, `datetime` |

Both extend `SimplifyFormatterBase` and are selected under
*Structure → (bundle) → Manage display* → set the field's format → click the gear for settings.

### Simplify (`daterange_simplify`) settings

From `SimplifyFormatter::defaultSettings()` (+ base):

| Setting key | Default | Meaning |
|---|---|---|
| `date_format` | `medium` | Date style — one of `none/full/long/medium/short`. |
| `time_format` | `short` | Time style — restricted to `none/short`. |
| `range_separator` | `-` | Text placed between the start and end of the range. |
| `date_time_separator` | `, ` | Text placed between the date part and the time part. |
| `timezone_override` | `''` | If set, always render in this time zone (from the region option list). |

The settings summary shows two live samples — "2 hours apart" and "2 days apart" — built by
calling `Simplify::daterange()` with the current settings and language.

### Intl (`intl_formatter`) settings

From `IntlFormatter::defaultSettings()` (+ base): `date_format` (`medium`), `time_format`
(`short`), `timezone_override` (`''`). No separators (single value, not a range). The summary
shows one live sample of the current date/time.

### Style values

`Simplify::getAllowedFormats($restrict_intl)` returns `['none','full','long','medium','short']`,
or `['none','short']` when restricted. Time selects use the restricted list; date selects use the
full list. Each string maps (in `getDateFormat()`) to an `IntlDateFormatter` constant:
`none→NONE`, `full→FULL`, `long→LONG`, `medium→MEDIUM`, `short→SHORT` (anything else → `MEDIUM`).

## How a value is rendered

`SimplifyFormatter::viewElements()`:

1. Reads `datetime_type` field setting to decide `date_only`
   (`DateTimeItem::DATETIME_TYPE_DATE`), and the `timezone_override` setting.
2. For each item, converts `$item->value` (and `$item->end_value`, falling back to the start when
   empty) to a `DrupalDateTime` via `Simplify::toDrupalDateTime($value, $tz_override, $date_only)`.
3. Calls `Simplify::daterange($start, $end, date_format, time_format, range_separator,
   date_time_separator, $langcode)` and puts the result in `#markup`, with
   `#cache['contexts'] = ['timezone']`.

`IntlFormatter::viewElements()` is the single-value equivalent, calling
`Simplify::datetime($time, date_format, time_format, $langcode)`.

`toDrupalDateTime()` detects the storage form — numeric → UNIX (`U`), 10-char → `Y-m-d`,
otherwise `Y-m-d\TH:i:s` — parses as UTC, then applies the user/system time zone (or storage TZ
for date-only), and finally the per-field `timezone_override` if set.

## Example view-display config

```yaml
# core.entity_view_display.node.event.default
content:
  field_dates:
    type: daterange_simplify
    label: above
    settings:
      date_format: medium
      time_format: short
      range_separator: ' to '
      date_time_separator: ', '
      timezone_override: ''
```

```bash
drush cset core.entity_view_display.node.event.default \
  content.field_dates.type daterange_simplify -y
drush cr
```

## Gotchas

- **Time style is limited to `none`/`short`** in the UI; long/medium/full time is not offered.
- No `config/schema/` ships for these settings, so strict config-schema validators may flag the
  view-display config; the settings still save and work.
- Non-`en` locales silently need `php-intl`; without it Ranger cannot format those locales.
- `timezone_override` uses the region option list via
  `TimeZoneFormHelper::getOptionsListByRegion()` (falling back to `system_time_zones()` below
  core 10.1) through `DeprecationHelper::backwardsCompatibleCall()`.
