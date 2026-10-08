<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks Workflow invites (`workflow.api.php`)

Implement these in `mymodule.module` (or a `mymodule.workflow.inc`). For most reactions prefer
the Symfony events (`WorkflowEvents::PRE/POST_TRANSITION`, see
[../api/transitions.md](../api/transitions.md)); the hooks below cover things events don't.

| Hook | When / purpose | Veto? |
|---|---|---|
| `hook_workflow($op, WorkflowTransitionInterface $transition, UserInterface $user)` | Called with `$op` `'transition pre'`, `'transition post'`, `'transition revert'`. Do work before/after a change. | Return **FALSE** on `'transition pre'` / `'transition revert'` to veto the transition. |
| `hook_workflow_permitted_state_transitions_alter(array &$transitions, array $context)` | Add/remove/relabel the target states a user may pick (invoked in `WorkflowState::getOptions()`). `$context` has `user`, `workflow`, `state`, `force`. | — (mutate `$transitions`) |
| `hook_workflow_comment_alter(&$comment, array &$context)` | Change the transition comment/log message before it is saved. `$context['transition']` is the transition. | — |
| `hook_workflow_operations($op, ?EntityInterface $entity)` | Add operation links to the Workflow/State/Transition list builders. `$op` = `top_actions`/`operations`/`workflow`/`state`. | — |
| `hook_workflow_history_alter(array &$variables)` | Add operations to a history row (e.g. an "undo"/revert link). | — |
| `hook_workflow_copy_form_values_to_transition_field_alter(EntityInterface $entity, $context)` | Copy extra submitted form values onto the transition entity. | — |

## Core Form-API hooks the module fires by name

- `hook_field_widget_single_element_workflow_default_form_alter(&$element, $form_state, $context)`
  — alter the `workflow_default` widget.
- `hook_form_workflow_transition_form_alter(&$form, $form_state, $form_id)` — alter the standalone
  transition form.

## Deletion hooks

Instead of the removed D7 `state delete` / `workflow delete` ops, react with core
`hook_entity_predelete()` / `hook_entity_delete()` (checking the entity type), documented in
`workflow.api.php` alongside `hook_workflow_type_delete()`,
`hook_workflow_config_transition_delete()`, `hook_workflow_state_delete()` examples.

`workflow_hook_info()` registers `hook_workflow*` as group `workflow`, so implementations may live
in a `mymodule.workflow.inc` file.

The **Workflow Devel** submodule implements every one of these hooks and prints a message on each
call — enable it to see exactly which hooks fire and in what order
(see `modules/workflow/modules/workflow_devel/2.2.x/`).
