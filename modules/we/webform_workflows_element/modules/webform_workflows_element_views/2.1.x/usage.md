Views integration for Webform Workflows Element: adds a Views filter that lets you filter webform submissions by their workflow state.

---

This submodule depends on the parent `webform_workflows_element` and on `webform_views` (the Webform → Views bridge). It implements `hook_views_data()` (via `Hook/ViewsHooks`) to expose a filter handler and registers a Views filter plugin `webform_workflows_element_state` (`WebformWorkflowsElementState extends FilterPluginBase`). In the filter's options form you pick a target **webform** (`webform_id`, entity autocomplete) and a **workflow element id** (`workflow_element_id`); the value form then offers a multi-select of that workflow's states (labels resolved through the parent's `webform_workflows_element.manager`). At query time it LEFT-joins `webform_submission_data` (aliased) and adds `WHERE` conditions on `webform_id`, `name` (the element id), `property = 'workflow_state'`, and `value IN (:states)` — all through Views' parameterised `addWhere`/join API, so selected state ids are bound as placeholders. It provides config schema for the filter's options and no permissions, Drush, or plugin types of its own. Use it to build review dashboards and exposed filters over submissions by workflow state.

---

- Add a "workflow state" filter to a webform-submissions View.
- Build a reviewer dashboard View listing submissions in a "needs review" state.
- Expose a state filter so users can narrow submissions by status in the UI.
- Filter to multiple states at once (multi-select) in a single View.
- Combine workflow-state filtering with other webform_views fields/filters.
- Show only "approved" submissions in a public listing View.
- Create separate View pages/blocks per workflow state (draft, submitted, done).
- Drive a moderation queue block from submissions at a given state.
- Report on submission counts per workflow state using a filtered View.
- Target a specific workflow element on a specific webform in the filter config.
- Provide an exposed filter for staff to switch between states on a results page.
- Feed a Views-based export of submissions in a chosen workflow state.
- Pair with the parent's summary pages for richer, custom state overviews.
- Filter submissions by state without writing a custom query.
- Add state-based visibility to an existing webform_views results View.
