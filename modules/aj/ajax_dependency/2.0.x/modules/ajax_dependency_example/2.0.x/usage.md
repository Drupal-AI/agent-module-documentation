<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Demonstration submodule for Ajax Dependency: a single form showing how to toggle dependent fields from a checkboxes element via the helper API.

---

`ajax_dependency_example` is a learning/reference submodule of Ajax Dependency. Enabling it registers one route, `/ajax-dependency-example-form`, rendering `AjaxDependencyExampleForm`. The form has a `selector` checkboxes element ("One"/"Two") and two dependent fields, `variant_one` (textfield) and `variant_two` (checkbox). Using `AjaxDependency::contentIf()`, `variant_one` is shown only when "One" is checked and `variant_two` only when "Two" is checked, re-rendered server-side over AJAX. It depends on `ajax_dependency` and exists to demonstrate the API; it is not meant for production. The `configure` link points at the same form route.

---

- See a working example of `AjaxDependency::contentIf()` toggling fields from a checkboxes source.
- Learn how to read raw user input (`$form_state->getUserInput()`) during an AJAX rebuild instead of validated values.
- Observe the auto-injected no-JS "Update choice" submit fallback in action.
- Verify Ajax Dependency is installed and working on a site.
- Copy `AjaxDependencyExampleForm::buildForm()` as a template for your own dependent forms.
- Understand how one source element can control multiple dependent targets.
- Demonstrate server-side re-rendering of conditional fields to stakeholders.
- Test AJAX-dependent field behavior with and without JavaScript.
- Reference the `setRebuild()` submit pattern used to keep the demo form interactive.
- Disable after learning; the submodule adds no value to a production deployment.
