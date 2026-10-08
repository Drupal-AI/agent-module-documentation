# HMS Field — agent index

A duration field: stores signed integer **seconds**, edits/displays as Hours:Minutes:Seconds
(or w:d:h:m:s / space-separated). Depends on core `field`. Provides a config schema; no global
config page (`configure` null), no permissions, no Drush, no plugin managers.

- **Add the field, pick input/display formats, formatter options, running-timer mode** →
  [configure/field.md](configure/field.md)
- **`hms_field.hms` service (convert seconds ↔ formatted), the `hms` render element, and the two
  alter hooks** → [api/service.md](api/service.md)

Key facts:
- Field type `hms` (`HMSFieldItem`): one column `value` int, signed, nullable.
- Widget `hms_default` → custom `hms` FormElement; parses input via `HMSService::formattedToSeconds()`
  on validate, stores seconds; renders seconds back via `secondsToFormatted()`.
- Formatters: `hms_default_formatter` (format + `leading_zero`, theme `hms`) and
  `hms_natural_language_formatter` (selected fragments + `separator`/`last_separator`, theme
  `hms_natural_language`).
- Service `hms_field.hms` (`HMSService`): `formattedToSeconds`, `secondsToFormatted`, `isValid`,
  `factorMap` (unit→seconds + labels), `formatOptions`. Alterable via `hook_hms_format_alter`,
  `hook_hms_factor_alter`.
- Running-timer: default formatter `running_since` → `template_preprocess_hms()` attaches
  `hms_field/hms_field` JS + `drupalSettings` and `hms-running`/`hms-since-*`/`hms-offset-*`
  classes so the value ticks live in the browser.
