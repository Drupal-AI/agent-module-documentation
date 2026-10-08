<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Validation adds cross-element validation rules to the Webform module — verifying that several elements hold equal values, comparing two elements with an operator, or requiring that some number out of a group of elements be completed.

---

The module has no admin page, config schema, permissions, Drush commands or plugin types — it works entirely by extending the per-element configuration form of the Webform module. Via `hook_webform_element_default_properties_alter()` and `hook_webform_element_configuration_form_alter()` it adds a "Form extra validation" fieldset to each supported element's settings, exposing three validators: **Equal values** (all selected components must match; emails compared case-insensitively), **Compare two values** (first vs second using `>`, `>=`, `<` or `<=`, with an optional custom error), and **Some of several** (complete e.g. at least/at most/exactly N of a group, optionally on the final wizard page). The choices are stored as element properties (`#equal__enabled`/`#equal__components`, `#compare__enabled`/`#compare__component`/`#compare__operator`/`#compare__custom_error`, `#some_of_several__enabled`/`#some_of_several__components`/`#some_of_several__completed`/`#some_of_several__final_validation`) inside the webform config entity's `elements` YAML. At submission time the module appends `Drupal\webform_validation\Validate\WebformValidateConstraint::validate` to the webform's `#validate` callbacks, walking every element and running the enabled rules to set form errors. Supported element types are fixed by two class constants — `ALLOWED_TYPES` (date, datetime, email, hidden, number, select, tel, textarea, textfield, webform_document_file, webform_entity_checkboxes, webform_signature, webform_time) and the narrower `ALLOWED_TYPES_COMPARE` (date, datetime, number, webform_time).

---

- Require a "Confirm email" element to equal the "Email" element on a registration form.
- Make "Confirm password"-style paired fields match before a webform submits.
- Ensure two address or reference fields hold identical values.
- Validate that an end date is greater than a start date using the compare `>` rule.
- Require a maximum budget number to be greater than or equal to a minimum budget number.
- Enforce that a "children" count is less than a "total guests" count.
- Show a custom error message ("End date must be after start date") when a comparison fails.
- Require the user to complete at least 1 of two contact-method fields (phone or email).
- Require exactly 3 of 5 optional preference selections to be filled in.
- Require at most 2 of several add-on fields so users don't over-select.
- Run a "some of several" check only on the final confirmation page of a multi-step wizard.
- Compare two time elements so a finish time is later than a start time.
- Keep two email elements equal with case-insensitive comparison.
- Validate paired numeric ranges (min/max) on a quote-request form.
- Add matching-value validation to signature or document-upload elements.
- Force at least one of several file-upload elements to be provided.
- Ensure duplicate entry fields (e.g. re-enter account number) match.
- Add relational validation without writing any custom module code.
- Configure all rules directly in the Webform UI's element "Form extra validation" section.
- Combine equal + compare rules across different elements on one form.
- Standardise confirm-field validation patterns across many webforms.
- Gate submission of survey forms until a required subset of questions is answered.
- Validate that a "retype" field matches the original for critical inputs.
