<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Cumulative Field — agent index

Two "Global" Views field handlers that compute a running/cumulative total of another numeric field in
the same view. No config page (`configure` null), no permissions, no Drush, no plugin types. Depends on
core `views`. Config schema for the two handlers' options. Everything is configured inside a View, so
access is gated by core `administer views`.

- **The two handlers, their settings (data_field / total_type / summation_method), PHP vs database (window function) modes** →
  [configure/field.md](configure/field.md)

Key facts:
- Handlers (`hook_views_data`, group `Global`): `field_cumulative_field` → `CumulativeField` (running
  sum per row); `field_cumulative_total` → `CumulativeTotalField` (grand/group total repeated per row).
- Both extend core `NumericField`.
- Options schema `views.field.field_cumulative_field` / `...total_field`: `data_field`, `total_type`
  (`grand`/`group`), `summation_method` (`php`/`database`).
- Database mode = SQL `SUM(field) OVER (PARTITION BY … ORDER BY …)`; auto-falls back to PHP when Views
  aggregation is enabled.
