# Configure a Forms Steps workflow

## Admin UI
`entity.forms_steps.collection` → `/admin/config/workflow/forms_steps` (permission
`administer forms_steps`). From there:
- **Add a Forms Steps** — creates a `forms_steps` config entity (id + label + description).
- **Add step** / **Edit step** — one step per page of the wizard.
- **Add progress step** / **Edit progress step** — items shown in the progress bar.
- **Settings** (`forms_steps.settings`) — module-wide settings form.
- **Workflow instance list** (`entity.forms_steps_workflow.collection`) — lists in-progress
  instances (permission `view forms_steps_workflow entity`).

## The `forms_steps` config entity
Config prefix `forms_steps.forms_steps.*`. `config_export`:
`id, label, description, progress_steps_links_saved_only,
progress_steps_links_saved_only_next, redirection_policy, redirection_target, steps,
progress_steps`.

### Workflow-level options
| Key | Meaning |
|---|---|
| `progress_steps_links_saved_only` | Only link a progress step once that step has been saved to the DB. |
| `progress_steps_links_saved_only_next` | Also link the step immediately after the last saved one. |
| `redirection_policy` / `redirection_target` | Where to send the user when the workflow ends. |

### Each step (`steps[]`)
`label`, `weight` (order), `entity_type`, `entity_bundle`, `form_mode` (which entity **form
mode** renders on this step), `url` (front-end path fragment), `submitLabel`, `cancelLabel`,
`cancelRoute`, `cancelStep` + `cancelStepMode` (cancel back to a specific step), `previousLabel`,
`displayPrevious`, `hideDelete`, `deleteLabel`.

> Steps map to real entity **form modes** — create/manage them in Field UI
> (Manage form modes) first, then reference them here. Any field on the entity can be placed
> per step by configuring that form mode.

### Progress steps (`progress_steps[]`)
The labelled items rendered in the progress bar (order + link visibility governed by the
workflow-level `progress_steps_links_*` flags).

## Front-end routing (generated)
`forms_steps.route_subscriber:routes` creates one route per step:
`<step.url>/{instance_id}` where `instance_id` must match a UUID. Requirement is core
`access content`, so a public flow is reachable by anyone who can view content. When
`node.settings.use_admin_theme` is on, steps render in the admin theme.

`FormsStepsController::step()` loads the entity tied to that `instance_id` (or creates one)
and renders it in the step's form mode; `FormsStepsAlter` adds the wizard navigation
(previous/next/cancel/delete) and advances the shared instance.

## Progress bar block
Enable and place the derivative **Forms Steps progress bar** block
(`FormsStepsProgressBarBlock`) in a region to show progress; it derives one block per workflow.
