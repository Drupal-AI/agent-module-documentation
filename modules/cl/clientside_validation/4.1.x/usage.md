Clientside Validation adds client-side (in-browser) validation to Drupal forms so errors are shown before the form is submitted. The base module only decorates form elements with HTML5/`data-*` validation attributes; a companion engine submodule (`clientside_validation_jquery`) actually runs the validation.

---

Clientside Validation hooks into every form via `hook_form_alter()` and an `#after_build` callback that walks the whole render array recursively. For each element it asks a `CvValidator` plugin manager (`plugin.manager.clientside_validation.validators`) which validator plugins apply, based on the element's `#type` (e.g. `email`, `url`) or the presence of attributes (`required`, `pattern`, `min`, `max`, `maxlength`, `step`, `states`, `equal_to`). Each matching plugin writes `data-rule-*` and `data-msg-*` attributes onto the element (Drupal-translated messages) and `#attaches` any JS library it needs. The base module ships eight core validators (required, email, url, url_internal_external, min, max, maxlength, step) and defines the `CvValidator` annotated plugin type so other modules can add their own rules. Whether an element is validated at all can be short-circuited with `hook_clientside_validation_should_validate()`, and the discovered validator info can be altered with `hook_clientside_validation_validator_info_alter()`. On its own the base module changes nothing visible — you also enable `clientside_validation_jquery`, which loads the jQuery Validate plugin (from a local library or CDN) and turns those attributes into live, before-submit validation with inline messages. Submit buttons that use `#limit_validation_errors` are marked with a `cancel` class so they bypass validation. A demo submodule (`clientside_validation_demo`) exists for testing only.

---

- Show "field is required" errors in the browser before the user submits a form.
- Validate email fields client-side using the element's `email` `#type`.
- Validate URL fields client-side (`url` and internal/external URL variants).
- Enforce `maxlength` on a textfield with an instant character-count error.
- Enforce numeric `min` / `max` / `step` on number fields before submit.
- Turn a `#pattern` regex on a textfield into a live pattern check (with the jQuery submodule).
- Enforce "must match" between two fields, e.g. password confirmation (`equal_to`).
- Provide custom per-element error text via `#required_error`, `#pattern_error`, etc.
- Respect Drupal `#states` so conditionally-required fields validate correctly.
- Add client-side validation to any contrib module's form elements by shipping a `CvValidator` plugin.
- Register a brand-new validation rule (custom `data-rule-*`) with accompanying JS.
- Alter or extend the discovered validator definitions via `hook_clientside_validation_validator_info_alter()`.
- Skip client-side validation for specific forms/elements via `hook_clientside_validation_should_validate()`.
- Reduce round-trips to the server by catching obvious input mistakes in the browser.
- Improve UX on long forms by flagging the first invalid field immediately.
- Keep validation messages consistent with Drupal's translated strings.
- Let "Cancel"/"Preview" style buttons (`#limit_validation_errors` empty) bypass validation via the `cancel` class.
- Add HTML5-attribute-driven validation without hand-writing JavaScript.
- Validate AJAX forms before they submit (via the jQuery submodule's `validate_all_ajax_forms` setting).
- Validate CKEditor-backed textareas (jQuery submodule integrates with CKEditor).
- Integrate client-side messages with Inline Form Errors when that module is enabled.
- Serve the jQuery Validate library from a local `libraries/` copy instead of a CDN for privacy/offline.
- Force native HTML5 validation to run first, before the jQuery layer.
