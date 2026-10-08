<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform SWIFT/BIC Field

Adds a webform element, **Webform SWIFT/BIC field**, for collecting a bank
**SWIFT/BIC** code. On submit the value is validated with Symfony Validator's `Bic`
constraint; invalid codes block submission with an error naming the element. The element
extends the core Textfield element and supports single or multiple values. An example
webform (`webform_bic_field`) ships in config to demonstrate both variants.

---

## Summary

Two classes drive it: the Form API element
`Drupal\webform_bic_field\Element\WebformBicField` (extends core `Textfield`) declares the
`#element_validate` callback `validateWebformBIcField()`, which runs
`Validation::createValidator()->validate($value, [new Bic()])` and calls
`$form_state->setError()` when there are violations; and the webform plugin
`Drupal\webform_bic_field\Plugin\WebformElement\WebformBicField` (extends `TextBase`)
registers it as `@WebformElement id="webform_bic_field"` in the "Advanced elements"
category, with the usual text properties (`multiple`, `size`, `minlength`, `maxlength`,
`placeholder`). The pre-render outputs a standard text input with the `webform-bic-field`
class. There are no routes, permissions, or settings pages — you add the element to a webform
like any other.

---

## Use cases

- Collect a payee's bank BIC on a payment or reimbursement request form.
- Validate SWIFT/BIC format client-submissions before they reach staff.
- Add BIC capture to a supplier or vendor onboarding webform.
- Pair with an IBAN field to collect full international bank details.
- Require a valid BIC on an invoice or expense claim webform.
- Accept multiple BICs on one submission via the multiple-value variant.
- Reject typo'd or malformed BIC codes at submission time.
- Standardize bank-identifier data captured through Webform.
- Use in a membership form that stores a member's bank for direct debit.
- Gather BIC for cross-border payout setup in a contractor form.
- Build a "bank details" section combining BIC with account name fields.
- Demonstrate the element quickly using the shipped example webform.
- Enforce BIC presence with the element's required flag.
- Constrain input length/size using standard text element properties.
- Collect banking data in grant or scholarship application forms.
