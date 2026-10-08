<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Node Analysis extends Webform Analysis to webforms embedded in nodes via a webform field, adding a per-node "Analysis" tab (and block) that charts submissions for that node's webform field.

---

This submodule bridges `webform_node` (which lets a node reference a webform through a webform field) and `webform_analysis`. On `hook_entity_type_build` it registers a `webform_analysis` **form handler** and a `webform.results_analysis` **link template** on the node entity type (`/node/{node}/webform/results/analysis/{field_name}`), and defines the route `entity.node.webform.results_analysis` guarded by `WebformNodeAnalysisAccess::checkWebformNodeAnalysisAccess` (reusing webform's node results access plus a check that the node actually has the given field). A local-task **deriver** (`WebformNodeAnalysisLocalTask`) adds one "Analysis @field" tab under the node's Results local tasks for **each** node webform field found in `field_config`, and `hook_entity_operation` adds a matching operation. A `webform_node_analysis_block` Block plugin embeds the per-node analysis. Crucially, the analysis configuration itself (which components, chart type, dates, draft flag) is still stored as **third-party settings on the referenced webform config entity** under the `webform_analysis` namespace — the same storage the parent module uses — because the `WebformAnalysis` handler operates on the resolved webform. The submodule has no config, no settings form, no permission of its own, and no Drush; it is pure routing/UI glue that reuses the parent's analysis engine per node.

---

- Add an "Analysis" tab to a node that embeds a survey webform, at `/node/{nid}/webform/results/analysis/{field}`.
- Chart the submissions collected through a specific node's webform field.
- Show per-node statistics when the same webform is embedded on several nodes via a field.
- Provide editors a node-level results overview without visiting the global webform results.
- Expose one Analysis tab per webform field on a node that has multiple webform fields.
- Embed a node's webform analysis on another page using the webform_node_analysis block.
- Restrict access to node webform analysis using the node's webform results access rules.
- Reuse the parent's chart types (Table / Pie / Column) for node-embedded webforms.
- Analyse only selected elements of a node-embedded webform.
- Give a landing-page node its own submission dashboard tab.
- Compare responses gathered per node when a webform is reused across campaigns.
- Present node webform results visually to non-technical stakeholders.
- Keep node webform analysis config in the referenced webform's third-party settings (exportable).
- Add analysis to an event node's RSVP webform field.
- Chart a feedback webform embedded in a product/page node.
- Let content teams see submission counts directly from the node they manage.
- Support multiple webform fields on one content type, each with its own analysis tab.
- Bound node webform analysis to a date range via the referenced webform's start/end settings.
- Include or exclude draft submissions in node-level analysis via the in_draft setting.
- Provide a per-node column chart of a rating element embedded in the node.
- Surface node webform statistics through the standard node local-tasks (tabs) UI.
- Reuse the WebformAnalysis handler against a node's webform field programmatically.
