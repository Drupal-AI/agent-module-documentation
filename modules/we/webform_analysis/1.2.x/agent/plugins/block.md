<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Analysis — Block plugin

The module ships one Block plugin (it does **not** define a new plugin *type*):

- **Plugin id:** `webform_analysis_block`
  (`Drupal\webform_analysis\Plugin\Block\WebformAnalysisBlock`).

It renders the analysis (chart/table) for a chosen webform + component on any page/region. Its block
settings form lets you pick the target `entity_id` (webform) and the component to display; it then
uses the `WebformAnalysis` handler to compute counts and render via the `webform_analysis_component`
theme hook + `webform_charts` library.

Place it like any block:
```bash
# Via the Block layout UI (/admin/structure/block) choose "Webform Analysis" and configure
# the webform + component, or create a block config entity referencing plugin 'webform_analysis_block'.
```

The submodule `webform_node_analysis` provides an analogous `webform_node_analysis_block` for
node-attached webforms.
