<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Calculate Working Days provides procedural helper functions and a config form to compute working days (excluding weekends, fixed holidays and one-off occasions) for an organisation.

---

The module stores its calendar in `calculate_working_days.settings`: which weekdays are free, a list of recurring/one-off holiday dates (`03-12` or `03-12-2014`), and named "occasion" days. The `CalculateWorkingDays` value object applies those rules and exposes `calculateWorkingDays()`, `calculateEndDate()`, `getMonthWorkingDays()` and `getMonthFreeDays()`. Thin `.module` wrapper functions (`calculate_working_days_get_work_days()`, `..._monthly()`, etc.) populate the object from config for other modules to call.

Security note: the configuration form at `/admin/config/regional/calculate-working-days` is registered with `_permission: 'access content'`. Because "access content" is granted to anonymous users by default, this administrative config form is effectively public — any visitor can load it and submit it, overwriting the site's weekend/holiday settings. This is broader than an admin config form should be; if you rely on this module, override the route to require `administer site configuration` (or a dedicated permission). The compute functions themselves take integer timestamps and validate day/month/year ranges, with no SQL or external I/O.

---
- Compute the number of working days between two timestamps
- Find the end date after N working days from a start date
- List the working days of a given month/year
- List the free (non-working) days of a given month/year
- Configure which weekdays count as free (e.g. Sat/Sun)
- Define recurring annual holidays in `DD-MM` format
- Define single-year holidays in `DD-MM-YYYY` format
- Define named "occasion" free days (e.g. last Monday of April)
- Call `calculate_working_days_get_work_days()` from custom code
- Call `calculate_working_days_get_work_days_monthly()` for a month total
- Preview free days interactively via the datepicker UI
- Feed working-day counts into SLA or deadline calculations
- Drive delivery-date estimates from a business calendar
- Reuse the `CalculateWorkingDays` class standalone in services
- Harden the config route to `administer site configuration` before use
- Localise the business calendar per regional settings
