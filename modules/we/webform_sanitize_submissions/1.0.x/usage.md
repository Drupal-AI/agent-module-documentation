<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Sanitize Submissions lets you flag specific Webform elements whose values should be wiped from the database once a submission has been processed, so sensitive data isn't retained after it has served its purpose.

---

The module adds a **Sanitize element value** checkbox to every Webform element's configuration form (a `sanitize` property, via `hook_webform_element_default_properties_alter()` and `hook_webform_element_configuration_form_alter()`), and warns on the element form if no sanitize handler has been added yet. The actual clearing is done by the **Sanitize submission** Webform handler (`sanitize_submission`, single-cardinality). In `postSave()`, for every element marked `#sanitize` it deletes the row from the `webform_submission_data` table (scoped by `sid` + element `name`), nulls the element on the submission object, and resets the submission storage cache — bypassing hooks so other handlers can still use the value earlier in the pipeline. If results are disabled for the webform, it does nothing.

Because sanitation runs after submission, you can still consume the value in handlers that run before the Sanitize handler (e.g. email the value, then delete it). Operationally: the deletes use parameterized `condition()` calls (no SQL concatenation) and the whole surface is Webform admin configuration. Typical setup: add the *Sanitize submission* handler to the webform, then tick *Sanitize element value* on each element you want cleared.

---

- Delete sensitive element values after a webform is submitted
- Email a value in a handler, then wipe it from storage
- Keep PII out of long-term webform submission storage
- Support data-minimization / GDPR retention practices
- Mark specific elements (e.g. credit card, SSN) for sanitation
- Add the Sanitize submission handler to a webform
- Get a warning when elements are flagged but no handler exists
- Clear a value while leaving other submission data intact
- Bypass hooks when deleting so earlier handlers still see the value
- Skip sanitation automatically when results are disabled
- Reduce exposure of sensitive fields in submission exports
- Sanitize file/text values captured only transiently
- Enforce a "process then forget" pattern for a payment field
- Configure sanitation per element in the element form's Advanced tab
- Combine with email handlers to notify before deletion
- Remove one element's data from the submission cache and DB
- Apply single-handler sanitation across a whole webform
