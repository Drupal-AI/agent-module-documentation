<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Date All Day — agent index

Adds an **All day** checkbox to core Datetime Range (`daterange`) widgets and three all-day-aware
formatters. No settings form, no configure route (`configure: null`), no permissions, no Drush,
no services, no plugin types, no config schema of its own. All state lives in
`core.entity_form_display.*` / `core.entity_view_display.*` components.

- **Widget + formatter ids, their settings, where they are stored, drush/PHP recipes** →
  [configure/all-day-field.md](configure/all-day-field.md)
- **How "all day" is detected & stored, the helper class, the JS, caveats** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Widget: `daterange_all_day` — "Date and time range with All day" (field types `daterange`,
  legacy `daterange_all_day`).
- Formatters (all `daterange` only): `daterange_all_day_default`, `daterange_all_day_custom`,
  `daterange_all_day_plain` *(deprecated)*.
- Extra formatter setting: `date_only_format`, default `date_all_day` (a locked core date-format
  entity with pattern `Y-m-d` installed by the module).
- **There is no "all day" flag in storage.** All-day = start time `00:00:00` **and** (end empty
  or end time `23:59:59`) in the site default timezone.
