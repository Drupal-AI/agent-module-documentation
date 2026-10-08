<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The four field formatters

All four are `@FieldFormatter` plugins with `field_types = { datetime }`. Select one on a
datetime field's row on the entity's *Manage display* page. Field Timer defines these
formatter plugins; it does **not** define any new plugin *type* or field type.

## `field_timer_simple_text` — "Text timer or countdown"

- Extends core `DateTimeTimeAgoFormatter`, so it inherits `future_format`, `past_format`,
  `granularity` settings and needs **no external JS library**.
- Adds one setting **`type`**: `auto` (default), `timer`, or `countdown`.
  - `timer` — only renders items whose date is **in the past** (a running-up timer).
  - `countdown` — only renders items whose date is **in the future** (a counting-down value).
  - `auto` — renders both.
- Schema: `field.formatter.settings.field_timer_simple_text` (extends
  `field.formatter.settings.datetime_time_ago`).

## `field_timer_countdown` — "jQuery Countdown"

- Requires the **jQuery Countdown** JS library (v2.1.0) at `libraries/jquery.countdown`.
- Renders `<span class="field-timer-jquery-countdown" data-timestamp="…">` animated by JS.
- Settings: `use_system_language` (bool), `regional` (language code, default `en`),
  `format` (default `dHMS`), `layout` (textarea), `compact` (bool), `significant`
  (granularity 0–7), `timeSeparator` (default `:`), `padZeroes` (bool). ~55 per-language
  translation libraries ship for localised labels.
- Schema: `field.formatter.settings.field_timer_countdown`.

## `field_timer_countdown_led` — "jQuery Countdown LED"

- Also requires the **jQuery Countdown** library (library key `countdown_led`, depends on
  `field_timer/jquery.countdown`).
- Settings: `countdown_theme` (`green` default / `blue`), `max_count_of_days` (1–4 digits),
  `display_days`, `display_hours`, `display_minutes`, `display_seconds` (all bool, default 1).
- Schema: `field.formatter.settings.field_timer_countdown_led`.

## `field_timer_county` — "County"

- Requires the **County** JS library at `libraries/county`.
- Renders a `container` with `<div data-field-timer-key data-timestamp="…">` per item.
- Settings: `animation` (`fade` default / `scroll`), `speed` (ms, default 500), `theme`
  (`blue` default / `black` / `gray` / `red`), `background` (CSS), `reflection` (bool,
  default 1), `reflectionOpacity` (float 0–1, default 0.2).
- Schema: `field.formatter.settings.field_timer_county`.

## Choosing

Use **`field_timer_simple_text`** when you want a server-rendered, dependency-free
timer/countdown (works out of the box on this repo's site — the JS libraries are not
installed). Use the JS formatters only when the corresponding library is present in
`web/libraries/`.
