<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Analysis — agent index

Adds a per-webform **Analysis** results tab (counts, tables, pie/column Google charts) for selected
elements, plus an embeddable block. No global settings page, no own permission, no Drush.
Analysis tab: `/admin/structure/webform/manage/{webform}/results/analysis`
(route `entity.webform.results_analysis`).

- **Where the settings live (webform third-party settings), keys, drush, the analysis route/block** →
  [configure/results-tab.md](configure/results-tab.md)
- **The `WebformAnalysis` handler class & how to compute stats in code** →
  [api/handler.md](api/handler.md)
- **The `webform_analysis_block` Block plugin** → [plugins/block.md](plugins/block.md)

Key facts:
- Config = third-party settings on the webform config entity, namespace `webform_analysis`:
  `components` (element keys, array), `chart_type` (`''`|`PieChart`|`ColumnChart`),
  `start_date`, `end_date` (timestamps), `in_draft` (bool).
- Chart options: `''` = Table, `PieChart`, `ColumnChart` (`WebformAnalysis::getChartTypeOptions()`).
- Access reuses webform's `view any webform submission` / results access; no permission of its own.
- Submodule `webform_node_analysis` extends analysis to node-attached webforms
  (see modules/webform_node_analysis/).
