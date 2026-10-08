<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Georgian Personal Number adds a Webform element for collecting a Georgian Personal ID number, validating it as an 11-digit numeric code with an input mask.
---
The module ships a `@FormElement('webform_georgian_personal_number')` extending core `Textfield` and a matching `@WebformElement` plugin that exposes it in the Webform element palette under the "Custom" category. The render element sets size 11, applies the Webform inputmask library with a mask of eleven digits, and its `#element_validate` handler fails with a configurable error message unless the submitted value matches `^\d{11}$`. The Webform element plugin adds an "Error message" setting shown when validation fails, alongside the usual size/length/placeholder properties.

There is no configuration UI or external service — it is a self-contained input element. Validation is purely a local regular expression on the submitted value; the module performs no network calls, stores no secrets, and sends no data anywhere. (Despite the project's broad description, this release only stores/validates/displays the number as a webform field; it does not integrate an external verification service.)

Setup: enable the module, edit a webform, add a new element and choose "Georgian Personal Number", optionally set a custom error message, and save. Submissions to that element are constrained to eleven digits.

---

- Collect a Georgian Personal ID number in a webform
- Validate input as an 11-digit numeric code
- Apply an input mask of eleven digits to the field
- Add the 'Georgian Personal Number' element to a webform
- Configure a custom validation error message
- Constrain submissions to the ^\d{11}$ pattern
- Expose the element in the Webform 'Custom' category
- Reuse standard textfield size/length/placeholder properties
- Provide a localized field for Georgian identity data
- Prevent malformed personal numbers at submission time
- Use the Webform inputmask library for guided entry
- Add the element via the webform element palette
- Show a friendly error when the number is invalid
- Keep validation local with no external verification calls
- Integrate Georgian ID collection into existing webforms
- Store the number as a plain webform submission value
