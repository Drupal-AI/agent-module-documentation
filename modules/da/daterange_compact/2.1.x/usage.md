<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Compact Date Range Formatter renders date/time range fields in a shortened form that omits duplicated month or year, e.g. `24–25 January 2017` or `9:00am–4:30pm, 1 April 2017`.

---

The module adds a **"Compact"** field formatter (`daterange_compact`) usable on `daterange`, `datetime` and `timestamp` fields. The compact rules live in a **config entity type** `daterange_compact_format` (config prefix `daterange_compact.format`, managed at *Configuration → Regional and language → Compact date and time range formats*, route `entity.daterange_compact_format.collection`). Each format holds a required `default_pattern` plus optional start/end patterns and separators for the **same-day**, **same-month** and **same-year** cases, PHP date-format tokens throughout (like core date formats), plus `default_separator`, `same_day_omit_duplicate_ampm`, `zero_minutes_omit` and `zero_minutes_omit_pattern`. At display time the formatter picks the most compact applicable pattern set by comparing the start/end values (falling back to the default), then delegates the actual rendering to core's `date.formatter` service, joining the two ends with the appropriate separator (and collapsing to a single value when both ends render identically). Two formats ship preinstalled: **`medium_date`** ("Medium (date only)") and **`medium_datetime`** ("Medium (date & time)"). The same logic is exposed programmatically through the `daterange_compact.formatter` service (`formatDateRange()` / `formatTimestampRange()`), which returns a `FormattedDateTimeRange` value object. Requires core's Datetime Range module.

---

- Display an event's start/end dates compactly as `24–25 January 2017` instead of repeating the month.
- Show a same-year range as `29 January–3 February 2017` by omitting the duplicated year.
- Render a same-day time range as `9:00am–4:30pm, 1 April 2017`.
- Collapse a range whose start and end are identical to a single date/time.
- Define multiple named formats (e.g. short, medium, long) and pick per field display.
- Apply the compact formatter to a core `daterange` field on a content type.
- Use the compact formatter on a plain `datetime` field (start = end).
- Use the compact formatter on a `timestamp` field.
- Configure custom separators (e.g. en dash, "to") between range ends.
- Omit a duplicated am/pm marker within a same-day time range (`same_day_omit_duplicate_ampm`).
- Drop `:00` minutes when they are zero via `zero_minutes_omit` / `zero_minutes_omit_pattern`.
- Manage formats through the admin UI at Regional and language settings.
- Ship formats as exported configuration for consistent display across environments.
- Format a date range in custom code via the `daterange_compact.formatter` service.
- Produce compact ranges from raw UNIX timestamps with `formatTimestampRange()`.
- Produce compact ranges from ISO-8601 strings with `formatDateRange()`.
- Localize output by passing a langcode/timezone to the formatter service.
- Reuse the preinstalled `medium_date` / `medium_datetime` formats out of the box.
- Present conference or opening-hours ranges without redundant month/year text.
- Keep listing pages tidy by shortening long date-range strings.
- Build a `FormattedDateTimeRange` value for use in a Twig template or REST output.
- Standardize date-range display across many fields by referencing one shared format.
