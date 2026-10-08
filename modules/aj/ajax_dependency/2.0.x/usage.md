<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Ajax Dependency provides a helper service for making one form element's rendering (access, value, properties) depend on another element's value, refreshed server-side via AJAX.

---

Ajax Dependency is a developer helper for the Drupal Form API. Like Conditional Fields / core `#states`, it lets the visibility or content of a form element depend on the value of another element — but instead of toggling with client-side JavaScript, it re-renders the dependent (target) element server-side over AJAX whenever the source element changes, and re-checks the target's own `#access` on each rebuild. You wire dependencies programmatically from a form's `buildForm()` or `hook_form_alter()` using three static methods on `Drupal\ajax_dependency\AjaxDependency`: `dependsOn()` (refresh target when source changes), `accessIf($condition, ...)` (also set target `#access` from a condition), and `contentIf($condition, ...)` (also blank the target `#value` when the condition is false). The module has no admin UI, no routes, and no config in the main module; all wiring is code. A no-JS `<Update>` submit button is injected automatically so the dependency still works without JavaScript. It ships an `ajax_dependency_example` submodule with a working demo form at `/ajax-dependency-example-form`.

---

- Show a "topics" field only when an organisation type of "initiative" is selected, refreshed over AJAX.
- Reveal business-specific fields (business types, sustainability) only for "business" org types.
- Toggle a text field's visibility from a checkboxes element's selection without page reload.
- Make a required field conditionally required by toggling its `#access` based on another element.
- Clear a dependent field's value automatically when its controlling condition becomes false (`contentIf`).
- Add server-evaluated field dependencies from a custom `FormBase::buildForm()`.
- Add dependencies to an existing entity/node edit form from `hook_form_BASE_FORM_ID_alter()`.
- Re-render a fieldset/container of fields when a select or radios value changes.
- Provide a graceful no-JavaScript fallback (auto-injected "Update choice" submit button) for AJAX-dependent fields.
- Keep field-level access control intact: a target the user cannot access is rendered as an empty placeholder, not exposed.
- Chain multiple targets to one source (one checkbox controls several dependent fields).
- Depend on a multi-value / checkboxes source where the triggering element is a sub-element.
- Compose custom AJAX response processing on an element alongside the dependency (via `ComposableAjax`).
- Build conditional multi-step-like form UX without a full multistep module.
- Toggle widget rendering based on raw user input during an AJAX rebuild (before validation).
- Use as a lighter, Ajax-based alternative to Conditional Fields for developer-authored forms.
- Learn the API from the shipped example submodule's `AjaxDependencyExampleForm`.
- Attach dependencies to Form API render elements without writing custom AJAX callbacks or wrappers.
- Give each dependent element a stable server-generated selector for targeted `ReplaceCommand` updates.
- Prototype AJAX-driven conditional forms quickly during module development.
