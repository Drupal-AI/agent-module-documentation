<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EDTF utilities — `EDTFUtils` & `EDTFConverter`

Static helpers for validating and normalizing EDTF strings. Not services — call the classes directly.
`Drupal\controlled_access_terms\EDTFUtils` does the core parsing; `EDTFConverter` (extends
`Drupal\rdf\CommonDataConverter`) is a thin RDF-oriented wrapper.

## `EDTFUtils`

Key constant: `EDTFUtils::DATE_PARSE_REGEX` — the single regex that decomposes a date into year/month/
day plus per-part qualifiers; the numbered `*_*` position constants (`YEAR_BASE`, `MONTH`, `DAY`,
`QUALIFIER_YEAR`, …) index its capture groups. `MONTHS_MAP` / `SEASONS_MAP` map EDTF month codes
01–41 (incl. seasons 21–32 and quarter/quadrimester/semester groupings 33–41) to labels and to a
representative numeric month.

```php
use Drupal\controlled_access_terms\EDTFUtils;

// Returns an array of error strings; empty array == valid.
$errors = EDTFUtils::validate($edtf, $intervals = TRUE, $sets = TRUE, $strict = FALSE);

// Convert an EDTF string to an ISO 8601 date/timestamp string ('' if invalid).
$iso = EDTFUtils::iso8601Value('1984~');        // '1984'
$iso = EDTFUtils::iso8601Value('19XX-06');      // '1900-06'
```

- `validate()` dispatches on shape: sets (`[]`/`{}`) validated with an enclosing-char + content regex
  then each member via `validateDate()`; intervals (`/`) split and each side validated (times not
  allowed in intervals); otherwise a single `validateDate()`.
- `validateDate($str, $strict)` round-trips the string through `DATE_PARSE_REGEX`, checks year length
  rules (>4 digits needs a `Y` prefix; <4 rejected), month/day ranges, time format, and — when
  `$strict` — re-parses with `DateTime::createFromFormat` and compares.
- `iso8601Value()` bails to `''` when `validate()` fails, else takes the first date of a set/interval,
  expands exponent years, and replaces `X` placeholders with `0`/`01`, mapping seasons to a month.
- `expandYear($full, $base, $exp)` — expands `Y…E…` exponent years.

## `EDTFConverter`

```php
use Drupal\controlled_access_terms\EDTFConverter;

EDTFConverter::datetimeIso8601Value(['value' => $edtf]); // first date -> ISO 8601 timestamp
EDTFConverter::dateIso8601Value(['value' => $edtf]);     // ... date portion only (drops time)
```

Both take `['value' => <edtf string>]` and delegate to `EDTFUtils::iso8601Value()`, assuming the
earliest possible date for approximations/intervals/sets. `dateIso8601Value` is referenced as an RDF
`datatype_callback` in the defaults submodule's mappings and used by the JSON-LD alter hook (see
[hooks/integrations.md](../hooks/integrations.md)).
