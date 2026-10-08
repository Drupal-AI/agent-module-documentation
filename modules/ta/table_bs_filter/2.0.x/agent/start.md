<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Table Bootstrap Filter — agent index

A single text-format filter that adds Bootstrap `table` classes + a `table-responsive` wrapper to
every `<table>` in filtered output. Depends on core `editor` + `filter`. No config page
(`configure` null), no permissions, no Drush.

- **Enable & configure the filter on a text format (the 5 settings)** →
  [configure/filter.md](configure/filter.md)

Key facts:
- Filter plugin `@Filter(id = "table_bs_filter")` (`TYPE_TRANSFORM_REVERSIBLE`) →
  `Drupal\table_bs_filter\Plugin\Filter\TableBSFilter`.
- Settings (schema `filter_settings.table_bs_filter`): `remove_width_height`, `table_bordered`,
  `table_condensed`, `table_row_hover`, `table_striping` (all booleans).
- `process()` regex-rewrites `<table>` (and optionally `<tr|td|th>`) tags, preserving `id`/`class`/
  `style`/`dir`, and wraps output in `<div class="table-responsive">…</div>`.
- Configured per text format (`administer filters`, a trusted admin op) — no untrusted input reaches
  a new sink beyond what the format already permits.
