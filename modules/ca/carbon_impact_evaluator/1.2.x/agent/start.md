<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Carbon impact evaluator (carbon_impact_evaluator) — agent index

Estimates and displays the CO2 footprint of node pages (per byte and per visit) using the Green Web Foundation CO2.js library. Calculation runs client-side in the browser; results are posted back and stored in a custom `co2_info` table.

- **Version dir:** 1.2.x (installed 1.2.2) · **Core:** ^10 || ^11 · **License:** GPL-2.0-or-later
- **Dependencies:** none declared beyond core (uses node hooks, database, config). No composer.json, no `.services.yml`, no `.permissions.yml`.
- **External lib:** `@tgwf/co2` imported client-side via `import` from `https://esm.sh/@tgwf/co2@latest` in `js/carbon-impact-evaluator.js`. No server-side external HTTP calls.

## What it provides
- **Block plugin** `carbon_impact_evaluator_carbon_impact_evaluation_block` (`src/Plugin/Block/CarbonImpactEvaluationBlockBlock.php`) — renders the floating badge via `#theme` `carbon_impact_evaluator_block` (`templates/carbon-impact-evaluator-block.html.twig`) and attaches the `carbon_impact_evaluator/carbon_impact_evaluator` library.
- **Settings form** `SettingsForm` (`src/Form/SettingsForm.php`) — config `carbon_impact_evaluator.settings` (keys: `per_byte`, `per_visit`, `greenhost`, `dataCenter`).
- **Controller** `CarbonImpactEvaluatorController` (`src/Controller/CarbonImpactEvaluatorController.php`) — two AJAX write endpoints + one admin table view.
- **Database table** `co2_info` (`carbon_impact_evaluator.install`, `hook_schema`) — one row per node id.
- **Hooks** in `carbon_impact_evaluator.module`: `hook_theme`, `hook_theme_suggestions_table`, `hook_node_insert`, `hook_node_delete`, `hook_preprocess_page` (attaches drupalSettings and records visits).
- **Config schema** `config/schema/carbon_impact_evaluator.schema.yml` (note: schema is a stub declaring only an `example` string; it does not match the real keys).

## Routes (see agent/api/endpoints.md)
- `POST /carbon-impact-evaluator/visits` → `handleAjaxVisitStatus` — perm `access content`, JSON.
- `POST /carbon-impact-evaluator/pervisit` → `handleAjaxPerVisit` — perm `access content`, JSON.
- `GET /carbon-impact-evaluator/table` → `displayTable` — perm `access content administer site configuration` (both required).
- `GET /admin/config/system/carbon-impact-evaluator/settings` → `SettingsForm` — perm `administer site configuration`.

## Solution docs
- [Configuration & settings](config/settings.md) — settings form, config keys, block placement, datacenter validation.
- [API / routes & controller](api/endpoints.md) — the AJAX endpoints, admin table, and `co2_info` schema.
- [Block & front-end calculation](blocks/badge.md) — the block plugin, template, and CO2.js JavaScript flow.
