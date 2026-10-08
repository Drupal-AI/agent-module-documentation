<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Month Year Range adds two form widgets that let editors enter a date at **month + year** (or **year only**) granularity on ordinary core Date and Date range fields.

---

The module ships no field type, formatter or storage of its own — it provides only widgets, so you keep using core's **Date** (`datetime`) or **Date range** (`daterange`) field and simply swap its widget on the entity's **Manage form display** tab. Pick **Month Year datetime** for a single Date field or **Month Year range** for a Date range field. Each widget shows core `datelist` selects trimmed to year+month, and its settings let you choose the **date part order** (Year/Month, Month/Year, or Year only), an optional **year range** to limit the selectable years (empty means no limit; accepts core syntax such as `2000:2025`, `-5:+5` or `2025:+5`), and which **day of the month** to record for the day nobody picked — first day or last day (the range widget sets this independently for the start and end). On save the widget fills that day in and stores a normal `Y-m-d` (or `Y-m-d\TH:i:s`) value, so sorting, Views filters and core date formatters keep working exactly as they would for a full date. Install it like any module (`drush en month_year_range`); it depends only on core `datetime` and `datetime_range` and targets Drupal `^8 || ^9 || ^10 || ^11`. There is no configuration page — everything is per field on the form display.

---

- Record an employment period on a CV as "March 2019 – July 2022".
- Store a project's start and end months without a made-up day.
- Capture an exhibition or residency run at month precision.
- Add a Date range field and switch its widget to Month Year range.
- Add a Date field and switch its widget to Month Year datetime.
- Show a year-only picker by setting date part order to Year.
- Restrict selectable years to `2000:2025` for a historical archive.
- Restrict selectable years to `-5:+5` around the current year.
- Order the selects Month/Year instead of Year/Month for editors who prefer it.
- Record the first day of the month for a start date automatically.
- Record the last day of the month for an end date automatically.
- Keep a course or academic term at month granularity.
- Store a publication or issue period.
- Store a grant or funding period.
- Store a contract period with month-level start and end.
- Sort a career-history view correctly because values stay real dates.
- Filter content by year in a view.
- Avoid using two plain text fields that lose validation and sortability.
- Support a staff-profile content type with honest date precision.
- Configure day handling per field on Manage form display.
