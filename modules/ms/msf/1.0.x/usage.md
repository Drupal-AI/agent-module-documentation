<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Multistep Form Advanced (msf) turns a long entity form into a multi-step wizard by adding a "Form step" field_group formatter with next/previous navigation and a step indicator.

---

Long content or registration forms are easier to complete when broken into stages. msf builds on the field_group module: it registers a `FieldGroupFormatter` plugin (`form_step`, "Form step") that you apply to field groups in a form display. At render time `MultistepController::rebuildForm()` shows only the current step's fields (setting `#access = FALSE` on the others and hiding nested field groups), adds next/previous buttons (`FormButton`), a `StepIndicator`, and step text (`FormText`), and scopes `#limit_validation_errors` so each step only validates its own fields.

The module has no routes, permissions, services, or configuration entities of its own — everything is driven through the standard "Manage form display" UI where you group fields and choose the Form step formatter. It depends on field_group and account_field_split (the latter lets the user registration form's account fields be split across steps; there is a documented TODO around the password field being required on non-current steps). Because it is purely a form-display formatter, it introduces no anonymous or mutating HTTP surface of its own.

---

- Split a long node form into multiple steps.
- Add a wizard-style flow to the user registration form.
- Apply the "Form step" formatter to a field group in Manage form display.
- Show a step indicator so users see progress.
- Add next/previous navigation buttons to a form.
- Validate only the current step's fields on "Next".
- Group related fields into a single step.
- Hide fields belonging to other steps.
- Break a webform-like content form into digestible sections.
- Reduce form abandonment on long forms.
- Combine multiple field groups into an ordered sequence of steps.
- Split account fields across steps via account_field_split.
- Improve UX for complex product/content entry.
- Configure step text/labels per step.
- Nest field groups inside a step.
- Reorder steps by reordering field groups.
