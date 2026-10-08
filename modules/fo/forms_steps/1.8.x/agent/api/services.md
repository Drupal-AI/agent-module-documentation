<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services, the instance model, the block, and events

Services declared in `forms_steps.services.yml`.

## `forms_steps.manager` — `FormsStepsManager` (`src/Service/FormsStepsManager.php`)

Resolves steps/routes from the current route name (pattern
`/^forms_steps\.([a-zA-Z0-9_]+)\.([a-zA-Z0-9_]+)/`, group 1 = forms_steps id, group 2 = step id).
Key methods: `getRouteParameters()`, `getFormsStepsByRoute()`, `getStepByRoute()`,
`getNextStep()/getNextStepRoute()`, `getPreviousStep()/getPreviousStepRoute()`,
`getFormsStepsById()`. Also `getAllFormStepsEntityTypes()` (scans `forms_steps.forms_steps.*` config)
and `getAllFormModesDefinitions()` (form modes per referenced entity type) — the latter is consumed by
`forms_steps_entity_type_alter()` to register form classes for every form mode used by any step.
Constructor deps: `entity_display.repository`, `config.factory`.

## `forms_steps.workflow.manager` — `WorkflowManager` (`src/Service/WorkflowManager.php`)

Owns the workflow-instance lifecycle. `getWorkflowByEntity()` / `getAllWorksflowByEntity()` load
`forms_steps_workflow` rows by (entity_type, bundle, entity_id). `entityInsert()` (from
`hook_entity_insert`) and `entityPreSave()` (from `hook_entity_presave`, skipped for new entities)
create the workflow row when the current route is a `forms_steps.*` route and the saved entity matches
the current step's entity_type/bundle: it reuses the route's `instance_id` if present (loading a matching
existing row) or generates a new UUID via `@uuid`, then persists (instance_id, entity_type, bundle, step,
entity_id, form_mode, forms_steps). Constructor deps: `entity_type.manager`, `forms_steps.manager`,
`uuid`, `current_route_match`.

## `forms_steps.helper` — `FormsStepsHelper` (`src/Service/FormsStepsHelper.php`)

`getWorkflowInstanceIdFromRoute()` returns the `instance_id` route parameter when on a forms_steps
route (else FALSE). `getThemes()` returns the theme options (`-1` same as collection, `0` default,
`1` admin). Deps: `forms_steps.manager`, `current_route_match`, `string_translation`.

## `forms_steps.workflow.repository` — `WorkflowRepository` (`src/Repository/WorkflowRepository.php`)

Direct DB access to saved workflow rows (`@database`); `load(['instance_id' => …])` returns the steps
already saved for an instance — used by the progress-bar block to decide which links to show.

## `forms_steps.route_subscriber` — `RouteSubscriber` (`src/EventSubscriber/RouteSubscriber.php`)

`routes()` (invoked via `route_callbacks: forms_steps.route_subscriber:routes` in
`forms_steps.routing.yml`) iterates every `forms_steps` config entity's steps and adds a route
`forms_steps.<id>.<step_id>` → `<step url>/{instance_id}` with `_controller
FormsStepsController::step`, `_permission: access content`, and a UUIDv4 `instance_id` requirement.
Deps: `state`, `entity_type.manager`, `config.factory`. (The extra `forms_steps.service.routes`
service in the yml is core's `node` RouteSubscriber, registered as an event subscriber.)

## Controller — `FormsStepsController` (`src/Controller/FormsStepsController.php`)

`step()` → `getForm()` builds the step's entity form (see the flow in
[../configure/workflow.md](../configure/workflow.md)). It special-cases the `user` entity type using
`access_check.user.register` (`RegisterAccessCheck`) so registration-enabled sites allow anonymous
first-step account creation, and throws `AccessDeniedException` / `FormsStepsNotFoundException`
(`src/Exception/`) when access or an instance is missing.

## Progress-bar block — `FormsStepsProgressBarBlock`

`src/Plugin/Block/FormsStepsProgressBarBlock.php` (id `forms_steps_progress_bar`,
deriver `src/Plugin/Derivative/FormsStepsProgressBarBlock.php` = one derivative per `forms_steps`
config entity). `build()` renders only on that workflow's step routes, emitting an ordered
`item_list__forms_steps` themed list with `previous-step` / `active` / `next-step` classes and links
gated by `link_visibility` + the collection's saved-only toggles. `blockAccess()` requires
`access content`; cache is per-route with `max-age 0`.

## Event — `StepChangeEvent`

`\Drupal\forms_steps\Event\StepChangeEvent` (constant `STEP_CHANGE_EVENT =
'forms_steps.step_change_event'`, `src/Event/StepChangeEvent.php`) is dispatched by
`FormsStepsAlter::setNextRoute()` before jumping to another step. Public props: `formsSteps`,
`fromStep`, `toStep`, `formState`. Subscribe to it to alter behavior between steps — e.g. logging a
freshly created user in mid-flow (see README "USER ACCOUNT IN MULTISTEP FORMS").

## Programmatic entity API (config entity)

`FormsSteps` (implements `FormsStepsInterface`) exposes a fluent builder: `addStep()`,
`addProgressStep()`, `setStep*()` (label/weight/url/form_mode/entity_type/entity_bundle/submit/cancel/
delete/previous…), `setProgressStep*()`, `deleteStep()`, `deleteProgressStep()`, `getSteps()`,
`getProgressSteps()`, `getFirstStep()`, `getLastStep()`, `getStepRoute()`, `getNextStepRoute()`,
`getPreviousStepRoute()`. Load with `FormsSteps::load($id)`.
