<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# What Workflow Devel implements (hook/event reference)

All implementations live in the service `Drupal\workflow_devel\Hook\WorkflowDevelHooks`
(`#[Hook('...')]` methods), with `#[LegacyHook]` procedural wrappers in
`workflow_devel.module`, plus `WorkflowDevelEventSubscriber`. Each is a copyable example that
also emits a message when it runs.

## Workflow-specific hooks (defined in `workflow.api.php`)

| Hook | Devel method |
|---|---|
| `hook_workflow($op, $transition, $user)` | `workflowDevelWorkflow()` |
| `hook_workflow_comment_alter(&$comment, &$context)` | `workflowCommentAlter()` |
| `hook_workflow_history_alter(&$context)` | `workflowHistoryAlter()` |
| `hook_workflow_operations($op, $entity)` | `workflowOperations()` |
| `hook_workflow_permitted_state_transitions_alter(&$transitions, $context)` | `workflowPermittedStateTransitionsAlter()` |
| `hook_workflow_copy_form_values_to_transition_field_alter($entity, $context)` | `workflowCopyFormValuesToTransitionFieldAlter()` |

## Core Form-API hooks

| Hook | Devel method |
|---|---|
| `hook_field_widget_single_element_workflow_default_form_alter(&$element, &$form_state, $context)` | `fieldWidgetSingleElementWorkflowDefaultFormAlter()` |
| `hook_form_alter(&$form, $form_state, $form_id)` | `formAlter()` |
| `hook_form_workflow_transition_form_alter(&$form, $form_state, $form_id)` | `formWorkflowTransitionFormAlter()` |

## Core entity hooks

| Hook | Devel method |
|---|---|
| `hook_entity_operation` / `_alter` | `entityOperation()` / `entityOperationAlter()` |
| `hook_entity_create` | `entityCreate()` |
| `hook_entity_insert` | `entityInsert()` |
| `hook_entity_presave` | `entityPreSave()` |
| `hook_entity_update` | `entityUpdate()` |
| `hook_entity_predelete` | `entityPredelete()` |
| `hook_entity_delete` | `entityDelete()` |

## Events

`WorkflowDevelEventSubscriber::getSubscribedEvents()` subscribes:

- `WorkflowEvents::PRE_TRANSITION` → `preUpdateProcess(WorkflowTransitionEvent $event)`
- `WorkflowEvents::POST_TRANSITION` → `postUpdateProcess(WorkflowTransitionEvent $event)`

## Using it

1. Enable `workflow_devel` on a **dev** site.
2. Perform a state transition on a workflow-enabled entity.
3. Read the emitted messages to see the firing order.
4. Copy the relevant method into your own module and disable `workflow_devel`.

For authoring your own reactions, prefer the events; full hook semantics are in the parent's
[hooks/hooks.md](../../../../../2.2.x/agent/hooks/hooks.md).
