<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Filter Last Delta (vfld) — agent index

Adds one **Views filter handler** that restricts a view to rows holding the **last delta** (the
highest-numbered, i.e. last-entered value) of a multi-value field. Mechanism: `vfld.views.inc`
implements `hook_views_data_alter()` and, for every field-data table that exposes a `delta` column
with a `filter.field_name`, registers a companion filter definition `{delta}_vfld` under the **Last
Delta** group. That definition uses the filter plugin `Drupal\vfld\Plugin\views\filter\LastDeltaFilter`
(`@ViewsFilter("vfld")`). The filter is a Yes/No toggle; when set to *Yes* its `query()` adds a
`WHERE delta IN (SELECT MAX(delta) …) OR delta IS NULL` condition (a correlated subquery keyed on the
base entity id), so only the last-delta row survives. It is a pure query convenience — no routes,
no services, no controllers, no templates, no rendering of any field value.

- Depends on: `drupal:views`. Core: `^8.8 || ^9 || ^10 || ^11`. Package: `Views`.
- No settings page / `configure` route — configured entirely per-view when adding the filter.
- No permissions, no drush commands, no defined plugin *types*. Provides config schema
  (`views.filter.vfld`).
- Ships a test-only helper module `vfld_test_view` under `tests/` (not installed in production).

## What you'd do → where

- **Add / expose the last-delta filter in a view, or understand where the "Last Delta" filters come
  from** → [hooks/views-data-alter.md](hooks/views-data-alter.md)
- **Understand the filter plugin: operator, value form, and the SQL it builds** →
  [plugins/last-delta-filter.md](plugins/last-delta-filter.md)

## Key facts (real machine names)

- Views filter plugin id: `vfld` (`@ViewsFilter("vfld")`), class
  `Drupal\vfld\Plugin\views\filter\LastDeltaFilter` (extends `FilterPluginBase`,
  implements `ContainerFactoryPluginInterface`; injects `entity_type.manager`).
- Hook: `vfld_views_data_alter()` in `vfld.views.inc` (implements `hook_views_data_alter`).
- Generated filter key per eligible table: `{table}[{column}_vfld]` (column is always `delta`);
  `group` = `Last Delta`, `title` = `@label (last)`, `filter.id` = `vfld`, `filter.field` = `vfld`,
  `allow empty` = TRUE; carries the source `field_name` and `entity_type`.
- Filter operator: `=` (`Is last delta`), single value; value options `0 => No`, `1 => Yes`
  (default `0`). Properties: `$alwaysMultiple = TRUE`, `$always_required = TRUE`.
- Config schema: `views.filter.vfld` (`config/schema/vfld.views.schema.yml`) — `value` is an integer
  (`Apply Last Delta Filter`).
- No routes, services, permissions, or drush.
