<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple Multistep converts any entity form into a multi-step (wizard) form by adding a "Form step" field_group formatter — each such group becomes one step with Next/Back navigation.

---

The module depends on `field_group` and registers a field-group formatter plugin
`form_step` (`Drupal\simple_multistep\Plugin\field_group\FieldGroupFormatter\FormStep`,
form context only). On *Manage form display* you add one or more "Form step" groups and drop
fields into each; every group becomes a step. A `hook_form_alter` (ordered to run after
field_group via `hook_module_implements_alter`) detects displays that contain a `form_step`
group (`_check_form_multistep()`) and hands the form to a `MultistepController`
(`MultistepControllerInterface`) that hides all but the current step, injects Next/Back
buttons, and rebuilds the form; `StepIndicator`, `FormButton`, `FormStep`, and `FormText`
helper classes build the step UI, and a small CSS library (`simple_multistep/simple_multistep`)
styles it. Step navigation is server-side: the Next submit handler builds the entity so far
and advances `current_step` with `$form_state->setRebuild()`, Back decrements it. Per-step
settings (schema `field_group.field_group_formatter_plugin.form_step`) include the step
title visibility, description, help text, custom Next/Back button labels, whether to show
the Back button, and a required-fields flag. It also hooks Inline Entity Form
(`hook_inline_entity_form_entity_form_alter`) so multistep works inside IEF sub-forms. The
default controller can be swapped per form via `hook_simple_multistep_controller_alter()`.
There are no permissions, no Drush, and no global config page — everything is per form
display.

---

- Split a long content-creation form into several themed steps.
- Turn a complex registration or profile form into a guided wizard.
- Add Next/Back navigation to any entity form without custom code.
- Group related fields into logical steps (e.g. "Details", "Media", "Review").
- Show a step title and description at the top of each step.
- Provide per-step help text to guide editors.
- Customize the Next and Back button labels per step.
- Hide the Back button on the first step (configurable).
- Enforce required fields before advancing to the next step.
- Build a multi-step survey or application form on top of an entity.
- Reduce form abandonment by presenting fewer fields at a time.
- Add a step indicator/progress display to an entity form.
- Use multistep inside an Inline Entity Form sub-form.
- Apply multistep only to a specific form mode by configuring that display.
- Convert a webform-like flow using standard entity fields and field_group.
- Swap in a custom step controller for bespoke navigation logic via the alter hook.
- Keep entered values across steps (entity is rebuilt on each Next).
- Theme the wizard with the module's CSS or override it.
- Create an onboarding flow that walks a user through profile completion.
- Break a data-entry form for staff into manageable sections.
