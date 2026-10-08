<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# NBSP Filter (nbsp_filter) — agent index

A single text-format `@Filter` plugin (`nbsp_filter`) that manages non-breaking spaces at
render time: it can strip all existing non-breaking spaces back to normal spaces, and insert
`&nbsp;` or narrow no-break spaces (U+202F) before/after configured characters — chiefly for
French-style punctuation spacing. Core-only; no dependencies, no services, no permissions,
no routes of its own.

- **Enable it and tune its rules on a text format** → [configure/filter.md](configure/filter.md)

Key facts:
- Plugin class `Drupal\nbsp_filter\Plugin\Filter\NbspFilter`, id `nbsp_filter`, type
  `TYPE_TRANSFORM_IRREVERSIBLE`.
- Configured through the standard text-format UI at `/admin/config/content/formats`
  (`configure: filter.admin_overview`); per-format settings live in
  `filter.format.<id>.filters.nbsp_filter`.
- Config schema `filter_settings.nbsp_filter` (config/schema/nbsp_filter.schema.yml) with keys
  `clean_all`, `insert_before`, `insert_after`, `insert_narrow_before`, `insert_narrow_after`.
- Defaults: `clean_all` = TRUE, `insert_before` = `?!;:`, `insert_after` = `¿¡`,
  `insert_narrow_before` = `»`, `insert_narrow_after` = `«`.
- `.module` file is empty — no hooks. No `.permissions.yml`, `.routing.yml`, `.services.yml`,
  drush commands, or libraries.
- Core requirement `^8 || ^9 || ^10 || ^11`; package `Filters`.
