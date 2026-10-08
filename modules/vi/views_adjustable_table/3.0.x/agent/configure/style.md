<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring an adjustable-columns table

## Enable & set the style
1. `drush en views_adjustable_table` (requires `views`).
2. Edit a View → a display → **Format** → choose **Adjustable table** (`adjustable_table`).
3. In the style **Settings** you get everything core's Table style offers (column grouping, sortable, separators, hide-empty, responsive priorities) plus:
   - **Preselected column** checkbox per field — the columns shown on first load and whenever the user selects an empty set.
   - **Column selection widget** — currently `bsmSelect`.

## How selection works (runtime)
- `AdjustableTable::init()` injects the `at_selection` filter and seeds the exposed `columns` input from `getPreselectedColumns()` (preselected fields, else the first column).
- The exposed form (`SelectionHandler::buildExposedForm`) renders a multi-select of column labels keyed `f0, f1, …` (index of each non-excluded field). With bsmSelect it attaches `core/jquery.ui.sortable`, `…draggable`, `…droppable`, and the module's bsmselect libraries; ordering is drag-and-drop.
- `AdjustableTable::query()` maps the submitted `f<n>` keys back to field machine names, keeps only matching non-excluded field handlers, and rewrites `display_handler->handlers['field']` + `options['columns']`. Unknown keys are skipped (`array_key_exists`).

## Notes
- Expose the view (or place it where the exposed form shows) so visitors see the picker.
- Fields marked *Exclude from display* are never selectable.
- Purely presentational: no user value is concatenated into SQL.
