<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Analysis — agent index

Adds a per-webform **Analysis** results tab (counts, tables, pie/column Google charts) for selected
elements, plus an embeddable block. No global settings page, no own permission, no Drush.
Analysis tab: `/admin/structure/webform/manage/{webform}/results/analysis`
(route `entity.webform.results_analysis`). Requires Drupal core `^11.3 || ^12`, depends on `webform`.

- **Where the settings live (webform third-party settings), keys, drush recipes, the analysis
  route/access** → [configure/results-tab.md](configure/results-tab.md)
- **The `WebformAnalysis` handler class & how to compute stats in code** →
  [api/handler.md](api/handler.md)
- **The `webform_analysis_block` Block plugin** → [plugins/block.md](plugins/block.md)

Key facts:
- Config = third-party settings on the webform config entity, namespace `webform_analysis`:
  `components` (element keys, array), `chart_type` (`''`|`PieChart`|`ColumnChart`),
  `start_date`, `end_date` (integer timestamps), `in_draft` (bool). Schema
  `webform.settings.third_party.webform_analysis`.
- Chart options: `''` = Table, `PieChart`, `ColumnChart` (`WebformAnalysis::getChartTypeOptions()`).
- Access reuses webform results access: route `_entity_access: webform.submission_view_any` +
  `WebformEntityAccess::checkResultsAccess`; operations/tab gated on `view any webform submission`.
  No permission of its own.
- Hooks live in OOP classes: `Drupal\webform_analysis\Hook\WebformAnalysisHooks` (`hook_theme`,
  `hook_entity_type_build`, `hook_entity_operation` via `#[Hook]`), delegating entity-type/operation
  alters to `Drupal\webform_analysis\EntityTypeInfo`.
- Rendering: `webform_analysis_component` theme hook (`templates/webform-analysis-component.html.twig`);
  `webform_charts` library loads Google Charts (`js/webform_analysis.charts.js` + gstatic loader).
- Chart render array is built by `WebformAnalysisChart` (data → `drupalSettings.webformcharts`).
- Submodule `webform_node_analysis` extends analysis to node-attached webforms
  (see modules/webform_node_analysis/).
