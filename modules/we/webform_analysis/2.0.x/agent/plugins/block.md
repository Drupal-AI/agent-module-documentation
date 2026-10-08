<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Analysis — Block plugin

The module ships one Block plugin (it does **not** define a new plugin *type*):

- **Plugin id:** `webform_analysis_block`
  (`Drupal\webform_analysis\Plugin\Block\WebformAnalysisBlock`, admin label "Webform Analysis",
  category "Webform").

It renders the analysis (chart/table) for a chosen webform + component on any page/region. Config
schema `block.settings.webform_analysis_block` has three keys — `entity_id` (the webform),
`component` (element key), and `chart_type` (`''`|`PieChart`|`ColumnChart`). Its `blockForm()`:

- `entity_id` — a select of all webforms (`@label (@id)`), with an AJAX callback (`updateEntity()`)
  that repopulates the component select when the webform changes;
- `component` — a select of the chosen webform's elements (labels from `getElements()`), wrapped in
  `#edit-component-wrapper` for the AJAX replace;
- `chart_type` — a select from `WebformAnalysis::getChartTypeOptions()`.

`build()` loads the configured webform, constructs a `WebformAnalysisChart($entity, NULL,
[$component], $chart_type)` and calls `->build($build)` to render via the `webform_analysis_component`
theme hook + `webform_charts` library. The block sets no cache contexts/tags and `getCacheMaxAge()`
returns 0 (always uncached), so counts reflect current submissions on every view.

Place it like any block:
```bash
# Via the Block layout UI (/admin/structure/block) choose "Webform Analysis" and configure
# the webform + component + chart type, or create a block config entity referencing plugin
# 'webform_analysis_block'.
```

The submodule `webform_node_analysis` provides an analogous `webform_node_analysis_block`
(`WebformNodeAnalysisBlock extends WebformAnalysisBlock`, only overriding `elementEntityTypeId()` to
`node`) for node-attached webforms.
