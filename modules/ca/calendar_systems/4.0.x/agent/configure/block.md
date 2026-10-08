# Calendar Systems block

Plugin id `calendar_systems_block` (`CalendarSystemsBlock`, admin label "Calendar Systems Block").
Place it like any block (Block layout, `administer blocks`). It renders the current/relative date
in a chosen calendar. There is no module-wide settings page — configuration is per block instance.

## Block settings (`blockForm`)

| Setting | Default | Notes |
|---|---|---|
| `calendar_systems_calendar` | `global` | `persian`, `gregorian`, or `global` (pick by site language). |
| `calendar_systems_format` | `Y/m/d H:i:s` | PHP `date()` format pattern. |
| `calendar_systems_timezone` | `user` | `site` (system.date default), `user` (current default tz), or a specific tz from the timezone list. |
| `calendar_systems_text` | `{}` | Wrapper text; the literal `{}` is replaced by the formatted date. Must contain `{}` or it is reset to `{}` with a warning. |
| `cache` | `3600` | Cache max-age in seconds (non-negative numeric; else reset to 3600). |

## Build behavior

- Resolves the timezone, then calls `_calendar_systems_factory($tz, NULL, $calendar)` (falling back
  to `gregorian`) and formats the current time with the chosen pattern.
- Output is `#markup` = `str_replace('{}', $formatted, $text)` with cache contexts `timezone` and
  `languages:language_interface` and the configured max-age.

> The wrapper text and format are block configuration set by a user with `administer blocks`
> (a `restrict access: TRUE` admin permission); the substituted value is a machine-formatted date.
