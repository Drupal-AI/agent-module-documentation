<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JapaneseEraFormatter is a field formatter that displays datetime values using the Japanese imperial era (wareki) calendar.

---

JapaneseEraFormatter adds a field formatter for core datetime fields that renders the stored date in the Japanese imperial era (wareki) — e.g. Reiwa/Heisei/Showa year notation — instead of the Gregorian calendar.

The single formatter plugin `datetime_japanese_era` extends core `DateTimeFormatterBase`; an `Era` PHP enum defines each era with its start date so the formatter can convert a Gregorian date to the correct era and year. Its settings form exposes the storage date format and an output `format` string, and configuration is stored via the module's config schema. There are no routes, permissions or services — it is purely a display formatter selected in a field's display settings.

Setup: on an entity's Manage display, set a datetime field's format to "Japanese Era Date Format" and adjust the format string. It only affects rendering of existing datetime values.

---
- Display a datetime field in Japanese era notation.
- Show Reiwa/Heisei/Showa year for a date.
- Convert Gregorian dates to wareki on output.
- Configure the output format string.
- Apply the formatter via Manage display.
- Localise dates for Japanese audiences.
- Render publication dates in the imperial calendar.
- Use the built-in Era enum's era boundaries.
- Keep storage Gregorian while displaying wareki.
- Format event dates in Japanese era years.
- Support multiple datetime fields per entity.
- Present historical dates in the correct era.
- Combine with other display modes.
- Show era-based dates in views field output.
- Avoid manual era conversion for editors.
- Provide culturally appropriate date display.