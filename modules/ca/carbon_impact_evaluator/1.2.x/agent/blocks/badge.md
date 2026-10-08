<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block & front-end CO2 calculation

## Block plugin
`CarbonImpactEvaluationBlockBlock` (`src/Plugin/Block/CarbonImpactEvaluationBlockBlock.php`), annotated `@Block(id="carbon_impact_evaluator_carbon_impact_evaluation_block", admin_label="Carbon impact evaluation block", category="Custom")`. `build()` returns `#theme => carbon_impact_evaluator_block` and attaches the `carbon_impact_evaluator/carbon_impact_evaluator` library. Place it via Block layout for the badge to appear.

## Theme / template
`hook_theme` (`.module`) registers `carbon_impact_evaluator_block` with variables `per_byte` and `per_visit` (read from config at registration). Template `templates/carbon-impact-evaluator-block.html.twig` renders a toggle button and, conditionally on `per_byte`/`per_visit`, one or two panels each containing a `.carbon_count` value and an A+…F level bar with an arrow indicator.

## Library
`carbon_impact_evaluator.libraries.yml` → library `carbon_impact_evaluator`: JS `js/carbon-impact-evaluator.js` (loaded as `type: module`), CSS for the badge and table, and dependencies `core/drupal.ajax`, `core/jquery`, `core/drupalSettings`, `core/drupal`, plus `carbon_impact_evaluator/tgwf_co2`. (Caveat: `tgwf_co2` is referenced but not defined in the libraries file — a dangling dependency; the actual CO2.js code is instead `import`ed directly in the JS.)

## JavaScript flow (`js/carbon-impact-evaluator.js`)
Top of file: `import { co2 } from "https://esm.sh/@tgwf/co2@latest";` — the Green Web Foundation CO2.js library is fetched client-side from the esm.sh CDN at browser runtime. Behavior `Drupal.behaviors.carbonImpactButton`:
- On badge-button click, toggles the panel and runs `check_per_byte()` and `check_per_visit()`.
- `getPageSize()` sums `transferSize` across `performance.getEntriesByType('resource')` + the navigation entry to get the page's real byte weight.
- **Per Byte** (`check_per_byte`, when `drupalSettings.per_byte == 1`): `new co2({model:'1byte', version:4}).perByte(pageSize, Greenhost)`, formats to 3 decimals, colour-grades A+…F, and POSTs to `/carbon-impact-evaluator/pervisit` with `identifier: 'per_byte'`.
- **Per Visit** (`check_per_visit`, when `drupalSettings.per_visit == 1`): uses `localStorage[nid]` to decide first vs return visit, then POSTs `{nid, visit_status}` to `/carbon-impact-evaluator/visits`. On success `getCO2()` computes first/return percentages and calls `new co2({model:'swd', version:4}).perVisitTrace(pageSize, Greenhost, {dataReloadRatio, firstVisitPercentage, returnVisitPercentage, gridIntensity:{dataCenter:{country: Datacenter_country}}}).co2`, grades it, and POSTs the value to `/pervisit` with `identifier: 'per_visit'`.

`drupalSettings` values (`nid`, `per_byte`, `per_visit`, `Greenhost`, `Datacenter_country`) are supplied by `carbon_impact_evaluator_preprocess_page()` in the `.module` file, only on node pages outside `admin` and `carbon-impact-evaluator` paths.
