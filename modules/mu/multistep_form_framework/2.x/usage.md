Multistep Form Framework is a developer-only, UI-less API for building multistep (wizard) forms in Drupal by declaring an ordered list of step classes in a YAML plugin file.

---

The module supplies an abstract `MultistepForm` base (a `FormBase`) plus a `multistep_wizard` YAML plugin type. A developer extends `MultistepForm`, gives it a `getFormId()` that matches a top-level key in a `MODULE.multistep_wizard.yml` file, and points that key at an ordered list of step classes (each extending `BaseStep`). At runtime a `Wizard` plugin instance is created from the definition, the current step offset is tracked in Form API `$form_state`, and only the current step's `buildForm()` / `validateForm()` / `submitForm()` run. Navigation is done through per-step submit buttons (`Next`, `Previous`, `Submit`) whose dedicated submit handlers (`nextAction`, `backAction`, `submitAction`) call `$wizard->setNextStep()` / `setPreviousStep()` and `$form_state->setRebuild(TRUE)`; a step can also jump to any other step by id via `Wizard::setCurrentStepById()`. Setting `ajax: TRUE` on the wizard definition wires every action button to an AJAX callback (`::ajaxSubmit`) that re-renders the form wrapper. Because all wizard state lives in the standard per-user Form API form cache, no custom persistence, tempstore, or database table is needed. There is no UI, no configuration form, and no permissions; if you need a click-together builder use Webform instead. An optional `EntityWidgetsTrait` lets a step render and extract real entity-field widgets so a wizard can build up an entity across steps. The bundled `multistep_form_framework_examples` submodule demonstrates the whole flow with a four-step "buy a book" wizard.

---

- Build a multi-page registration or onboarding wizard where each page is its own step class.
- Split a long, intimidating single form into several short, sequential steps.
- Collect the fields of a Drupal entity (node, user, custom entity) across several steps and save it only on the final step.
- Render actual configured entity-field widgets inside wizard steps via `EntityWidgetsTrait::getWidgetForm()` / `extractFormValues()`.
- Create a checkout-style flow (details, options, confirmation) without pulling in Commerce.
- Build a survey or questionnaire whose branching is decided in each step's submit handler.
- Jump the user back to an earlier step (`setCurrentStepById('greetings')`) when they need to correct earlier input.
- Skip steps conditionally based on values submitted in a previous step.
- Enable AJAX (`ajax: TRUE`) so step transitions happen without a full page reload.
- Customise each navigation button's label or markup by overriding `getNextButton()`, `getBackButton()`, or `getSubmitButton()` in a step.
- Add extra per-step buttons (e.g. "Go to first step") with their own submit handler and AJAX callback.
- Remove a button on specific steps (e.g. drop the "Previous" button on the final confirmation step).
- Add a per-step title or CSS class by overriding the step's `form()` method.
- Use a custom wizard subclass (extend `Wizard`) as a typed holder for cross-step data, e.g. `BookWizard::getBook()` / `setBook()`.
- Keep several independent multistep forms tidy in one module by giving each its own step namespace.
- Return an AJAX `RedirectCommand` from a final step to send the user elsewhere after completion.
- Replace or extend the default `Wizard` plugin class per form via the `class:` key in the YAML definition.
- Alter another module's wizard definitions through the `hook_multistep_wizard_info_alter()` alter hook.
- Validate one step at a time, letting the "Previous" button bypass validation (`#limit_validation_errors => []`).
- Prototype a stepped admin/config workflow without writing a custom form-state machine.
- Learn the pattern quickly by enabling the examples submodule and visiting its demo wizard.
