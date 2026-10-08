<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Date range formatter (date_range_formatter) — agent index

Provides ONE field formatter, `date_range_without_time`, for core `daterange` fields.
It renders a start/end range with a per-granularity PHP `date()` pattern (same-day,
same-month, same-year, multi-year) and a brace syntax (`{X}`) that pulls element `X`
from the END date. Display-only: changes rendering, never stored data. Version 4.0.3.

- Dependency: core `datetime_range` (module `drupal:datetime_range`).
- Configure route: none. Settings live on each field's display (formatter settings form),
  not on a global admin page — set them per entity-view-display / views field.
- Permissions: none. Drush: none. Defines no plugin type (it is one formatter plugin).
- Config schema: yes (`field.formatter.settings.date_range_without_time`).

Solution docs:
- **Add/configure the date-range formatter, its per-granularity formats and brace syntax** → [fields/formatter.md](fields/formatter.md)

Key facts:
- Formatter plugin id: `date_range_without_time` (label "Date range"), field type `daterange`.
- Class: `Drupal\date_range_formatter\Plugin\Field\FieldFormatter\DateRangeFormatterRangeFormatter`
  (extends core `DateTimeCustomFormatter`).
- Settings keys: `one_day`, `one_month`, `several_months`, `several_years`, `single`,
  `single_all_day`, `separator` (plus inherited `date_format`, `timezone_override`).
- Schema type: `field.formatter.settings.date_range_without_time` (extends
  `field.formatter.settings.datetime_custom`).
- Update hook: `date_range_formatter_update_8703` (strips old `single`/`single_all_day`
  settings from stored view / entity-view-display config).
