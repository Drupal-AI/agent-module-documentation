# Calendar Systems — date formatting API

## `date.formatter` service override

`CalendarSystemsServiceProvider` (auto-discovered) rewrites the `date.formatter` service to
`Drupal\calendar_systems\CalendarSystemsFormatter`. Consequence: **any** date formatted via
`\Drupal::service('date.formatter')->format()` / `->formatTimeDiff()` — which covers most themed
dates and the core `[date:*]` / `[node:created:*]` tokens — is rendered in the active calendar.
You do not call anything to opt in; enabling the module localizes site dates globally.

## Calendar & language selection

Internal factory `_calendar_systems_factory($tz, $lang_code, $calendar_name)`:
- If no calendar name given, it derives one from the current interface language: `fa` → `persian`,
  `en` → `gregorian`; a single-language site defaults to `persian`.
- `define('CALENDAR_SYSTEMS_USE_INTL', FALSE && …)` — shipped as FALSE, so it returns the bundled
  dependency-free implementations `CalendarSystemsPoorMansJaliliCalendar` (persian) or
  `CalendarSystemsPoorMansGregorianCalendar` (default). Flip requires editing the module.
- Implementations live in `src/CalendarSystems/` behind `CalendarSystemsInterface`
  (`format()`, etc.).

## Format one date programmatically

Use `Drupal\calendar_systems\CalendarSystems\CalendarSystemsDrupalDateTime` (a `DrupalDateTime`
subclass) when you need a specific date localized outside the formatter, e.g. in the block build.
A plain `DrupalDateTime` still formats with PHP's native Gregorian calendar.

## Gregorian-escape tokens (`hook_tokens`)

Because the formatter localizes everything, the module adds date-token variants that force plain
Gregorian output for machine-readable/SEO contexts:

- `[date:gregorian]` — the `medium` date format, Gregorian.
- `[date:gregorian:<format_name>]` — a named date format (e.g. `html_datetime`), Gregorian.
- `[date:gregorian:custom:<PHP pattern>]` — a custom pattern, e.g. `[node:created:gregorian:custom:Y-m-d]`.

These build a fresh `DrupalDateTime::createFromTimestamp()` and format with the pattern, bypassing
the swapped formatter. Registered via `calendar_systems_token_info()` (dynamic `gregorian` token
under type `date`).

## Input normalization helpers

- `_calendar_systems_tmp_fix_string()` — converts Persian digits (۰–۹) to ASCII 0–9.
- `_calendar_systems_arg_handler_trait_translate()` — normalizes Persian/Arabic digits and Farsi
  relative-date words (امروز→today, دیروز→-1 day, فردا→+1 day, پیش→ago, …) to machine values;
  used by the Views date argument handlers so Jalali/Farsi input parses correctly.
