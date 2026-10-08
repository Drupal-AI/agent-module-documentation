Forms Steps builds configurable multi-step (wizard) forms out of Drupal **form modes**: you define a Forms Steps workflow whose ordered steps each render a specific entity type/bundle in a chosen form mode, and the module strings them together with a shared instance id, navigation buttons, and an optional progress bar.

---

A `forms_steps` config entity holds an ordered list of **steps** (each: `entity_type`,
`entity_bundle`, `form_mode`, `url`, submit/cancel/previous labels, cancel route/step,
delete/previous visibility) and **progress_steps** (the progress-bar items), plus a
`redirection_policy`/`redirection_target` for where to go when the workflow ends. Managed via
the admin UI at `/admin/config/workflow/forms_steps` (route `entity.forms_steps.collection`,
`configure`), all gated by the `administer forms_steps` permission. A dynamic route subscriber
(`forms_steps.route_subscriber`) generates a front-end route per step at `<step url>/{instance_id}`
(instance id is a validated UUID) guarded by the core `access content` permission, so the
public can walk the wizard; `FormsStepsController::step()` loads or creates the entity for that
instance and renders it in the step's form mode via `FormsStepsAlter`. The **WorkflowManager**
tracks a workflow "instance" across steps (each browser session's run gets one UUID), letting
step N edit the same entity created in step 1 or create linked entities; a Drush command
`forms_steps:attach-entity` binds an existing entity to a step/instance. A derivative Block
plugin (`FormsStepsProgressBarBlock`) renders the progress bar, and a `StepChangeEvent` fires
when the user moves between steps. Because steps map to real entity form modes, any field on
the entity is available per step with normal Field UI, and validation/build-up happens
incrementally as the user advances.

---

- Split a long content-entry form into a guided multi-step wizard.
- Collect a public application/registration across several pages that build one entity.
- Create linked entities across steps (e.g. a node in step 1, a referenced entity in step 2).
- Show only a subset of an entity's fields per step using distinct form modes.
- Add a progress bar block that reflects the user's position in the workflow.
- Configure custom Next / Previous / Cancel / Delete button labels per step.
- Redirect to a chosen route or step when the wizard completes.
- Let anonymous users complete a multi-step form (guarded by "access content").
- Resume a workflow instance via its UUID in the step URL.
- Only reveal progress links for steps already saved to the database.
- Reveal the next step's progress link once the current step is saved.
- Cancel out of a step back to a specific earlier step or an arbitrary route.
- Build survey/onboarding flows without custom form controllers.
- Attach an existing entity to a step programmatically with `drush forms_steps:attach-entity`.
- React to step transitions by subscribing to `StepChangeEvent`.
- Reuse entity form modes you already manage in Field UI for wizard steps.
- Provide separate URLs (aliasable) for each step of a flow.
- Manage multiple independent wizards on one site, each its own `forms_steps` config entity.
- Hide the delete button on steps where deletion shouldn't be offered.
- Export multi-step form definitions as configuration for deployment.
- Track and list workflow instances (submissions in progress) via the workflow entity list.
- Render each step in the admin theme when node "use admin theme" is enabled.
