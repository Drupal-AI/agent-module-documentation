<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, controller & storage

All routes are in `carbon_impact_evaluator.routing.yml`; controller is `CarbonImpactEvaluatorController` (`src/Controller/CarbonImpactEvaluatorController.php`).

## Storage: `co2_info` table
Defined in `carbon_impact_evaluator.install` (`carbon_impact_evaluator_schema`). One row per node, primary key `node_id`. Columns: `node_id` (int), `node_url` (text), `node_title` (text), `total_number_visits` (int), `first_visit` (int), `return_visit` (int), `per_byte` (float), `per_visit` (float), `date` (datetime), `module` (varchar). Rows are created/removed by `hook_node_insert` / `hook_node_delete` and upserted by `saveInDatabase()` (called from `hook_preprocess_page`); visit-status and CO2 columns are updated by the two AJAX endpoints below.

## AJAX endpoints (called by js/carbon-impact-evaluator.js)
Both accept a POST body param `valor` = a JSON string, decoded with `json_decode($request->get('valor'), true)`.

### `POST /carbon-impact-evaluator/visits` — `handleAjaxVisitStatus()`
- Route id `carbon_impact_evaluator.visitstatus`; `_permission: access content`; `_format: json`.
- Input JSON: `{ nid, visit_status }` where `visit_status` is expected to be `first_visit` or `return_visit`.
- Reads the row for `node_id = nid`, increments the column named by `visit_status` by 1 (`->fields([$visitStatus => $status_count])`), and returns `{status:'sucesso', valor:{first_visit,return_visit,total_number_visits}}`.

### `POST /carbon-impact-evaluator/pervisit` — `handleAjaxPerVisit()`
- Route id `carbon_impact_evaluator.pervisit`; `_permission: access content`; `_format: json`.
- Input JSON: `{ nid, identifier, calculations }` where `identifier` is expected to be `per_byte` or `per_visit`.
- Writes `calculations` into the column named by `identifier` for `node_id = nid` (`->fields([$calc_identifier => $calculations])`) and echoes the value back.

Note: field names in both updates are Drupal-escaped identifiers and the `node_id` condition and values are parameterized (no raw SQL concatenation). Neither endpoint uses `#lazy_builder`/CSRF; callers are the module's own front-end JS.

### `GET /carbon-impact-evaluator/table` — `displayTable()`
- Route id `carbon_impact_evaluator.table`; `_permission: "access content administer site configuration"` (space-separated = BOTH permissions required). Linked in the admin menu.
- Selects all rows from `co2_info` and returns a `#type => table` render array (header ID/Title/URL/Total/First visits/Return visits/CO2 Per Byte/CO2 Per Visit/Date), attaching the `carbon_impact_evaluator/carbon_impact_evaluator` library and the `carbon-table` class (which triggers the `table__carbon_table` theme suggestion → `templates/table--carbon-table.html.twig`). Values render through the core table element (auto-escaped). Minor bug: the build loops over the result set with a nested duplicate `foreach`, so rows are duplicated in output.
