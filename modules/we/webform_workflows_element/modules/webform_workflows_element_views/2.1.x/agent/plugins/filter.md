# Views filter `webform_workflows_element_state`

`src/Plugin/views/filter/WebformWorkflowsElementState` (`@ViewsFilter`, extends `FilterPluginBase`).
Exposed via `hook_views_data()` (`Hook/ViewsHooks::viewsData`).

## Options form (`buildOptionsForm`)

- `webform_id` — `entity_autocomplete` to `webform` (the target form).
- `workflow_element_id` — the machine name of the workflow element on that webform.

## Value form (`valueForm`)

Loads the webform, reads the element's `#workflow`, loads the workflow, and offers a `#multiple`
`select` of state id → state label. (Skipped when exposed or when webform/element not chosen.)

## Query (`query`)

```php
$stateIds = array_filter((array) $this->value);
if (empty($stateIds)) return;                // no filtering when nothing selected
// LEFT join webform_submission_data (sid = sid), alias wsd_state_<filterId>
$this->query->addWhere('state', "$alias.webform_id", $this->options['webform_id']);
$this->query->addWhere('state', "$alias.name", $this->options['workflow_element_id']);
$this->query->addWhere('state', "$alias.property", 'workflow_state');
$this->query->addWhere('state', "$alias.value", $stateIds, 'IN');
```
All values go through Views' `addWhere`/join API, i.e. bound as placeholders — no string-concatenated
SQL. `adminSummary()` shows `webform: <label>, workflow element: <id>`.

## Notes

- Requires `webform_views` so submissions are queryable in Views in the first place.
- Add the filter to a webform-submissions View, set `webform_id` + `workflow_element_id`, then filter
  (or expose) by one or more states.
