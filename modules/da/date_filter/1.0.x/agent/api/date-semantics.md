<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Query & date semantics of `date_filter`

What actually changes in the generated SQL compared with core's date filters.

## Whole-day padding (`DateBase::resetTimes()`)

Applied **only when the filter is date-only** (`$skipTimeUi === TRUE`, i.e. *Filter type: Date*
or a date-only Date/time field):

| operator | time forced onto the parsed date |
|---|---|
| `>` , `>=` | `00:00:00` |
| `<` , `<=` | `23:59:59` |
| `between` | min → `00:00:00`, max → `23:59:59` |
| `not between` | min → `00:00:00`, max → `23:59:59` |
| `=` , `!=` | untouched — but see the rewrite below |

With *Filter type: Date and time* nothing is padded; the user's time is used verbatim.

## `=` / `!=` are rewritten (`DateBase::opSimple()`)

On a date-only filter:

- `=`  → `min = max = value`, operator becomes `between`  → matches the **whole chosen day**.
- `!=` → `min = max = value`, operator becomes `not between` → excludes the whole day.

Core instead compares against one exact instant, which is why "filter by 2026-07-24" never
matched anything in core. With *Date and time* selected the operators keep their literal
meaning.

## `between` with a half-filled range (`DateBase::opBetween()`)

- both min and max → `field BETWEEN min AND max` (or `NOT BETWEEN`)
- only min → `field >= min`
- only max → `field <= max`
- neither → no condition added

Combined with `acceptExposedInput()` (which accepts the filter when *either* min or max carries
a date), an exposed range works as an open-ended "from" or "to" filter.

## Timezones

| handler | plugin id | input timezone | value sent to SQL |
|---|---|---|---|
| `DateTimestamp` | `date` | `date_default_timezone_get()` (site/user) | `$date->format('U')` — UNIX timestamp |
| `DateTime` (datetime field) | `datetime` | `date_default_timezone_get()` | `Y-m-d\TH:i:s` in `DateTimeItemInterface::STORAGE_TIMEZONE` (UTC), run through `$query->getDateField()` / `getDateFormat()` |
| `DateTime` (date-only field) | `datetime` | `DateTimeItemInterface::STORAGE_TIMEZONE` (UTC) | `Y-m-d` (`DATE_STORAGE_FORMAT`) |

Date-only fields are stored without a timezone, so the module deliberately parses their input
as UTC — otherwise a user in UTC+2 filtering "2026-07-24" would silently shift a day.

## Value parsing (`getDate()` / `getProcessedDate()`)

- Admin-UI values are plain strings; exposed values are arrays `['date' => 'Y-m-d', 'time' => 'H:i:s']`
  which are `implode(' ')`-ed before parsing.
- Everything goes through `new DrupalDateTime($string, $timezone)`, so **relative offsets work
  everywhere**: `+1 day`, `-2 hours -30 minutes`, `-1 month`, `now`.
- An empty string, or a `DrupalDateTime` with `hasErrors()`, yields `NULL` → the operator adds
  no condition at all (the filter is skipped, not an error).
- Widget/round-trip format is `Y-m-d` when date-only and `Y-m-d\TH:i:s` when *Date and time*
  (`getWidgetDateFormat()`); the exposed date/time inputs are seeded by formatting the parsed
  default with those.

## Operators available

`NumericFilter::operators()` minus `regular_expression`:
`<`, `<=`, `=`, `!=`, `>=`, `>`, `between`, `not between`, `empty`, `not empty`.

## Validation

`validateOptionsForm()` only runs when the filter is exposed **and required**: each relevant
value (`value`, or `min`+`max` for two-value operators) must pass `strtotime()`, otherwise the
form errors with *"Invalid date format."*
