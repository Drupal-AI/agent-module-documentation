<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Analysis — Block plugin

The module ships one Block plugin (it does **not** define a new plugin *type*):

- **Plugin id:** `webform_analysis_block`
  (`Drupal\webform_analysis\Plugin\Block\WebformAnalysisBlock`).

It renders the analysis (chart/table) for a chosen webform + component on any page/region. Its block
settings form (`blockForm()`) lets you pick the target `entity_id` (webform, via an AJAX-updated
select), the `component` to display, and the `chart_type`. Block config schema:
`block.settings.webform_analysis_block` (`entity_id`, `component`, `chart_type`). On `build()` it
constructs a `WebformAnalysisChart` for the selected webform/component/chart-type and renders via the
`webform_analysis_component` theme hook + `webform_charts` library. Cache is disabled
(`getCacheMaxAge()` returns 0).

Place it like any block:
```bash
# Via the Block layout UI (/admin/structure/block) choose "Webform Analysis" and configure
# the webform + component, or create a block config entity referencing plugin 'webform_analysis_block'.
```

The submodule `webform_node_analysis` provides an analogous `webform_node_analysis_block` (a subclass
overriding `elementEntityTypeId()` to `node`) for node-attached webforms.
