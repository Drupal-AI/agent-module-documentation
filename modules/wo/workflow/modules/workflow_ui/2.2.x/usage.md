<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Workflow UI is an **obsolete, hidden** submodule of Workflow. Its administrative interface for building workflows, states and transitions has been incorporated into the main `workflow` module, so it is now an empty placeholder that you do not need to enable.

---

Historically, Workflow UI provided the admin screens for creating and editing Workflows, their states, and their role-based transitions. As of the Workflow 2.2.x releases that UI lives directly in the main `workflow` module: the routes `entity.workflow_type.collection`, `entity.workflow_type.add_form/edit_form/delete_form`, `entity.workflow_state.collection`, `entity.workflow_transition.collection` and `entity.workflow_transition_label.collection` — plus the CRUD forms (`WorkflowConfigTransitionRoleForm`, `WorkflowConfigTransitionLabelForm`, and the `workflow_type`/`workflow_state`/`workflow_transition` entity forms) — are declared in the parent's `workflow.routing.yml`, and the menu/task/action links in `workflow.links.*.yml`. All are gated by the parent's `administer workflow` permission. The submodule now ships **only a `workflow_ui.info.yml`** (marked `hidden: TRUE`, depending on `workflow:workflow`, with `configure: entity.workflow_type.collection`): no routes, controllers, forms, config, schema, permissions, services, drush or plugins of its own. Enabling it does nothing useful; it is retained purely for upgrade compatibility with sites that once had it enabled. Manage workflows at `/admin/config/workflow/workflow` whether or not this module is enabled — see the parent module's [configure docs](../../../2.2.x/agent/configure/workflows.md).

---

- Recognize that the Workflow admin UI is built into the main `workflow` module, not this submodule.
- Leave Workflow UI disabled on new sites (nothing depends on it and it adds nothing).
- Understand why it shows as `hidden` on the Extend page.
- Safely uninstall it on upgraded sites where it was previously enabled.
- Point admins to `/admin/config/workflow/workflow` for the actual workflow management UI.
- Reach the workflow list via the route `entity.workflow_type.collection` from any custom link or menu.
- Add a new workflow through the parent's `entity.workflow_type.add_form` route (`/admin/config/workflow/workflow/add`).
- Edit a workflow's states at `.../{workflow_type}/states` (`entity.workflow_state.collection`).
- Configure which roles may run which transitions at `.../{workflow_type}/transition_roles`.
- Set per-transition labels at `.../{workflow_type}/transition_labels`.
- Grant the `administer workflow` permission to let a role reach these admin screens.
- Avoid confusion when a tutorial references "Workflow UI" — the functionality moved to the parent.
- Skip installing Workflow UI when scripting a Workflow setup; require only `drupal/workflow`.
- Explain to teammates that the submodule is a no-op residual, not a broken dependency.
- Remove Workflow UI from your `core.extension`/deploy config once confirmed it is only a placeholder.
- Treat any documentation that lists Workflow UI as a separate feature module as outdated.
