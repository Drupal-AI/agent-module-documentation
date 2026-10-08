<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Workflow provides a configurable state machine you attach to any entity as a field: you define a Workflow with its own states and role-restricted transitions, add a "Workflow state" field to a bundle, and content then moves between states (with a full, revisionable transition history) via a widget or block.

---

A **Workflow** is the `workflow_type` config entity (managed at `/admin/config/workflow/workflow`); each has **states** (`workflow_state` config entities, always including an implicit `(creation)` state) and **config transitions** (`workflow_config_transition` config entities) that declare which state can move to which, restricted per user **role**. You put a workflow on content by adding a field of type **`workflow`** (label "Workflow state", widget `workflow_default`, formatters `workflow_default` / `workflow_state_label` / `workflow_state_history`) whose storage setting `workflow_type` binds it to one Workflow; the field's allowed values come from the workflow's states via `workflow_state_allowed_values`. When a user changes the state, an **executed transition** (`workflow_transition` content entity, stored in the `workflow_transition_history` table) is recorded with the author, timestamp and an optional comment, and transitions can be **scheduled** for a future time (`workflow_scheduled_transition`, run on cron). Every workflow generates a set of **dynamic permissions** (`create <wid> workflow_transition` = "participate", plus schedule/edit/revert/bypass and history-access perms). Business logic hooks in around each change: `hook_workflow('transition pre'/'transition post', ...)`, `hook_workflow_permitted_state_transitions_alter()`, `hook_workflow_comment_alter()`, and Symfony events `WorkflowEvents::PRE_TRANSITION` / `POST_TRANSITION`. It also ships Actions (`workflow_node_next_state_action`, `workflow_node_given_state_action`), a transition Block, and Views integration. Six submodules extend it: `workflow_access` (node access by state), `workflow_cleanup`, `workflow_devel`, and the obsolete/residual `workflowfield`, `workflow_operations`, `workflow_ui` (now folded into the main module).

---

- Build an editorial workflow (Draft → Needs Review → Published) on the Article content type.
- Restrict who can publish by granting the "participate" transition permission only to an Editor role.
- Attach a workflow to a custom entity or any bundle by adding a Workflow state field.
- Record a full, timestamped history of every state change with the author and a comment.
- Require a comment/log message when moving content between certain states.
- Schedule a transition to run automatically in the future (e.g. auto-publish at a date/time) via cron.
- Add an approval process where content returns to Draft if a reviewer rejects it.
- Show the current state and a "change state" form in a block on the entity page (transition Block).
- Let different roles see different available next states from the same current state.
- Drive access control: hide unpublished/draft nodes from anonymous users with the Workflow Access submodule.
- Fire custom code on a transition using `hook_workflow('transition post', ...)` or `WorkflowEvents::POST_TRANSITION`.
- Alter the list of allowed target states dynamically with `hook_workflow_permitted_state_transitions_alter()`.
- Move an entity to its next state in bulk with the `workflow_node_next_state_action` Action (e.g. from a View).
- Force an entity to a specific state with the `workflow_node_given_state_action` Action.
- Model a support-ticket lifecycle (New → Open → Pending → Closed) with role-based transitions.
- Model an e-commerce/RMA or publishing pipeline with custom states and labels.
- Display just the current state label with the `workflow_state_label` formatter, or the full history with `workflow_state_history`.
- Filter or group a View by workflow state using the Views field/filter/argument plugins.
- Bypass restrictions for a superuser role with the `bypass <wid> workflow_transition access` permission.
- Allow users to revert their last transition with the revert permission and revert form.
- Change the transition comment programmatically before it is saved via `hook_workflow_comment_alter()`.
- Import workflow state values from a feed with the Feeds target (with the Feeds module).
- Show workflow state changes inside revision diffs (with the Diff module).
- Clean up orphaned/inactive states left after editing a workflow using the Workflow Cleanup submodule.
- Debug add-on development by logging every workflow hook call with the Workflow Devel submodule.
- Programmatically execute a transition from custom code with `workflow_execute_transition()` / `WorkflowTransition::execute()`.
- Keep one workflow but reuse it across multiple bundles/fields with per-field configuration.
