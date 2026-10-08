<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `daterange_compact.formatter` service

Format compact date/time ranges in your own code (Twig lazy-builder, REST output, custom
blocks) without going through a field formatter.

Service id: **`daterange_compact.formatter`** → `DateRangeCompactFormatter` implements
`DateRangeCompactFormatterInterface` (constructor args: `@entity_type.manager`,
`@date.formatter`).

## Methods

```php
public function formatDateRange(
  string $startDate, string $endDate,
  string $type = 'medium_date', $timezone = NULL, $langcode = NULL
): FormattedDateTimeRange;

public function formatTimestampRange(
  int $start_timestamp, int $end_timestamp,
  string $type = 'medium_datetime', $timezone = NULL, $langcode = NULL
): FormattedDateTimeRange;
```

- `$type` = the machine id of a `daterange_compact_format` config entity (defaults:
  `medium_date` for dates, `medium_datetime` for timestamps). Unknown id → an internal fallback
  pattern.
- `formatDateRange()` accepts ISO-8601 strings; it converts them to timestamps (in `$timezone`)
  and delegates to `formatTimestampRange()`.
- Both return a `FormattedDateTimeRange` value object; cast to string for the rendered text.

## Example

```php
$svc = \Drupal::service('daterange_compact.formatter');

(string) $svc->formatDateRange('2017-01-24', '2017-01-25', 'medium_date');
// => "24–25 January 2017"

(string) $svc->formatTimestampRange(1491036000, 1491057000, 'medium_datetime');
// same-day time range, e.g. "9:00am–4:30pm, 1 April 2017"
```

## How it chooses the output (`formatTimestampRange`)

1. Loads the format config entity for `$type` (else a hard-coded fallback).
2. `derivePatterns()` compares the start/end timestamps in the timezone and picks the most
   compact applicable pattern set (same-day → same-month → same-year → default), each provided
   by `DateRangeCompactFormat::getSame*Patterns()` / `getDefaultPatterns()`.
3. Renders each end via core `date.formatter->format(..., 'custom', $pattern, ...)`.
4. If both ends render identically returns a single value; otherwise joins them with the
   pattern set's separator.

The field formatter (`Plugin/Field/FieldFormatter/DateRangeCompactFormatter`) is a thin wrapper
that feeds `daterange` / `datetime` / `timestamp` field items into these same service methods.
