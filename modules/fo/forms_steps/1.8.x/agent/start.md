<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Forms Steps (forms_steps) — agent index

Configurable multi-step (wizard) forms built from entity **form modes**. A `forms_steps`
config entity lists ordered steps (each = entity_type + bundle + form_mode + url) and progress
steps; the module generates a front-end route per step keyed by a workflow **instance** UUID and
renders the target entity in the step's form mode. Version 1.8.x (8.x-1.8), `core_version_requirement:
^8 || ^9 || ^10 || ^11`, package `Forms`, license GPL-2.0-or-later. Depends on core `field`,
`field_ui`, `block`; no external libraries.

- **Build a workflow: the config entities, steps/progress steps, the wizard flow, admin routes, redirection, settings** →
  [configure/workflow.md](configure/workflow.md)
- **Services, the WorkflowManager/instance model, the block, and StepChangeEvent for code** →
  [api/services.md](api/services.md)
- **`forms_steps:attach-entity` Drush command** → [drush/commands.md](drush/commands.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)
- **Templates / progress-bar theming** → [theming/theming.md](theming/theming.md)

Key facts:
- Two entities: config entity `forms_steps` (id key `forms_steps`, `src/Entity/FormsSteps.php`) and
  content entity `forms_steps_workflow` (`src/Entity/Workflow.php`, base_table `forms_steps_workflow`)
  that records one row per (instance_id, entity, step) pairing.
- Admin UI: `entity.forms_steps.collection` → `/admin/config/workflow/forms_steps` (permission
  `administer forms_steps`). This is the `configure` route. Add/edit/delete forms plus per-workflow
  add/edit/delete of steps and progress steps (`forms_steps.routing.yml`).
- Step config keys (schema `config/schema/forms_steps.schema.yml`): `label, weight, entity_type,
  entity_bundle, form_mode, url, theme, submitLabel, cancelLabel, cancelRoute, cancelStep,
  cancelStepMode, previousLabel, hideDelete, deleteLabel, displayPrevious`. Collection-level keys:
  `description, progress_steps_links_saved_only, progress_steps_links_saved_only_next,
  redirection_policy, redirection_target, theme, steps, progress_steps`.
- Dynamic front-end routes: `forms_steps.route_subscriber:routes` (`RouteSubscriber::routes()`) builds
  `<step url>/{instance_id}` (instance_id = UUID regex), **permission `access content`**, controller
  `FormsStepsController::step()` → renders the entity in the step's form mode.
- Wizard glue: `hook_form_alter` (`forms_steps.module`) appends `FormsStepsAlter::setNextRoute` and
  calls `FormsStepsAlter::handle()`; navigation/redirection live in `src/Form/FormsStepsAlter.php`.
- Instance tracking: `forms_steps.workflow.manager` (`WorkflowManager`) creates/loads workflow rows on
  `hook_entity_insert`/`hook_entity_presave`; `forms_steps.manager` (`FormsStepsManager`) resolves
  next/previous steps and routes; `forms_steps.helper` (`FormsStepsHelper`) reads the instance id from
  the route; `forms_steps.workflow.repository` (`WorkflowRepository`) queries saved steps.
- Progress bar: derivative Block `FormsStepsProgressBarBlock` (id `forms_steps_progress_bar`), one
  derivative per `forms_steps` config entity.
- Events: `\Drupal\forms_steps\Event\StepChangeEvent` (`forms_steps.step_change_event`) fires before
  moving to the next/previous step.
- Drush: `forms_steps:attach-entity` (alias `fs-attach-entity`), `src/Commands/FormsStepsCommands.php`.
- Settings form `FormsStepsSettingsForm` at `/admin/config/workflow/forms_steps/settings` writes
  config object `forms_steps.settings`.
