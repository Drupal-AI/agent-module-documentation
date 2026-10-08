Forms Steps builds configurable multi-step (wizard) forms out of Drupal **form modes**: you define a Forms Steps workflow whose ordered steps each render a specific entity type/bundle in a chosen form mode, and the module strings them together with a shared instance id, navigation buttons, and an optional progress bar.

---

A `forms_steps` config entity holds an ordered list of **steps** (each: `entity_type`,
`entity_bundle`, `form_mode`, `url`, submit/cancel/previous labels, cancel route/step,
delete/previous visibility) and **progress_steps** (the progress-bar items), plus a
`redirection_policy`/`redirection_target` for where to go when the workflow ends. Workflows are
managed via the admin UI at `/admin/config/workflow/forms_steps` (route
`entity.forms_steps.collection`, the `configure` route), all gated by the `administer forms_steps`
permission. A dynamic route subscriber (`forms_steps.route_subscriber`, class `RouteSubscriber`)
generates a front-end route per step at `<step url>/{instance_id}` (instance id is a validated
UUID) guarded by the core `access content` permission, and `FormsStepsController::step()` loads or
creates the entity for that instance and renders it in the step's form mode; entity create/update
access is checked before the form is shown. The **WorkflowManager** service tracks a workflow
"instance" across steps (each run gets one UUID stored in a `forms_steps_workflow` content entity),
so step N can edit the same entity created in step 1, or create linked entities; a Drush command
`forms_steps:attach-entity` binds an existing entity to a step/instance. A derivative Block plugin
(`FormsStepsProgressBarBlock`) renders the progress bar, and a `StepChangeEvent` fires when the
user moves between steps so custom code can react. Because steps map to real entity form modes, any
field on the entity is available per step through normal Field UI, and validation happens
incrementally as the user advances.

---

- Split a long content-entry form into a guided multi-step wizard.
- Collect a public application or registration across several pages that build one entity.
- Create linked entities across steps (e.g. a node in step 1, a referenced entity in step 2).
- Show only a subset of an entity's fields per step using distinct form modes.
- Add a progress-bar block that reflects the user's position in the workflow.
- Configure custom Next / Previous / Cancel / Delete button labels per step.
- Redirect to a chosen internal route, named route, entity canonical page, or external URL when the wizard completes.
- Let anonymous users complete a multi-step form (front-end steps are guarded by "access content").
- Resume a workflow instance later via its UUID in the step URL.
- Reveal progress links only for steps already saved to the database.
- Reveal the next step's progress link once the current step is saved.
- Cancel out of a step back to a specific earlier step or an arbitrary route.
- Build survey, onboarding, or intake flows without writing custom form controllers.
- Attach an existing entity to a step programmatically with `drush forms_steps:attach-entity`.
- React to step transitions by subscribing to `StepChangeEvent` (e.g. log the user in mid-flow).
- Reuse entity form modes you already manage in Field UI as wizard steps.
- Provide separate, aliasable URLs for each step of a flow.
- Run multiple independent wizards on one site, each its own `forms_steps` config entity.
- Hide the delete button on steps where deletion should not be offered.
- Render each step in the admin theme or default theme independently of the collection.
- Export multi-step form definitions as configuration for deployment across environments.
- Track and list workflow instances (submissions in progress) via the workflow instance list.
- Support multi-step user-account creation flows (with registration policy configured).
- Weight and reorder steps and progress steps to control the wizard sequence.
