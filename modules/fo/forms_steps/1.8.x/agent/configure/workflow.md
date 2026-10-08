<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure a Forms Steps workflow

Install & enable: `drush en forms_steps -y` (pulls core `field`, `field_ui`, `block`). Admin UI lives
under **Configuration → Workflow → Forms Steps** at `/admin/config/workflow/forms_steps`
(`entity.forms_steps.collection`, the `configure` route); every admin route requires the
`administer forms_steps` permission except the per-workflow step/progress-step add/edit routes, which
use `_entity_access: forms_steps.edit` (still admin-only in practice).

![Forms Steps collection](../../../../../../../screenshots/forms_steps/1.8.x/collection.png)
![Add a Forms Steps](../../../../../../../screenshots/forms_steps/1.8.x/add-forms-steps.png)

## The two entities

- **`forms_steps`** — config entity, `src/Entity/FormsSteps.php`
  (`@ConfigEntityType id = "forms_steps"`, `config_prefix = "forms_steps"`, admin_permission
  `administer forms_steps`). Config objects are `forms_steps.forms_steps.<id>`. `config_export` keys:
  `id, label, description, progress_steps_links_saved_only, progress_steps_links_saved_only_next,
  redirection_policy, redirection_target, theme, steps, progress_steps`. It holds two ordered maps —
  `steps` and `progress_steps` — keyed by machine name; `status()` reports the workflow usable only if
  it has at least one step.
- **`forms_steps_workflow`** — content entity, `src/Entity/Workflow.php`
  (`@ContentEntityType id = "forms_steps_workflow"`, base_table `forms_steps_workflow`). One row per
  saved (instance, entity, step). Base fields: `id, instance_id, entity_type, bundle, entity_id,
  form_mode, forms_steps, step, user_id` (owner = current user via `preCreate()`), `langcode, created,
  changed`. Deleting the source entity cascades to its workflow rows (`hook_entity_predelete`).

## Steps (schema `config/schema/forms_steps.schema.yml`)

Each entry in `steps` maps a machine id to: `label`, `weight`, `entity_type`, `entity_bundle`,
`form_mode`, `url`, plus optional `theme`, `submitLabel`, `cancelLabel`, `cancelRoute`, `cancelStep`,
`cancelStepMode`, `previousLabel`, `hideDelete` (int), `deleteLabel`, `displayPrevious` (int). A step
therefore says "render this entity_type/bundle in this form_mode at this URL". Step ids must match
`[a-z0-9_]` (validated in `FormsSteps::addStep()`); the last step cannot be the only one deleted.
`Step` (`src/Step.php`) is the value object; `FormsSteps::getStep()` hydrates it and `getNextStep()`/
`getPreviousStep()` walk the ordered list by weight.

Manage steps per workflow: `.../{forms_steps}/add_step`, `.../{forms_steps}/step/{forms_steps_step}`
(edit), `.../{forms_steps}/step/{forms_steps_step}/delete`. Available `form_mode`s come from Field UI
(`admin/structure/display-modes/form`) for the chosen entity type; the module wires the form class for
each referenced form mode in `hook_entity_type_alter` (`forms_steps_entity_type_alter`), falling back
to the `register`/`default`/`add` operation class and warning if none exists (common for `user`).

## Progress steps

Each entry in `progress_steps` maps a machine id to `label`, `weight`, `routes` (step ids on which the
item is marked active), `link` (a step id to link to), and `link_visibility` (step ids where the link
shows). Managed at `.../{forms_steps}/add_progress_step`,
`.../{forms_steps}/progress_step/{forms_steps_progress_step}` (edit) and `.../delete`. Rendered by the
progress-bar block (see [../api/services.md](../api/services.md) and
[../theming/theming.md](../theming/theming.md)).

Collection toggles `progress_steps_links_saved_only` and `progress_steps_links_saved_only_next` control
whether a progress link appears only once its step has been persisted (and the following one).

## The wizard flow (how a submission moves between steps)

1. `RouteSubscriber::routes()` registers `forms_steps.<id>.<step_id>` at `<step url>/{instance_id}`,
   `_permission: access content`, instance_id constrained to a UUIDv4 regex, controller
   `FormsStepsController::step()`.
2. `FormsStepsController::getForm()` loads the `forms_steps`, resolves the `Step`, and — if an
   `instance_id` is supplied — loads matching `forms_steps_workflow` rows to find the existing entity to
   edit (loading its latest revision when revisionable); otherwise it creates a new entity of the step's
   bundle. It enforces entity `create`/`update` access, requires the first step for a brand-new
   submission, and honors `hideDelete`/`deleteLabel`. The entity is rendered in the step's form mode via
   `entityFormBuilder()->getForm($entity, $formMode, ['form_steps' => TRUE])`.
3. `forms_steps_form_alter()` detects the `form_steps` storage flag, appends
   `FormsStepsAlter::setNextRoute` to the submit handlers, and calls `FormsStepsAlter::handle()` to set
   button labels and add the optional Previous button.
4. On submit, `WorkflowManager::entityInsert()`/`entityPreSave()` (via `hook_entity_insert`/
   `hook_entity_presave`) create or reuse the workflow instance (a new UUID if none), then
   `FormsStepsAlter::setNextRoute()` redirects to the next step carrying `instance_id`, or applies the
   final-step redirection policy.

## Redirection policy (final step)

`redirection_policy` + `redirection_target` on the collection drive where the last step lands
(`FormsStepsAlter::setNextRoute()`): `internal` (validated path via `path.validator`), `route` (a named
route with current params), `external` (a `TrustedRedirectResponse`), or `entity` (the current entity's
`entity.node.canonical`). Empty policy = default form redirect.

## Themes

`theme` (collection) and per-step `theme` choose which theme renders a step: values from
`FormsStepsHelper::getThemes()` — `-1` same as collection, `0` default theme, `1` admin theme. The
route subscriber sets `_admin_route` accordingly.

## Settings form

`FormsStepsSettingsForm` (`src/Form/FormsStepsSettingsForm.php`) at
`/admin/config/workflow/forms_steps/settings` (`forms_steps.settings`, permission
`administer forms_steps`) is a `ConfigFormBase` writing the single `message` key into config object
`forms_steps.settings`. It is a lightweight/placeholder settings page — the substantive configuration is
the per-workflow steps described above.

## Config export example

```yaml
# forms_steps.forms_steps.example.yml
id: example
label: Example
description: ''
progress_steps_links_saved_only: false
progress_steps_links_saved_only_next: false
redirection_policy: entity
redirection_target: ''
theme: '0'
steps:
  step_1:
    label: 'Step 1'
    weight: 0
    entity_type: node
    entity_bundle: article
    form_mode: node.step_1
    url: /example/step-1
    displayPrevious: 0
  step_2:
    label: 'Step 2'
    weight: 1
    entity_type: node
    entity_bundle: article
    form_mode: node.step_2
    url: /example/step-2
    displayPrevious: 1
    previousLabel: Back
progress_steps: {  }
```
