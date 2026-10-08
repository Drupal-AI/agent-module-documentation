<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services, data model, Form API elements, duration-string queries

## `duration_field.service` — `DurationService`

Converts freely between date arrays, `DateInterval`, ISO 8601 strings, seconds and text.
Key methods:

- `checkDurationInvalid($duration)` — throws `InvalidDurationException` if not a valid ISO 8601
  duration string (pattern `/^P(\d+Y)?(\d+M)?(\d+D)?(T)?(\d+H)?(\d+M)?(\d+S)?$/`).
- `convertDateArrayToDurationString(array $input)` — keys `y,m,d,h,i,s` → `P…T…` string (empty → `P0M`).
- `getDateIntervalFromDurationString($str)` / `getDurationStringFromDateInterval(\DateInterval)`.
- `convertDateArrayToDateInterval(array)` / `createEmptyDateInterval()` (`P0M`).
- `getSecondsFromDateInterval(\DateInterval)` / `getSecondsFromDurationString($str)`.
- `getHumanReadableStringFromDateInterval($interval, array $granularity, $separator=' ', $textLength='full', int $weeks=0)`.
- `addWeeksToDateInterval($interval, $weeks)` / `removeWeeksFromDateInterval($interval, $weeks)`.

## `duration_field.granularity.service` — `GranularityService`

- `convertGranularityArrayToGranularityString(array)` — `['y'=>TRUE,'i'=>TRUE,...]` → `y:i`.
- `convertGranularityStringToGranularityArray($str)` — inverse, returns all 6 keys as bool.
- `includeGranularityElement($unit, $granularityString)` — is unit `y|m|d|h|i|s` enabled?

## Data types & constraints

- `php_date_interval` (`DateIntervalData`) — wraps a PHP `DateInterval`; `getCastedValue()`
  returns the `DateInterval`, `setValue()` accepts a `DateInterval` or ISO 8601 string. This is
  the `duration` property's type.
- `iso_8601_string`, `granularity` config data types (`config/schema/duration_field.data_types.schema.yml`).
- Validation constraints: `Iso8601String`, `GranularityString`, `PhpDateInterval`.
- A REST/JSON:API normalizer (`serializer.normalizer.dateintervaldata`, priority 20) serializes
  the interval cleanly.

## Form API elements (usable outside a field)

### `duration`
```php
$form['length'] = [
  '#type' => 'duration',
  '#title' => $this->t('Length'),
  '#default_value' => 'PT1H30M',      // DateInterval or ISO 8601 string
  '#granularity' => 'h:i',            // which unit inputs to show (default y:m:d:h:i:s)
  '#required_elements' => 'h',        // which units are #required (default '')
  '#date_increment' => 900,           // step in seconds (900 = 15-min steps on minutes input)
];
```
The submitted value is a **PHP `DateInterval`** (converted in the element's validate handler).

### `granularity`
`'#type' => 'granularity'` — six checkboxes (Years…Seconds); value in/out is a granularity
string like `y:m:d:h:i:s`.

## Filtering by duration string (query alter)

The field stores `seconds` so durations sort/compare correctly. To let a query condition use a
**human duration string** against the `<field>_duration` column, tag the query
`duration_string`:

```php
$query = \Drupal::entityQuery('node')->accessCheck(TRUE);
$query->addTag('duration_string');
$query->condition('field_reading_time.duration', 'PT1H', '>');   // "> 1 hour"
$ids = $query->execute();
```

`duration_field_query_duration_string_alter()` rewrites the condition onto the
`<field>_seconds` column, converting the duration string to seconds. Applicable operators:
`> < >= <= =`. Without the tag, compare against `.seconds` directly (an integer count).
