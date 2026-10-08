<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Formatter: `date_group`

Single class `DateGroupFormatter` in
`src/Plugin/Field/FieldFormatter/DateGroupFormatter.php`, extending core
`DateRangeDefaultFormatter`. Applies to `daterange` fields only.

## How to enable
Manage Display for the entity/view mode → set the Date range field's Format to
**Date group** → open the gear to configure. No install-time config, no route.

## Settings (`defaultSettings()`)
```
time_separator => ':'          // added by this module
+ parent (DateRangeDefaultFormatter):
  from_to     => 'both'        // ignored by the grouped path
  separator   => '-'
  format_type => 'medium'      // a core date_format entity id
  timezone_override => ''       // NOT applied in the grouped path
```
`settingsForm()` calls the parent form (which renders format_type, timezone_override,
separator, from_to) and appends a **Time separator** textfield.

## Render flow (`viewElements()`)
For each item:
1. If `end_date` is empty it is set to `start_date`.
2. Both dates are moved to `new \DateTimeZone(date_default_timezone_get())` — the
   request's current default timezone (site or authenticated user's), **not**
   `timezone_override`.
3. If `start_date->getTimestamp() === end_date->getTimestamp()` → the element is the
   parent `buildDate($start_date)` (a normal single formatted date, with ISO
   attributes). Otherwise the element is `['#markup' => groupDates(...), '#cache' =>
   ['contexts' => ['timezone']]]`.

## `groupDates()` branch selection
Parses both dates with `date_parse()` and loads the `date_format` config entity named
by `format_type`:
- `start.year != end.year` → `formatDateYear()`: `formatDate(start) . separator . formatDate(end)`
  (two complete dates via the parent `formatDate()`).
- `start.month == end.month` → `formatDateMonth()`.
- else (same year, different month) → `formatDateDay()`.

## `formatDateMonth()` / `formatDateDay()`
Both walk `getSplitDatePattern()` = `str_split($date_format->getPattern(), 1)` — the
chosen format's PHP pattern, one character per array element — and classify each
character against `$allDateFormats` (time `g G h H i s`, day `d D j l N`, numericDay
`d j`, ordinalSuffix `. S`, month `F m M n t`, year `o Y y`). They rebuild partial
format strings (e.g. `collect_date`, `collect_end`, `collect_year`, `time`), insert the
configured `separator`/`time_separator`, and format each piece via
`groupDateFormat($timestamp, $format)` = `dateFormatter->format($timestamp, 'custom',
$format)`. A `%` placeholder marks where the end piece is spliced back in.
`formatDateMonth()` has partial handling for the same-day-with-time case; the other
branches assume a date-only format.

## Output & escaping
The grouped result is a plain string placed in `#markup`. Drupal's renderer runs
`#markup` through `Xss::filterAdmin()`, and the string is built entirely from date
tokens formatted by the core date formatter plus admin-configured separators — no field
or user-submitted text is interpolated. Rendering runs after Views/entity access, so the
formatter neither sees nor changes access.

## Practical guidance
- Pick a **date-only** `format_type`. Formats with time tokens render cleanly only in the
  same-month, same-day sub-case.
- To customize the join, set **separator** (e.g. an en dash) rather than editing the format.
- The formatter groups the two endpoints of one field item; it does not group multiple
  entities under a date heading (that is a Views concern, which this module does not touch).
