<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Year/Month Widget adds a field widget for core Date/time (`datetime`) fields that lets editors pick only a year and a month — two select dropdowns, no day — instead of a full date.

---

The module provides a single field widget plugin (`YearMonthWidget`, id `year_month_widget`,
`src/Plugin/Field/FieldWidget/YearMonthWidget.php`) that extends core's `DateTimeWidgetBase` and
applies to `datetime` field types. On an entity's *Manage form display* tab you select the
**Year/month** widget for a date field; on the form it renders a core `#type => 'datelist'`
element restricted to just the year and month parts (wrapped in a fieldset). Two per-widget
settings control it: **Part order** (`part_order`, `YM` = Year/Month or `MY` = Month/Year) and
**Year range** (`year_range`, a `datelist` `#date_year_range` string such as `-3:+1`,
`2000:2010`, or `2000:+3`), which is validated against `/^[+-]?\d{1,4}:[+-]?\d{1,4}$/`. Because it
builds on the standard datetime storage, the underlying value is still a full datetime — the day
(and time) simply default from the datelist — so the field keeps working with Views, tokens, and
other datetime consumers. Settings persist in the `entity_form_display` component (schema
`field.widget.settings.year_month_widget`). No global config page, permissions, Drush, or plugin
types.

---

- Let editors enter a month + year (e.g. a card expiry, "MM/YYYY") without choosing a day.
- Capture a "start month" for a subscription or membership.
- Record an employment or education period as month/year on a profile.
- Collect a magazine/issue publication month and year.
- Set a budget or report period by month and year only.
- Provide a "valid from / valid until" month picker on a promotion.
- Ask for a project's target completion month without spurious day precision.
- Store an event's planning month before the exact date is known.
- Switch the dropdown order between Year/Month and Month/Year per field.
- Constrain the selectable years with a relative range like `-5:+1` (five years back, one ahead).
- Constrain years with an absolute range like `2000:2030`.
- Mix relative and absolute bounds, e.g. `2000:+3`.
- Replace the full core date picker where a day would be meaningless data-entry noise.
- Keep datetime storage/compatibility while presenting only month + year to the user.
- Use on multiple content types by selecting the widget per form display.
- Present a clean two-dropdown fieldset for month/year on any `datetime` field.
- Default the day/time automatically so downstream datetime logic still functions.
- Offer a lightweight alternative to full date-range modules for coarse date entry.
