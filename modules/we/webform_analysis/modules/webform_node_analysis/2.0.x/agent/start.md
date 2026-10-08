<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Node Analysis — agent index

Submodule of **webform_analysis** that extends the Analysis feature to webforms embedded in nodes via
a webform field. Adds a per-node "Analysis" tab and a block. Depends on `webform:webform_node` +
`webform_analysis:webform_analysis`. Requires Drupal core `^11.3 || ^12`. No config, no permission,
no Drush — pure routing/UI glue.

- **Route, local task deriver, access, block, and where node-analysis config actually lives** →
  [api/node-analysis.md](api/node-analysis.md)

Key facts:
- Route `entity.node.webform.results_analysis` → `/node/{node}/webform/results/analysis/{field_name}`;
  access = `_entity_access: node.view` + `WebformNodeAnalysisAccess::checkWebformNodeAnalysisAccess`
  (webform node results access + node must have `{field_name}`).
- Local task "Analysis @field" is **derived per node webform field** (`WebformNodeAnalysisLocalTask`),
  appearing under the node's Results tabs. `hook_entity_operation` adds a matching operation (gated on
  `view any webform submission`).
- Hooks in OOP class `Drupal\webform_node_analysis\Hook\WebformNodeAnalysisHooks`
  (`hook_entity_type_build`, `hook_entity_operation`) → `EntityTypeInfo`.
- Block plugin id: `webform_node_analysis_block` (`WebformNodeAnalysisBlock extends
  WebformAnalysisBlock`, target entity type `node`).
- The analysis settings (components, chart_type, start/end, in_draft) are still stored as
  **third-party settings on the referenced webform config entity** (`webform_analysis` namespace) —
  the parent module's storage — because the `WebformAnalysis` handler resolves the webform.
- Requires a **webform field on a node bundle** (from `webform_node`) for the tab to appear.
