Multistep Form Framework Examples is the bundled reference submodule that demonstrates the framework with a runnable four-step "buy a book" wizard.

---

This submodule exists purely to show developers how to wire up Multistep Form Framework. It ships a `book` content type (with `field_type`, `field_price`, `field_image`, `field_is_new`, `body`, `status` fields) as optional config, a YAML wizard definition (`multistep_form_framework_examples.multistep_wizard.yml`, `ajax: TRUE`), a `MultistepForm` subclass (`BookBuyMultistepForm`) whose `prepareWizard()` seeds an empty `book` node, a `Wizard` subclass (`BookWizard`) that stores that node in form state via `getBook()`/`setBook()`, and four step classes under `src/Form/BuyBookStep/`: `Greetings`, `BookAttributes`, `Description`, and `Congratulation`. The steps render real entity-field widgets through `EntityWidgetsTrait`, add per-step titles and CSS classes, customise button labels, jump back to the first step by id, save the node on the `Description` step, and finish with an AJAX redirect to the front page. The demo form is served at a route so you can click through it and read the source alongside. Because it demonstrates node creation and depends on `node`, `text`, `options`, `image`, `file`, and `user`, it is a learning/reference module — enable it in a development environment only, not on production.

---

- Study a complete, working Multistep Form Framework implementation before writing your own.
- See how a `MultistepForm` subclass seeds a fresh entity in `prepareWizard()`.
- See how a `Wizard` subclass (`BookWizard`) acts as a typed holder for cross-step data.
- Learn how a step renders a real configured field widget with `EntityWidgetsTrait::getWidgetForm()`.
- Learn how a step reads submitted widget values back with `extractFormValues()` in `nextAction()`.
- See how to add a per-step `<h2>` title and a step-id CSS class by overriding `form()` (`BuyBookStep\BaseStep`).
- See how to change a Next button's label (`BookAttributes::getNextButton()` → "Let's Go!").
- See how one step reuses another by extending it (`Description extends BookAttributes`).
- See how to save the built entity mid-wizard (`Description::nextAction()` calls `$book->save()`).
- See how to add a "go to first step" button and jump with `setCurrentStepById('greetings')`.
- See how to drop the Previous button on a final step (`Congratulation::getActions()`).
- See how a final step returns an AJAX `RedirectCommand` to the front page.
- Use the shipped `book` content type and fields as a scaffold for your own wizard-built entity.
- Copy the `multistep_form_framework_examples.multistep_wizard.yml` structure as a template.
- Demonstrate the framework to teammates by walking through the live demo form.
- Verify the framework works in your environment by enabling the submodule and completing the wizard.
