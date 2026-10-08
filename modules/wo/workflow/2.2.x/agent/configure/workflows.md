<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Create a Workflow, its states, transitions, and attach it to content

![Workflows list](../../../../../../../screenshots/workflow/2.2.x/workflows.png)

## The three config entities

| Entity type | Config prefix | Holds |
|---|---|---|
| `workflow_type` | `workflow.workflow.<wid>` | the Workflow itself + `options` |
| `workflow_state` | `workflow.state.<sid>` | one state; `sid` is normally `<wid>_<name>`; an implicit `<wid>_creation` state always exists |
| `workflow_config_transition` | `workflow.transition.<tid>` | one allowed `from_sid → to_sid` edge + permitted `roles` |

`workflow_type` `config_export`: `id, label, module, status, options`.
`workflow_state`: `id, label, weight, module, wid, sysid, status, single_state_widget`.
`workflow_config_transition`: `id, label, module, from_sid, to_sid, roles`.

### Workflow `options` (schema `workflow.workflow.*.options`)

`name_as_title`, `fieldset`, `options` (how states are shown: e.g. `radios`/`select`/`buttons`),
`schedule_enable`, `schedule_timezone`, `always_update_entity`, `comment_log_node`,
`watchdog_log`.

## Admin UI (routes are in the main module)

- Workflows list / add: `/admin/config/workflow/workflow` (`entity.workflow_type.collection`),
  add at `/admin/config/workflow/workflow/add`.
- Edit a workflow's settings: `/admin/config/workflow/workflow/{workflow_type}`.
- **States:** `/admin/config/workflow/workflow/{workflow_type}/states`.
- **Transitions (per role):** `/admin/config/workflow/workflow/{workflow_type}/transition_roles`.
- **Transition labels:** `/admin/config/workflow/workflow/{workflow_type}/transition_labels`.

All require permission `administer workflow`.

## Attach the workflow to an entity (the field)

A workflow only does something once a **`workflow` field** (label "Workflow state") is added to a
bundle and bound to it:

- Field type `workflow`, default widget `workflow_default`, default formatter `list_default`
  (also `workflow_default`, `workflow_state_label`, `workflow_state_history`).
- **Storage setting `workflow_type` = the workflow id** — this is the binding. The allowed values
  are derived from the workflow's states (`allowed_values_function: workflow_state_allowed_values`),
  so you do **not** set an allowed-values list yourself.

Add it in the UI at *Manage fields → Add field → Workflow state*, or in code:

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;

FieldStorageConfig::create([
  'field_name' => 'field_workflow', 'entity_type' => 'node', 'type' => 'workflow',
  'settings' => ['workflow_type' => 'my_workflow'],   // bind to the workflow
])->save();
FieldConfig::create([
  'field_name' => 'field_workflow', 'entity_type' => 'node',
  'bundle' => 'article', 'label' => 'Editorial state',
])->save();
```

## Building a workflow programmatically (gotchas)

The entity API works but has two traps:

1. **Always set an integer `weight`** on every non-creation state before saving. A state saved
   with a NULL weight makes `WorkflowState::sort()` fatal on later loads (breaks the site). Use
   `createState($sid, FALSE)` (don't auto-save), set `label` and `weight`, then `save()`.
2. **State loads are statically cached per request.** `createTransition()` looks up its from/to
   states, so create the states and the transitions in **separate requests** (separate drush
   calls), or the transition save can't find the freshly-created states.

```php
// request 1: workflow + creation state
$wf = \Drupal\workflow\Entity\Workflow::create(['id' => 'my_wf', 'label' => 'My WF']);
$wf->save();
$wf->getCreationState()->save();                 // -> state my_wf_creation

// request 2: a state (note FALSE + weight)
$wf = \Drupal\workflow\Entity\Workflow::load('my_wf');
$s = $wf->createState('my_wf_draft', FALSE);
$s->set('label', 'Draft')->set('weight', 0)->save();

// request 3+: transitions (states must already exist in the DB)
$wf = \Drupal\workflow\Entity\Workflow::load('my_wf');
$wf->createTransition('my_wf_creation', 'my_wf_draft');
$wf->createTransition('my_wf_draft', 'my_wf_published');
```

The reliable, trap-free path is the **admin UI** (each state/transition is saved in its own
request and the form sets the weight).

## Read it back

```bash
drush cget workflow.workflow.my_wf
drush config:status | grep workflow          # see workflow.state.* / workflow.transition.*
```
