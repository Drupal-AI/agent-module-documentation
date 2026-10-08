# Webform Workflows Element Views — agent index

Adds a Views **filter** to filter webform submissions by workflow state. Depends on the parent
`webform_workflows_element` and on `webform_views`. Provides config schema; no permissions, Drush, or
plugin types. Enable with `drush en webform_workflows_element_views -y`.

- **The filter plugin, its options, and the query it builds** → [plugins/filter.md](plugins/filter.md)

Key facts:
- `hook_views_data()` in `Hook/ViewsHooks` exposes the filter.
- Filter plugin id `webform_workflows_element_state`
  (`src/Plugin/views/filter/WebformWorkflowsElementState`, extends `FilterPluginBase`).
- Options: `webform_id` (entity autocomplete) + `workflow_element_id`; value = multi-select of that
  workflow's states.
- Query LEFT-joins `webform_submission_data` and filters `webform_id`, `name` (element id),
  `property = 'workflow_state'`, `value IN (states)` via Views' parameterised `addWhere` (state ids bound
  as placeholders — no raw SQL).
