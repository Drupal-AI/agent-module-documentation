<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Optional End Month Year Range (optional_end_month_year_range) — agent index

**A DateRange-derived field type whose end date is optional, toggled by a per-value 'No end date' checkbox.**

- **Version:** 8.x-1.x  •  core: `^8 || ^9 || ^10 || ^11`  •  depends on `drupal:datetime`, `drupal:datetime_range`  •  package: Field types
- **Field type:** `OptionalEndMonthYearRangeItem` (+ `OptionalEndMonthYearRangeFieldItemList`).
- **Widget:** `OptionalEndMonthYearRangeWidget` — adds a configurable "No end date" checkbox that clears/omits the end value.
- **Formatters:** Default, Plain, Custom (`OptionalEndMonthYearRange*Formatter`), sharing `OptionalEndMonthYearRangeTrait`.
- **Routes/permissions/services/config entities:** none.

**Security:** a pure Field API plugin bundle — no routes, permissions, services or mutating endpoints; no external I/O. Access is governed entirely by the host entity's normal field/entity permissions. No security-relevant surface.
