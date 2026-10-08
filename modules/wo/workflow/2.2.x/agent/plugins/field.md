<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field, widgets, formatters, Actions, Block & Views

Workflow does **not** define a plugin *type* of its own; it provides plugins for core's field,
action, block and views subsystems.

## Field type

- **`workflow`** (`WorkflowItem`, extends `ListStringItem`), label "Workflow state".
  - `default_widget = workflow_default`, `default_formatter = list_default`,
    `list_class = WorkflowItemList`.
  - Storage setting **`workflow_type`** binds the field to a Workflow (required).
  - Allowed values come from `workflow_state_allowed_values` (the workflow's states) — you don't
    set an allowed-values list.

## Widgets (`field_types = {"workflow"}`)

| id | Class | Use |
|---|---|---|
| `workflow_default` | `WorkflowDefaultWidget` | the standard state-change widget (radios/select/buttons + optional comment & schedule) |
| `workflow_datetime_timestamp_timezone` | `WorkflowDateTimeZoneWidget` | timestamp widget with timezone (for scheduling) |

## Formatters

| id | Class | Shows |
|---|---|---|
| `workflow_default` | `WorkflowDefaultFormatter` | the state + the transition form |
| `workflow_state_label` | `WorkflowStateLabel` | just the current state's label |
| `workflow_state_history` | `WorkflowStateHistoryFormatter` | the full transition history |

## Actions (`#[Action]` / `@Action`)

| id | Class | Effect |
|---|---|---|
| `workflow_node_next_state_action` | `WorkflowNodeNextStateAction` | move the entity to the **next** state in the workflow |
| `workflow_node_given_state_action` | `WorkflowNodeGivenStateAction` | move the entity to a **configured** `to_sid` |

Action config (schema): `field_name`, `to_sid`, `comment`, `force`. Usable from Views Bulk
Operations or `system.action.*` config.

## Block

- `workflow_transition_form` (`WorkflowTransitionBlock`) — renders the state + transition form
  for the current entity in a block/region instead of the entity view.

## Views plugins

- Field / filter / argument on workflow state:
  `Drupal\workflow\Plugin\views\{field,filter,argument}\WorkflowState`.
- Views data for the executed and scheduled transition entities
  (`WorkflowTransitionViewsData`, `WorkflowScheduledTransitionViewsData`).

## Validation

- `WorkflowFieldConstraint` / `WorkflowFieldConstraintValidator` validate that a submitted value
  is a permitted transition target.

## Migrate (Drupal 7 → current)

Source/field plugins under `src/Plugin/migrate/*` migrate D7 Workflow (`d7_workflow*`) config,
states, transitions and scheduled transitions.
