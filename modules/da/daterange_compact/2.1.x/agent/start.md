<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Compact Date Range Formatter — agent index

Adds a **"Compact"** field formatter (`daterange_compact`) for `daterange` / `datetime` /
`timestamp` fields that omits duplicated month/year (e.g. `24–25 January 2017`). Compact rules
live in the **`daterange_compact_format`** config entity type; the same logic is exposed as the
`daterange_compact.formatter` service. Requires core `datetime_range`. Configure route:
`entity.daterange_compact_format.collection` (Regional and language settings). No permissions
beyond `administer site configuration`, no Drush.

- **Manage format config entities, all pattern keys, the field-formatter setting** →
  [configure/formats.md](configure/formats.md)
- **Call it in code: `daterange_compact.formatter` service methods** →
  [api/formatter-service.md](api/formatter-service.md)

Key facts:
- Format entities: config prefix `daterange_compact.format.<id>`. Two ship preinstalled:
  `medium_date`, `medium_datetime`.
- Formatter id `daterange_compact`; setting `daterange_compact_format` (default `medium_date`)
  selects which format entity to use.
- Each format: required `default_pattern` + optional same-day / same-month / same-year
  start/end patterns & separators; PHP date tokens; `zero_minutes_omit`,
  `same_day_omit_duplicate_ampm`. Rendering delegates to core `date.formatter`.
