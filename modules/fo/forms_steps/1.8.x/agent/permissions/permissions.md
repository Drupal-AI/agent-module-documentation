<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Declared in `forms_steps.permissions.yml`:

- **`administer forms_steps`** — "Administer Forms Steps". Gates the whole admin UI: the collection
  (`entity.forms_steps.collection` = `/admin/config/workflow/forms_steps`, the `configure` route),
  add/edit/delete of a `forms_steps` config entity, the step and progress-step delete forms, and the
  settings form (`forms_steps.settings`). It is also the config entity's `admin_permission`. The
  per-workflow step/progress-step **add/edit** routes instead require `_entity_access: forms_steps.edit`
  (which, for this config entity, resolves through the same admin permission).

Other access gates (not module-defined permissions, noted for completeness):

- **`access content`** (core) — guards every generated front-end step route
  (`RouteSubscriber::routes()`) and the progress-bar block (`FormsStepsProgressBarBlock::blockAccess()`).
  So the wizard itself is reachable by any role holding `access content` (often anonymous). Actual
  create/edit of the step's entity is still gated by that entity's own `create`/`update` access checks
  inside `FormsStepsController::getForm()`, with a registration-access special case for the `user`
  entity type via `access_check.user.register`.
- **`view forms_steps_workflow entity`** — required by the workflow-instance list route
  (`entity.forms_steps_workflow.collection` = `/admin/config/workflow/forms_steps/workflows/list`).
- The `forms_steps_workflow` content entity declares `admin_permission = "administer contact entity"`
  (a core permission, reused here).
