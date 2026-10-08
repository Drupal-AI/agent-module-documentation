<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Time and Time Range Picker Field (time_picker) — agent index

Provides **two field types** for storing a time of day with **no date attached**, each with its own
widget and formatter. Version **6.0.0**. `core_version_requirement: ^8 || ^9 || ^10 || ^11`.
Declares a `drupal:datetime` dependency (legacy — the code does not use it). No module settings page,
no permissions, no form-element/render element, no config schema.

## The two field types
- **`time_picker`** — a single time. One stored column `time` (VARCHAR 255). Default widget
  `time_picker_widget`, default formatter `time_picker_formatter`.
- **`time_range_picker`** — a start and an end time. Stored columns `start` and `end` (both
  VARCHAR 255). Default widget `time_range_picker_widget`, default formatter
  `time_range_picker_formatter`.

(Both field types also declare an unused `locate` string property with no matching schema column.)

## Mechanism (how the picker works)
The widget renders a plain Drupal `#type` `textfield` (`#size`/`#maxlength` 10) with a CSS class
(`timepicker` for single, `time_range_picker` for range), wrapped in a `fieldset` when the field is
single-value. `js/drupal.time_picker.js` calls **Materialize**'s jQuery `.timepicker()` on those
inputs, producing the analog clock-face modal. **Materialize 1.0.0-beta is loaded from the cdnjs
CDN** (`time_picker.libraries.yml`), not bundled — the widget needs outbound access to
`cdnjs.cloudflare.com` and falls back to a bare text field without it. `css/time_picker.css` is a
vendored slice of Materialize plus the five color themes.

## Per-field storage settings (`storageSettingsForm`)
- **`time_picker_theme`** — `theme_default` | `theme_sky_blue` | `theme_iris_blue` |
  `theme_parrot_green` | `theme_dark_gray`. Applied as a CSS class on the wrapping fieldset via JS.
- **`hour_format`** — `12h` | `24h`.

Both are passed to `drupalSettings` (`time_picker` / `time_range_picker` keys, `{hour_format,
theme_color}`) for the JS to read.

## Value format & validation
Stored as a **string**, not a timestamp. On submit the widget validates each value with a regex:
`^(0?[1-9]|1[012])(:[0-5]\d) [APap][mM]$` for 12-hour (e.g. `9:30 AM`), `^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$`
for 24-hour (e.g. `14:30`). The range widget additionally parses both ends with `DrupalDateTime` and
errors when start is later than end.

## Semantics an agent must keep in mind
1. **No date means no timezone.** `09:00` is `09:00` for every reader — right for opening hours,
   wrong for anything a visitor in another country must convert.
2. **A range cannot cross midnight.** The start/end check is a naive `DrupalDateTime` comparison, so
   `22:00`–`06:00` is rejected as invalid.
3. **A time is not a schedule.** This stores *when*, not *on which days*; a day dimension is a
   separate content-modelling decision.

The formatter prints the stored string verbatim (`start - end` for a populated range), with no
reformatting.

See `fields/` for field-type/widget/formatter detail.
