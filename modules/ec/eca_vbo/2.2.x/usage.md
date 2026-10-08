ECA VBO lets you run an ECA (Event – Condition – Action) model as a Views Bulk Operations bulk action, so site builders can define no-code bulk operations over the entities selected in a View and control their access, form, confirmation and result output entirely from ECA.

---

The module bridges the [ECA](https://www.drupal.org/project/eca) rules engine and [Views Bulk Operations](https://www.drupal.org/project/views_bulk_operations). It defines an ECA event plugin `vbo` (derived into nine events by `VboEventDeriver`) whose central members are `vbo:execute` (fires once per selected entity) and `vbo:execute_multiple` (fires once for the whole selection); each event carries an **operation name** plus optional `view_id`/`display_id` restrictions, matched through an ECA wildcard `operation_name::view_id::display_id`. A VBO action plugin `eca_vbo_execute` is *derived per operation name* (`VboExecuteDeriver` scans enabled ECA configs for `vbo:execute`/`vbo:execute_multiple` events) so each ECA-defined operation shows up as a selectable bulk action in a View; when picked it dispatches the matching ECA event via `VboExecute::execute()`/`executeMultiple()`. Four helper ECA actions (type `system`, so they run inside ECA and not as VBO actions) support the model: `eca_vbo_set_result` (set the batch result message), `eca_vbo_get_config_value` (read a value from the action/form config into a token), `eca_vbo_get_views_argument` (read a Views contextual argument into a token) and `eca_vbo_set_custom_access` (grant/deny access, only meaningful on the `vbo:custom_access` event). Access can be computed dynamically: the `vbo:custom_access` event + `eca_vbo_set_custom_access` action decide whether a user may run an operation — **but this custom access is only enforced when the View uses the module's own "ECA bulk operations" field (`eca_vbo_bulk_form`, `EcaVboBulkForm`), not the stock "Views bulk operations" field.** Runtime data reaches ECA as tokens: `[event:view]`, `[event:action]`, and either `[event:entity]` (one-by-one) or `[event:queue]` (multiple). A confirm step (route `eca_vbo.confirm`, `EcaVboConfirm` form) runs unless the action is preconfigured to skip it. There is no admin settings page (`configure` is null) and no permissions of its own; you build everything in the ECA UI and the Views UI.

---

- Run a custom ECA model as a bulk action on the entities selected in any View.
- Bulk-publish or unpublish selected nodes with ECA logic you can extend without code.
- Bulk-apply a field value or state transition to each selected entity (one-by-one execution).
- Process the whole selection at once (multiple execution) — e.g. build a report or send a single summary email.
- Add conditional logic (ECA conditions) so the operation only touches entities that match criteria.
- Gate a bulk action behind custom access rules evaluated per user/selection via `vbo:custom_access`.
- Deny a bulk operation for users who lack a role/permission using `eca_vbo_set_custom_access` (access denied).
- Restrict an operation to a specific view and/or display with the event's `view_id`/`display_id` fields.
- Reuse one ECA operation across several Views by leaving `view_id`/`display_id` empty (matches all).
- Set the batch completion message shown to the user with `eca_vbo_set_result`.
- Read a value the user entered on the action form and use it in ECA via `eca_vbo_get_config_value`.
- Read a Views contextual filter argument into an ECA token with `eca_vbo_get_views_argument`.
- Skip the VBO confirmation screen for a smoother one-click bulk action (preconfiguration `skip_confirm`).
- Add extra fields to the action configuration form via `vbo:form_build` and validate them via `vbo:form_validate`.
- React to the confirmation form lifecycle (`vbo:confirm_form_build/validate/submit`) to customize it.
- Send notifications (email/Slack/etc. via other ECA actions) for each processed entity.
- Enrich or transform entities in bulk (set computed fields, tag, categorize) with ECA actions.
- Create related entities in bulk (e.g. spawn a task per selected node) from the execute event.
- Log or audit bulk operations by attaching ECA actions to the execute events.
- Expose the operation name as a nicely-labelled bulk action automatically (label derived from the operation name).
- Combine several ECA configs under the same operation name so multiple models react to one bulk action.
- Migrate legacy Rules-based bulk actions to ECA while keeping the VBO selection UX.
- Build multi-step bulk workflows (validate → confirm → execute → set result) without a custom module.
- Pass the executed action's plugin id/config into ECA via the `[event:action]` token for branching logic.
- Iterate queued entities and their ids/revisions via the `[event:queue]` token in multiple execution.
