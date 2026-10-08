<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — Calculate Working Days

## Class
`\Drupal\calculate_working_days\CalculateWorkingDays` (plain object, `new`-able):
- `setFreeWeekDays(array $weekDays)` — values 1(Mon)–7(Sun); validates range.
- `addFreeDay(int $day, int $month, $year = FALSE)` — recurring (year FALSE) or per-year holiday.
- `addFreeOcassionDay(...)` / `addFreeOcassionDays(...)` — occasion-based free days.
- `calculateWorkingDays(int $startTs, int $endTs): int` — count of working days (both ends inclusive per loop).
- `calculateEndDate(int $startTs, int $workingDays): int` — timestamp after consuming N working days.
- `getMonthWorkingDays(int $month, int $year): array` / `getMonthFreeDays(...)` — day-of-month lists.

## Procedural wrappers (`.module`)
These build a populated object from `calculate_working_days.settings` and delegate:
- `calculate_working_days_get_work_days($startTs, $finalTs)`
- `calculate_working_days_get_work_days_monthly($month, $year)`
- `calculate_working_days_get_free_days_monthly($month, $year)`

All inputs are UNIX timestamps / integers. Iteration adds 86400s per step, so DST-crossing ranges may drift by an hour at boundaries.
