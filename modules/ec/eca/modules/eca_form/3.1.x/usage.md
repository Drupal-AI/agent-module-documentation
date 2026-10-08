ECA Form brings Drupal's Form API into ECA, letting models alter, validate, and act on any form — adding fields, changing element properties, setting values, enforcing validation, and controlling submission — without writing form-alter code.

---

This submodule exposes form building, validation, and submission as ECA events, conditions, and actions. Events fire at the form lifecycle points (build/alter, validate, submit) for any form id. Conditions test form context: which operation is running, whether a field exists, its value, whether the form was submitted or triggered by a given element, and whether the form has validation errors. Its extensive action set can add elements (textfields, hidden fields, options fields, containers, groups, submit buttons, AJAX), change field properties (label, description, weight, default value, options, access, required, disabled, #states), read field/option values, set validation errors, and manipulate form state (properties, rebuild, redirect, method, build entity). This turns "alter this form conditionally" into a no-code model. It registers into ECA Core's managers and defines no new plugin types.

---

- Alter any Drupal form without a custom `hook_form_alter`.
- Add a textfield or hidden field to a form dynamically.
- Add an options (select/radios) field with computed options.
- Add a container, fieldgroup, or submit button.
- Make a field required or optional based on conditions.
- Disable or hide a field conditionally.
- Set a field's default value from a token.
- Change a field's label, description, or weight.
- Apply `#states` (show/hide) logic to a field.
- Add AJAX behavior to a form element.
- Read a field's current value or its options.
- Set a validation error on a specific field.
- Block submission when the form has errors.
- Redirect the user after submit.
- Change the form method (GET/POST).
- Set or read arbitrary form-state properties.
- Force a form rebuild.
- Build an entity from submitted form values.
- React only for a specific form operation (add/edit/delete).
- Detect which button triggered the form.
- Validate cross-field business rules declaratively.
- Restrict field access per role or condition.
- Prefill forms based on the current user or context.
- Add a computed confirmation step to a form.
- Trigger downstream actions when a form is submitted.
