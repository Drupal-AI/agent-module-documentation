<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate Smartsheet provides a migrate process plugin (`smartsheet`) that pulls a single cell's value out of a Smartsheet API row's cell array by matching a configured `column_id`, with optional value comparison.
---
Given a row's `cells` array as the source `value`, `transform()` matches the element whose `columnId` equals the configured `column_id` and returns the requested `return_key` (e.g. `value`). If a `compare_value` is set, it instead returns `return_true_value` or `return_false_value` depending on whether the cell's `return_key` matches — a lightweight conditional mapping. It throws a `MigrateException` when the value is not traversable or when `column_id` is missing.

The module supplies only the process plugin; the actual Smartsheet API fetch/auth is done by a separate source (typically a `migrate_plus` URL/HTTP source with the Smartsheet API token). It depends on `migrate_plus` and `migrate_tools`. There are no routes, permissions or UI. Setup: define a migration whose source returns Smartsheet rows (with a `cells` field), then map fields through the `smartsheet` process plugin per column.
---
- Map a Smartsheet column to a Drupal field by `column_id`.
- Extract a cell's `value` from a Smartsheet row's cell array.
- Populate a node title from a Smartsheet cell.
- Return a boolean-style value using `compare_value`.
- Map a Smartsheet status column to a taxonomy term.
- Return `return_true_value`/`return_false_value` conditionally.
- Import Smartsheet sheet rows as Drupal entities.
- Combine with a migrate_plus HTTP source for the Smartsheet API.
- Select the `displayValue` vs `value` cell key via `return_key`.
- Migrate project rows from Smartsheet into content.
- Skip empty cells (returns nothing when the key is empty).
- Fail loudly when a non-traversable value is passed in.
- Run the migration with `drush migrate:import` (migrate_tools).
- Map multiple Smartsheet columns in one migration pipeline.
- Transform Smartsheet cell data into structured Drupal fields.
- Guard against a missing `column_id` configuration.
