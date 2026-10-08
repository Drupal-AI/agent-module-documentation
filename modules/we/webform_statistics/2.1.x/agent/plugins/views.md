<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views plugins

The module does not define a plugin *type*; it provides Views field + style plugins usable in any
View on the `webform_submission` base table (or, for the style, any View).

## Field plugins (registered via `hook_views_data_alter` on `webform_submission`)

| Views data id | Plugin class | What it gives |
|---|---|---|
| `created_groupable` | `Plugin/views/field/WebformSubmissionCreatedGroupable` | `created` timestamp normalised to a day so results can be **grouped by day**. |
| `latest_submission_date` (`webform_latest_submission_date`) | `Plugin/views/field/WebformLatestSubmissionDate` | Date of the latest submission for the row's webform. |
| `webform_submission_label` | `Plugin/views/field/WebformSubmissionLabel` | Webform title with an optional language suffix. |
| `webform_submission_language` | `Plugin/views/field/WebformSubmissionLanguage` | Human-readable language name of the submission. |

Add them in the Views UI as fields on a webform-submission View, or reference the ids above in a
View's YAML.

## Style plugin — `webform_statistics_d3_chart` (`Plugin/views/style/D3Chart`)

A `@ViewsStyle` that renders rows as a D3 chart (theme hook `webform_statistics_d3_chart`,
template `webform-statistics-d3-chart.html.twig`). `usesFields = TRUE`, `usesGrouping = TRUE`.

Options (`buildOptionsForm`): `chart_type` (`bar` | `spline` | `line` | `area`), `label_field`
(X-axis), `data_field` (values), `group_field`, `x_axis_label_rotation` (default 60),
`legend_position` (default `right`), `show_data_labels`. Pick it as the display's Format = "D3 Chart"
and map the label/data fields. Requires the `webform_statistics/charts` library, which pulls
`webform_statistics/d3` (D3 v7 from the jsDelivr CDN).
