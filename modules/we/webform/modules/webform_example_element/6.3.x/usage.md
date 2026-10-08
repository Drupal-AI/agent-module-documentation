A reference example module demonstrating how to build a custom Webform element by pairing a Form API render element with a `WebformElement` plugin.

---

Webform Element Example is a developer teaching module, not something you enable on a production site. It ships two classes: a custom render/form element (`Drupal\webform_example_element\Element\WebformExampleElement`) and the matching `@WebformElement` plugin (`Drupal\webform_example_element\Plugin\WebformElement\WebformExampleElement`) that registers it with Webform's element system. The plugin shows the canonical hooks you override — `defineDefaultProperties()`, `prepare()`, `getElementSelectorOptions()`, `preview()` and friends — so a new element inherits properties like `multiple`, `size`, `placeholder` and a custom `example_textarea`. A bundled `config/install` webform demonstrates the element in a real form. Copy the module, rename the machine name and classes, and you have a working scaffold for any bespoke element. It depends only on the base `webform` module and defines no configuration UI, permissions, or services of its own.

---

- Learn the minimum files needed to register a new Webform element.
- Copy as a scaffold when building a custom form element for Webform.
- See how a Form API render element maps to a `@WebformElement` plugin.
- Understand `defineDefaultProperties()` and inheritable element properties.
- Study how `prepare()` customizes an element before rendering.
- Reference `getElementSelectorOptions()` for exposing element selectors.
- Learn how custom properties (e.g. `example_textarea`) are declared.
- Example of adding `multiple`, `size`, `minlength`, `maxlength`, `placeholder` support.
- Model how to render a preview of an element in the Webform UI.
- Teach a team the Webform element plugin API during onboarding.
- Provide a known-good element for automated/manual QA of Webform.
- Test that a custom element renders inside the bundled example webform.
- Demonstrate element formatting for HTML and plain-text output.
- Use as a live code sample in documentation or training.
- Compare against core Webform elements to learn conventions.
- Bootstrap a contrib module that adds a new element type.
- Verify your element namespace/PSR-4 wiring is correct.
- Prototype element behavior before writing production code.
- Explore how element default values flow into submissions.
- Reference for writing tests around a custom Webform element.
