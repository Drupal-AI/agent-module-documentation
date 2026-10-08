<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Multistep Form Framework (multistep_form_framework) — agent index

Developer-only API for building multistep (wizard) forms. No UI, no config form, no
permissions, no routes of its own. You subclass a base form and declare an ordered list of
step classes in a YAML plugin file; the framework runs one step at a time and tracks position
in the standard Form API `$form_state` (per-user form cache — no tempstore, no DB table).

- Machine name: `multistep_form_framework`. Core: `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later.
- Dependencies: none (core only). Composer: `drupal/multistep_form_framework`.
- Submodule: `multistep_form_framework_examples` (a runnable "buy a book" demo; dev/example code).

## What it provides

- Plugin type `multistep_wizard` — YAML discovery (`MODULE.multistep_wizard.yml`), one entry per
  wizard keyed by the owning form's `getFormId()`. Manager service
  `plugin.manager.multistep_wizard` (`WizardPluginManager`), alter hook `multistep_wizard_info_alter`.
- Abstract form base `Drupal\multistep_form_framework\Form\MultistepForm` (extends `FormBase`).
- Default plugin class `Drupal\multistep_form_framework\Wizard\Wizard` (implements `WizardInterface`);
  override per-wizard with the `class:` key.
- Abstract step base `Drupal\multistep_form_framework\Step\BaseStep` (implements `StepInterface`);
  step wrapper `StepPackage`; exception `MissingMandatoryParameterException`.
- Helper trait `Drupal\multistep_form_framework\EntityWidgetsTrait` — render/extract entity-field
  widgets inside a step.

## Key mechanics (cite the source)

- Definition defaults live in `WizardPluginManager::$defaults`: `id`, `class` (=`Wizard`),
  `steps` (array of `{id, class}`), `ajax` (bool, default FALSE).
- `MultistepForm::buildForm()` builds the wizard once, then delegates build/validate/submit to
  `Wizard`, which delegates to the current `StepInterface` instance (`getCurrentStepInstance()`).
- Step position: `Wizard` stores `steps` and the current `step` offset in `$form_state`;
  `setNextStep()`/`setPreviousStep()`/`setCurrentStepById()` move it; `nextAction`/`backAction`
  call `$form_state->setRebuild(TRUE)`.
- `BaseStep::getActions()` emits Next/Previous/Submit submit buttons with dedicated `#submit`
  handlers; when `ajax` is TRUE it attaches `::ajaxSubmit` to each button.

## Solution docs

- [agent/api/framework.md](api/framework.md) — build a wizard end to end: the YAML plugin, the form
  base, the step lifecycle, navigation, AJAX, and `EntityWidgetsTrait`.
