<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A field widget for core single-value datetime fields that enforces a configurable minimum and/or maximum allowed date, supporting relative expressions like "today" or "-18 years".

---

Date Range Widget (drw) provides one field widget, `drw_date_range`, for core `datetime` fields. The widget adds Minimum date and Maximum date settings on Manage form display; each accepts an absolute date (`2000-01-01`) or a relative expression parsed by `DrupalDateTime` (`today`, `-18 years`, `+90 days`, `+1 year`, `-2 weeks`). The widget forces date-only entry (no time component), sets HTML5 `min`/`max` attributes on the input, and — via `hook_entity_bundle_field_info_alter()` — attaches a server-side `DateRange` validation constraint so out-of-range submissions are rejected even when HTML5 validation is bypassed. Optional custom, translatable error messages use `@min` and `@max` placeholders; enabling them adds `novalidate` to the form so the server-side messages are shown. The module has no routes, permissions, Drush commands, external libraries or JavaScript. The name "Date Range" refers to the allowed range a single date must fall within — it is not a two-date start/end range widget and it does not enforce start-before-end.

---

- Restrict a date field to on or after a minimum date.
- Restrict a date field to on or before a maximum date.
- Enforce an inclusive min-and-max window on a single date field.
- Implement age verification with a maximum of `-18 years` (or `-21 years`).
- Require future-only dates with a minimum of `today`.
- Require past-only dates with a maximum of `today`.
- Limit an event registration date to a fixed period (`Min: 2024-01-01`, `Max: 2024-12-31`).
- Constrain an appointment/booking date to a rolling window (`Min: today`, `Max: +90 days`).
- Set a minimum lead time such as `+3 days` before an order date.
- Cap how far ahead a reservation may be made (`Max: +1 year`).
- Use absolute ISO dates (`YYYY-MM-DD`) as hard boundaries.
- Use relative expressions (`+3 months`, `-2 weeks`) that re-evaluate each time the form is rendered.
- Force date-only input on a datetime field, hiding the time component.
- Emit HTML5 `min`/`max` attributes for browser-level date picker hints.
- Fall back to server-side validation when the browser cannot enforce the range.
- Show a custom, translatable error message when a date is before the minimum, using `@min`.
- Show a custom, translatable error message when a date is after the maximum, using `@max`.
- Provide a custom "required field" message when the field is empty and required.
- Apply different date rules per field by configuring each field's widget separately.
- Add date-range validation to any fieldable entity (nodes, users, taxonomy, custom entities) without writing code.
- Keep the setup dependency-free and JavaScript-free for lightweight sites.
