<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Analysis adds a per-webform "Analysis" results tab that turns submission data for selected elements into counts, tables and Google charts (pie / column), plus a block for embedding those stats anywhere.

---

The module extends the Webform entity with an **Analysis** entity form/local task at `/admin/structure/webform/manage/{webform}/results/analysis` (route `entity.webform.results_analysis`, gated by webform's own `view any webform submission` / results access). Its configuration is stored as **third-party settings on the webform config entity** under the `webform_analysis` namespace: `components` (the element keys to analyse), `chart_type` (`''` = table, `PieChart`, or `ColumnChart`), `start_date`, `end_date` (timestamps bounding submissions) and `in_draft` (include draft submissions). The `WebformAnalysis` handler class (`new WebformAnalysis($webform)`) reads these settings and queries the `webform_submission_data` table to produce value counts per component (`getComponentValuesCount()`), rows with human labels (`getComponentRows()` — mapping checkbox Yes/No, entity/term references, and option labels), and titles. `getChartTypeOptions()` returns the three chart choices. Results render via the `webform_analysis_component` theme hook and a Google Charts library (`webform_charts`, loaded from gstatic). A `webform_analysis_block` Block plugin lets you place a component's chart/table on any page. It integrates entirely through `hook_entity_type_build`/`hook_entity_operation` (adding the analysis form + "Analysis" operation) — there is no global settings page, no permission of its own, and no Drush. The `webform_node_analysis` submodule extends the same analysis to webforms attached to nodes via a webform field.

---

- See a pie chart of how many people chose each option of a webform "How did you hear about us?" select.
- Show a column chart of ratings submitted through a satisfaction survey.
- Display a plain table of value counts for a webform element when charts aren't wanted.
- Analyse only specific elements of a long webform by choosing them as analysis components.
- Count Yes/No responses for a checkbox element (rendered as Yes/No labels).
- Summarise an entity-reference or taxonomy-term webform element by the referenced labels.
- Bound the analysis to a date range (start/end) to report on a single campaign period.
- Include or exclude draft submissions from the statistics with the in_draft toggle.
- Embed a specific component's chart on a dashboard using the webform_analysis block.
- Give stakeholders a read-only "Analysis" tab alongside a webform's results.
- Compare option popularity across all submissions of a registration form.
- Produce quick quantitative summaries for a feedback form without exporting to a spreadsheet.
- Track responses to a poll-style webform element over time.
- Configure which components and chart type to show as exportable webform config (third-party settings).
- Present survey results visually to non-technical staff via Google charts.
- Analyse multiple components of one webform, each with its own chart/table.
- Reuse the WebformAnalysis handler in custom code to compute component value counts.
- Show the count next to each value label (value_label_with_count) in a rendered analysis.
- Provide per-node webform statistics using the webform_node_analysis submodule.
- Switch a component's display between table, pie chart and column chart by changing chart_type.
- Build an at-a-glance results overview for editors right after collecting submissions.
- Report on a "region" or "department" select element to see submission distribution.
- Feed the computed rows into a custom render array or export.
- Limit analysis to finalized (non-draft) submissions for accurate reporting.
