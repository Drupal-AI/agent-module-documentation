<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Workflow UI — agent index (obsolete)

**Obsolete, hidden submodule of Workflow.** Its admin UI has been folded into the main `workflow`
module. The submodule now ships **only `workflow_ui.info.yml`** — no routes, forms, controllers,
permissions, config, schema, services, drush or plugins of its own. `hidden: TRUE`, so it does not
show on the Extend page by default. You do **not** need to enable it; enabling it is a no-op kept
only so sites that once had it enabled upgrade cleanly.

All the Workflow-maintenance routes and forms that "Workflow UI" once owned are now declared by the
parent in `workflow.routing.yml` (the parent's own `workflow.routing.yml` even opens with the
comment "All other routes for Workflow maintenance are declared in Workflow UI"). They are gated by
the parent's `administer workflow` permission:

- `entity.workflow_type.collection` → `/admin/config/workflow/workflow` (the module's `configure`
  route; lists `workflow_type` config entities)
- `entity.workflow_type.add_form` / `.edit_form` / `.delete_form` → workflow type CRUD forms
- `entity.workflow_state.collection` → `.../{workflow_type}/states`
- `entity.workflow_transition.collection` → `.../{workflow_type}/transition_roles`
  (form `Drupal\workflow\Form\WorkflowConfigTransitionRoleForm`)
- `entity.workflow_transition_label.collection` → `.../{workflow_type}/transition_labels`
  (form `Drupal\workflow\Form\WorkflowConfigTransitionLabelForm`)

Where to actually do the work (parent module docs):

- **Create/edit workflows, states, transitions, options; attach to content** →
  [configure/workflows.md](../../../../2.2.x/agent/configure/workflows.md)
- **The `administer workflow` permission and the per-workflow transition permissions** →
  [permissions/permissions.md](../../../../2.2.x/agent/permissions/permissions.md)

Key facts: `hidden: TRUE`; depends on `workflow:workflow`; `configure: entity.workflow_type.collection`;
`core_version_requirement: ^8 || ^9 || ^10 || ^11`. No permissions, no drush, no plugin types, no
config schema. Manage workflows at `/admin/config/workflow/workflow` whether or not this module is
enabled.
