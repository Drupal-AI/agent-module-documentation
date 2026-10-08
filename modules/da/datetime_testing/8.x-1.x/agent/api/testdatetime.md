<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TestDateTime — clock-aware date parser

`Drupal\datetime_testing\TestDateTime` extends `DrupalDateTime` (and thus `DateTimePlus`). It exists so that `strtotime()`-style strings are interpreted relative to the module's manipulated "now" instead of the real system clock. `TestTime::setTime()` uses it internally, and custom test code can use it directly.

## Constructor

```php
new TestDateTime(string $time = 'now', ?string $timezone = NULL, array $settings = [])
```

- `$settings['current_time']` — the reference "now" (Unix timestamp) used to fill in and offset relative parts. If omitted, the constructor falls back to `\Drupal::time()->getCurrentTime()` (i.e. the manipulated clock). Stored in `$this->currentTime`.
- After capturing `current_time`, it calls the parent `DrupalDateTime::__construct($time, $timezone, $settings)`.

Because `current_time` defaults to the manipulated clock, `(new TestDateTime('now'))->getTimestamp()` equals `\Drupal::time()->getCurrentTime()`, which is **not** necessarily PHP `time()`.

## Parsing behavior (overridden `prepareTime()`)

- Runs `date_parse($time)`; parse errors are collected into `$this->errors` and an empty string is returned (no exception).
- `prepareAbsoluteTime()` builds the absolute part: missing day parts (year/month/day) are filled from the reference `current_time`; missing time parts are filled from the reference time **only when the day is also absent** — otherwise they default to `0` (so `'2018-03-03'` is midnight, while `'now'`/`'+1 hour'` inherit current time-of-day). A timezone embedded in the string is honored; a bare local time without a zone name records an error and falls back to the default timezone.
- Relative information (`$parsedDate['relative']`) is applied as `\DateInterval`s: day parts first, then a relative weekday via `setWeekday()` (uses `next <weekday>`), then time parts — ordered this way so large hour offsets and `next Tuesday` combine correctly.
- Returns `'@' . $timestamp` so `\DateTime` treats it as an absolute timestamp.

## Notes

- Helper `prepareTimeInterval()` turns a `date_parse` `relative` array into a `\DateInterval` via `\DateInterval::createFromDateString()`.
- `datePad()` (from the parent) adds leading zeros that `date_parse` omits for minute/second.
- This class has no side effects on the global clock; it only parses. To change the reported site time, use the `TestTime` service (see `service.md`).
