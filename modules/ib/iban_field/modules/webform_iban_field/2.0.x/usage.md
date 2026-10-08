<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform IBAN Field adds an IBAN element to Webform, so a form builder can drop a validated bank-account input into any webform the same way as an email or telephone element.

---

The submodule mirrors the parent module's field widget into Webform's own element system. It provides a `WebformIbanElement` render element (`src/Element/WebformIbanElement.php`) defining the form element itself, and a matching `WebformElement` plugin (`src/Plugin/WebformElement/WebformIbanElement.php`) that registers it in Webform's element library, gives it a label and category, and exposes its settings in the Webform UI. Validation is the same IBAN structure and checksum check the parent module applies, so a submitted value is a plausible account number rather than arbitrary text. Depending only on `webform` (and, in practice, on the parent module for the shared validation), it adds no configuration of its own, no permissions and no Drush commands — the element simply appears in the *Add element* dialog once the module is enabled.

---

- Collect bank details on a webform application.
- Add IBAN validation to a grant claim form.
- Capture refund account details from a public form.
- Provide an IBAN element alongside email and phone elements.
- Validate account numbers before a submission is stored.
- Reduce finance-team follow-up caused by typos.
- Add IBAN to a supplier onboarding webform.
- Collect SEPA mandate details.
- Reuse the same validation as entity forms.
- Configure the element's placeholder per form.
- Include IBAN in a multi-step webform wizard.
- Export the element as part of a webform's config.
- Collect expenses reimbursement details from staff.
- Add conditional logic around an IBAN element.
- Include the value in webform email handlers.
- Present a clearly labelled bank-details question.
- Support international applicants with IBAN rather than local formats.
- Improve data quality on payment-related submissions.
- Avoid writing a custom webform element.
- Roll out IBAN collection consistently across forms.
