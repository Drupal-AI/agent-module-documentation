<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "buy a book" wizard, class by class

A complete Multistep Form Framework example. Enable with
`drush en multistep_form_framework_examples` (a dev-only reference module; pulls in `node`, `text`,
`options`, `image`, `file`, `user` and installs a `book` content type from `config/optional/`).

## Wiring

- Route `multistep_form_framework_examples.book_buy_multistep` (in
  `multistep_form_framework_examples.routing.yml`) maps a path to `_form: BookBuyMultistepForm` with
  requirement `_permission: 'access content'`.
- `multistep_form_framework_examples.multistep_wizard.yml` defines
  `multistep_form_framework_examples_book_buy_multistep` with `ajax: TRUE`, `class: BookWizard`, and
  four steps in order: `greetings` → `book_attributes` → `description` → `graz` (Congratulation).

## The form and wizard

`BookBuyMultistepForm` (`src/Form/BookBuyMultistepForm.php`) extends `MultistepForm`. Its
`getFormId()` returns `multistep_form_framework_examples_book_buy_multistep` (matching the YAML key).
`prepareWizard()` calls the parent to build the `BookWizard`, then seeds it with a fresh unsaved
`Node::create(['type' => 'book'])` via `$wizard->setBook(...)`.

`BookWizard` (`src/BookWizard.php`) extends `Wizard` and adds `setBook(NodeInterface)` /
`getBook(): NodeInterface`, which just store/read the node in `$this->formState` under key `book`.
This is the recommended "typed form-state holder" pattern.

## The step base

`BuyBookStep\BaseStep` (`src/Form/BuyBookStep/BaseStep.php`) extends the framework `BaseStep` and adds
`EntityWidgetsTrait` + `MessengerTrait`. Its `create()` injects `entity_type.manager` and `messenger`.
Its `form()` prepends a step-id CSS class (`Html::cleanCssIdentifier($this->wizard->getCurrentStep()->getId())`)
and a per-step `<h2>` title (`#type => html_tag`) from the abstract `getTitle()`, then calls the parent.

## The four steps

- `Greetings` — `buildForm()` renders the `field_type` widget via
  `getWidgetForm($book->get('field_type'), ...)`. `nextAction()` extracts that value onto the node
  (`extractFormValues(...)`) then calls `parent::nextAction()` to advance. Customises the Next label
  to "Let's Go!".
- `BookAttributes` — `getFieldsToRender()` returns `field_price`, `field_image`, `field_is_new`;
  `buildForm()` renders each field's widget; `nextAction()` extracts all of them then advances.
- `Description extends BookAttributes` — overrides `getFieldsToRender()` to `body`, `status`.
  `nextAction()` extracts, then `$book->setTitle('Awesome!')`, `$book->save()`, and a status message.
  Adds a "Go to first step!" button whose handler `goToFirstStep()` calls
  `$this->wizard->setCurrentStepById('greetings')` and `$form_state->setRebuild()` — the documented
  way to jump to an arbitrary step by id. Next label becomes "Save".
- `Congratulation` (`graz`) — a text-only final step. `getActions()` removes the Back button and
  rewires the Submit button's AJAX callback to the static `redirectToFrontPage()`, which returns an
  `AjaxResponse` carrying a `RedirectCommand` to `<front>`.

## Takeaways

- Seed cross-step entities in `prepareWizard()`; carry them in a `Wizard` subclass.
- Render/extract real field widgets with `EntityWidgetsTrait`; persist with a plain `$entity->save()`.
- Move between steps with `parent::nextAction()` / `backAction()` or `setCurrentStepById()`, always
  followed by `$form_state->setRebuild()`.
- Customise buttons by overriding the getter methods or `getActions()`; a step can return its own
  `AjaxResponse` from a button callback.
