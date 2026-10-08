<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Workflow Devel is a developer aid for building Workflow add-ons: it implements every hook the Workflow module defines (and the relevant core hooks/events) and shows a status message each time one fires, so you can see exactly which hooks run, in what order, during a state transition.

---

A tiny, no-config submodule (do **not** enable on production). It registers the
`WorkflowDevelHooks` service (`#[Hook]`-based, with `#[LegacyHook]` wrappers in
`workflow_devel.module`) implementing `hook_workflow()`, `hook_workflow_comment_alter()`,
`hook_workflow_history_alter()`, `hook_workflow_operations()`,
`hook_workflow_permitted_state_transitions_alter()`,
`hook_workflow_copy_form_values_to_transition_field_alter()`, the
`field_widget_single_element_workflow_default_form_alter` / `form_alter` /
`form_workflow_transition_form_alter` form hooks, `entity_operation(_alter)`, and the entity CRUD
hooks (`entity_create`/`insert`/`presave`/`update`/`predelete`/`delete`). It also registers an
event subscriber (`WorkflowDevelEventSubscriber`) on `WorkflowEvents::PRE_TRANSITION` and
`POST_TRANSITION`. Each implementation is a worked example you can copy, and (per the module's
purpose) surfaces a user message on invocation so you can trace the transition lifecycle. It ships
no routes, permissions, config or schema — enable it, perform a transition, read the messages,
then disable it.

---

- See which Workflow hooks fire, and in what order, when content changes state.
- Learn the correct signature of each `hook_workflow*` by reading a working implementation.
- Copy `WorkflowDevelHooks` methods as a starting point for your own Workflow add-on.
- Debug why a custom transition reaction isn't firing by confirming the hook is reached.
- Observe the difference between `WorkflowEvents::PRE_TRANSITION` and `POST_TRANSITION` timing.
- Verify that `hook_workflow_permitted_state_transitions_alter()` is invoked when the widget builds.
- Trace `hook_workflow_comment_alter()` to see when the transition comment can be changed.
- Confirm entity CRUD hooks fire around a workflow transition save.
- Inspect the `$op` values passed to `hook_workflow()` (`transition pre`/`post`/`revert`).
- Understand how `hook_workflow_operations()` adds list-builder operations.
- Prototype a new Workflow integration against a live example before writing your module.
- Teach developers the Workflow hook lifecycle interactively on a dev site.
- Validate hook ordering after upgrading Workflow.
- Check that the `workflow_default` widget alter hook receives the expected `$context`.
- Diagnose form-alter conflicts on the transition form.
- Confirm your module's event subscriber priority relative to Workflow Devel's.
- Use as a reference for the `#[Hook]` attribute + `#[LegacyHook]` pattern the module uses.
- Enable temporarily on a staging site to reproduce a hook-timing bug, then uninstall.
