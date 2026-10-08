<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Time service API — TestTimeInterface / TestTime

`datetime_testing.services.yml` registers `datetime_testing.test_time` (`Drupal\datetime_testing\TestTime`) as a **decorator of core `datetime.time`** with `decoration_priority: 5`, `public: false`, constructed with the inner real service (`@datetime_testing.test_time.inner`) and `@keyvalue`. Because it decorates `datetime.time`, `\Drupal::time()` (and anything injecting `datetime.time`) returns this object site-wide. It implements `TestTimeInterface`, which **extends** core `\Drupal\Component\Datetime\TimeInterface`, so all core getters still work.

The services file also sets the parameter `datetime_testing.skip_procedural_hook_scan: true`.

## Interface methods (`TestTimeInterface`, in addition to inherited `TimeInterface`)

- `setTime(int|float|string $time): void` — set the reported "now". Ints/floats are Unix timestamps; strings are parsed via `TestDateTime` relative to the current manipulated time and the default Drupal timezone. Setting the time does **not** pin it: unless frozen, the clock keeps advancing from that point.
- `resetTime(): void` — clear all manipulation; restore the true system time and unfreeze.
- `freezeTime(): void` — stop the clock advancing (pins it to the current manipulated moment).
- `unfreezeTime(): void` — let the clock flow again from where it was; time lost while frozen is **not** restored.

Inherited (core) getters that now honor the manipulation: `getCurrentTime()`, `getCurrentMicroTime()`, `getRequestTime()`, `getRequestMicroTime()`.

## How TestTime works (implementation notes)

State is persisted in the **keyvalue** collection `datetime_testing` (`TestTime::DATETIME_TESTING_STORE`), so manipulations survive across the separate HTTP requests of a functional test. Keys used:

- `datetime_testing.specified_time` — the base timestamp override (or `NULL` when unset).
- `datetime_testing.time_passing` — `FALSE` = frozen, `TRUE` = flowing, `NULL` = never manipulated.
- `datetime_testing.time_started` — real micro-time captured when the clock last started flowing, used to compute elapsed time.

- `getCurrentMicroTime()` — returns `base + elapsed`, where `base` is `specified_time` (or the real micro-time if none) and `elapsed` comes from `getMicroTimePassed()` (real-now minus `time_started`, but `0` when frozen or no start recorded). `getCurrentTime()` casts that to `int`.
- `freezeTime()` — if not already frozen, calls `setTime(getCurrentMicroTime())` then sets `time_passing = FALSE`. `unfreezeTime()` — only acts if currently frozen: sets `time_passing = TRUE` and records a fresh `time_started`.
- `getRequestTime()` / `getRequestMicroTime()` — subtract the real request lag (real current minus real request time) from the manipulated current time. `getRequestTime()` caches the lag on first call (`$cachedRequestLag`) to avoid decreasing results from rounding; a code comment notes micro-time is unavailable in kernel tests (core issue #3168449).
- Uses `DependencySerializationTrait` so the decorator can be serialized.

## Typical usage

```php
\Drupal::time()->setTime('2008-12-03 09:15pm');
\Drupal::time()->freezeTime();            // clock now fixed
$now = \Drupal::time()->getCurrentTime(); // stable across sleeps/requests
\Drupal::time()->unfreezeTime();          // resumes flowing
\Drupal::time()->resetTime();             // back to real time
```

Note: passing a non-string/int/float to `setTime()` throws `\Exception`. Setting the time discards any known fractional second.
