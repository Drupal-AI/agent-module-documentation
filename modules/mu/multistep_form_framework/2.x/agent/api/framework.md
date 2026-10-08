<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Building a wizard with Multistep Form Framework

Grounded in `src/`. This module ships only an API — no routes, config, permissions, or UI.
Enable with `drush en multistep_form_framework`, then write code.

## 1. Declare the wizard (YAML plugin)

Create `MODULE.multistep_wizard.yml` in your module root. Discovered by
`WizardPluginManager::getDiscovery()` (a `YamlDiscovery` over `multistep_wizard`). Each top-level
key is a wizard id and MUST equal your form's `getFormId()`.

```yaml
your_form_id_here:
  class: \Drupal\your_module\MyWizard      # optional; defaults to Wizard::class
  steps:
    - { id: step_one, class: \Drupal\your_module\Step\StepOne }
    - { id: step_two, class: \Drupal\your_module\Step\StepTwo }
  ajax: TRUE                                # optional; default FALSE
```

Definition defaults (`WizardPluginManager::$defaults`): `id`, `class` = `Wizard::class`,
`steps` = `[]`, `ajax` = `FALSE`. Manager service: `plugin.manager.multistep_wizard`. Other modules
may alter definitions via `hook_multistep_wizard_info_alter()` (alter key set in the manager
constructor). A definition with an empty `steps` array (or no `form_state`) makes the `Wizard`
constructor throw `MissingMandatoryParameterException`.

## 2. The form base

Extend `Drupal\multistep_form_framework\Form\MultistepForm` (an abstract `FormBase`). Only
`getFormId()` is required. Register it on a route with `_form:` as usual.

`MultistepForm` (see `src/Form/MultistepForm.php`):
- `buildForm()` sets `$form['#id']` from the cleaned form id, builds the wizard once via
  `prepareWizard()`, then returns `$this->wizard->buildForm()`.
- `prepareWizard()` calls `$this->wizardManager->createInstance($this->getFormId(), ['form_state' => $form_state])`.
  Override it to seed cross-step data before the first build (the examples create an empty entity).
- `validateForm()` / `submitForm()` delegate to the wizard (hence to the current step).
- `__call()` proxies unknown method calls (e.g. an AJAX or `#submit` callback named on a button) to
  the current step instance, refreshing the wizard's form state first.

## 3. The wizard plugin

`Drupal\multistep_form_framework\Wizard\Wizard` (implements `WizardInterface`, extends `PluginBase`):
- Constructor turns each `steps` definition into a `StepPackage` (`createFromDefinition`) and stores
  the list in `$form_state->set('steps', ...)`; reads `ajax` into `$isAjaxEnabled`.
- Current position: `getCurrentStepOffset()` reads `$form_state->get('step')` (defaults to the first
  key); `setNextStep()`, `setPreviousStep()`, `setCurrentStep(int)`, and
  `setCurrentStepById(string $id)` move it; `isFirstStep()` / `isLastStep()` bound it.
- `getCurrentStepInstance()` resolves the current step class through `class_resolver` and calls
  `$step->setWizard($this)`.
- Subclass `Wizard` (set via the YAML `class:` key) to add typed cross-step accessors — see the
  example `BookWizard::setBook()/getBook()` which stash a node in `$form_state`.

## 4. The steps

Extend `Drupal\multistep_form_framework\Step\BaseStep` (implements `StepInterface`,
`ContainerInjectionInterface`). Implement `buildForm()`. Optional: `validateForm()`, `submitForm()`,
and per-action handlers.

`BaseStep` (see `src/Step/BaseStep.php`):
- `form()` merges your `buildForm()` output with an `actions` element from `getActions()`.
- `getActions()` adds a `back` button (`Previous`, `#limit_validation_errors => []`, handler
  `::backAction`) unless first step, a `next` button (`Next`, handler `::nextAction`) unless last
  step, and a `submit` button (`Submit`, handler `::submitAction`) on the last step. Button ids are
  the `StepInterface::BACK/NEXT/SUBMIT` constants.
- `nextAction()` / `backAction()` call `$this->wizard->setNextStep()` / `setPreviousStep()` then
  `$form_state->setRebuild(TRUE)`. Override `nextAction()` to persist that step's input before
  advancing.
- Customise buttons by overriding `getNextButton()`, `getBackButton()`, `getSubmitButton()`, or
  override `getActions()` to add/remove buttons.

## 5. AJAX

When the wizard's `ajax` is TRUE, `BaseStep::getActions()` attaches `#ajax['callback'] =
'::ajaxSubmit'` and `#ajax['wrapper'] = $form['#id']` to every action button, plus
`getDefaultAjaxOptions()` (a throbber). `ajaxSubmit()` simply returns the rebuilt `$form`. A step may
override a button's callback to return an `AjaxResponse` (e.g. a `RedirectCommand`). Navigation still
goes through normal Form API submit + rebuild, so submissions carry the standard form token.

## 6. Entity-field widgets (optional)

`Drupal\multistep_form_framework\EntityWidgetsTrait` lets a step render real configured field
widgets and read them back:
- `getWidgetForm(FieldItemListInterface $field, &$form, $form_state, $view_mode = 'default')` loads
  the entity's `entity_form_display` and returns `$widget->form(...)`.
- `extractFormValues(...)` writes submitted values back onto the field.
Use it (as the examples do) to build up an entity across steps and `->save()` it on a later step.

## State & persistence

There is no tempstore and no database table. `steps`, the current `step` offset, and any data a
wizard subclass stashes all live in Form API `$form_state`, i.e. the standard per-user, per-session
form cache keyed by the form build id. State is naturally isolated per user and discarded when the
form cache expires.
