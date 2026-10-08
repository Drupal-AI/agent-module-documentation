<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Calculate Working Days (calculate_working_days) — agent index

**Business-calendar utility: computes working days between dates given configurable weekends, holidays and occasions.**

- **Version:** 2.0.x
- **Core:** ^8.8 || ^9 || ^10
- **Configure:** `/admin/config/regional/calculate-working-days`
- **Config object:** `calculate_working_days.settings` (`weekdays`, `days`, `ocassion`)
- **API:** class `\Drupal\calculate_working_days\CalculateWorkingDays` + `.module` wrapper functions `calculate_working_days_get_work_days()`, `..._get_work_days_monthly()`, `..._get_free_days_monthly()`.

**Security:** the config form route is gated only by `_permission: 'access content'` — effectively anonymous, so any visitor can view and submit it and overwrite the site's holiday/weekend configuration (`CalculateWorkDaysForm::submitForm`). Re-gate to `administer site configuration` before relying on it. The calculation code performs no SQL or external I/O.

See [api/functions.md](api/functions.md).
