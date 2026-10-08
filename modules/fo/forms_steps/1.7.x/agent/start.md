# Forms Steps — agent index

Configurable multi-step (wizard) forms built from entity **form modes**. A `forms_steps`
config entity lists ordered steps (each = entity_type + bundle + form_mode + url) and progress
steps; the module generates a front-end route per step keyed by a workflow **instance** UUID.
Depends on `field`, `field_ui`, `block`.

- **Build a workflow: the config entity, steps, progress bar, admin UI, redirection** →
  [configure/workflow.md](configure/workflow.md)
- **Services & the StepChangeEvent for code (instances, managers, block)** →
  [api/services.md](api/services.md)
- **`forms_steps:attach-entity` Drush command** → [drush/commands.md](drush/commands.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)
- **Templates / progress-bar theming** → [theming/theming.md](theming/theming.md)

Key facts:
- Admin UI: `entity.forms_steps.collection` → `/admin/config/workflow/forms_steps`
  (permission `administer forms_steps`). This is the `configure` route.
- Step config keys: `label, weight, entity_type, entity_bundle, form_mode, url, submitLabel,
  cancelLabel, cancelRoute, cancelStep, cancelStepMode, previousLabel, hideDelete,
  deleteLabel, displayPrevious` (schema `forms_steps.schema.yml`).
- Dynamic front-end routes: `forms_steps.route_subscriber:routes` builds
  `<step url>/{instance_id}` (instance_id = UUID regex), **permission `access content`**,
  controller `FormsStepsController::step` → renders the entity in the step's form mode.
- Instance tracking: `forms_steps.workflow.manager` (`WorkflowManager`); step transitions fire
  `\Drupal\forms_steps\Event\StepChangeEvent`.
- Progress bar: derivative Block `FormsStepsProgressBarBlock`.
- Drush: `forms_steps:attach-entity` (alias `fs-attach-entity`).
