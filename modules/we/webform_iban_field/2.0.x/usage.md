Webform IBAN Field adds a single Webform element, "Webform IBAN field", that collects an IBAN (bank account number) and validates it server-side with Symfony's IBAN validator, with optional multi-value support.

---

The module provides one Webform element plugin, `webform_iban_field`, registered under the "Advanced elements" category. Its render element (`src/Element/WebformIbanField.php`) extends core `Textfield` and renders as an `<input type="text">` with a `webform-iban-field` class; the Webform element plugin (`src/Plugin/WebformElement/WebformIbanField.php`) extends Webform's `TextBase`, so standard text properties (size, minlength, maxlength, placeholder, multiple) are available. Validation happens in `validateWebformIbanField()`: the submitted value is run through `Symfony\Component\Validator\Constraints\Iban`; anything the constraint rejects (or a literal `'0'`) fails with "The value %value for element %name is not a valid IBAN." Multiple values are supported via the element's `#multiple` property. The module ships a demonstration webform (`webform.webform.webform_iban_field`) containing a single and a multiple IBAN field. There is no admin settings page (`configure` is null), no permissions, no config schema of its own, and no Drush. Requires the Webform module (`^6.2`). Uses only PHP/Symfony validation — no external library or service.

---

- Collect a customer's IBAN on a contact or onboarding webform with proper validation.
- Reject malformed IBANs before a submission is saved.
- Collect several IBANs in one submission using the multi-value option.
- Add IBAN capture to a SEPA direct-debit mandate form.
- Gather bank details for a refund or reimbursement request form.
- Validate IBAN format for any country supported by the Symfony IBAN constraint.
- Provide a placeholder/hint (e.g. `NL91ABNA0417164300`) via the placeholder property.
- Constrain input length with minlength/maxlength text properties.
- Use the shipped demo webform (`webform_iban_field`) as a working example element setup.
- Add an IBAN field to a membership or subscription signup form.
- Capture payout details from freelancers/suppliers via a webform.
- Combine with Webform's conditional logic to show the IBAN field only when relevant.
- Include an IBAN in a grant/expense claim workflow form.
- Present a single IBAN field alongside other advanced Webform elements.
- Store validated IBANs in Webform submissions for export/handlers.
- Enforce server-side IBAN validity even if client-side checks are bypassed.
- Reuse the element across multiple webforms without extra configuration.
- Collect an IBAN as part of an event vendor registration form.
