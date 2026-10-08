<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
IBAN Field provides an IBAN widget for core single-line text (`string`) fields — a size- and placeholder-configurable input that validates International Bank Account Numbers and uppercases them on save — plus a matching Webform element in a submodule.

---

Collecting bank details in Drupal usually means a plain text field and hoping the value is right. This module adds an `iban_field` field **widget** (for the core `string` field type) that presents the value as an IBAN input with two settings, `size` (the textfield width) and `placeholder`, both declared in `config/schema/iban_field.schema.yml` so they export cleanly with the form display. On submit the static `IbanFieldWidget::validateIbanElement()` handler runs Symfony's `Iban` constraint, checking the country prefix, the country-specific length and the mod-97 checksum, so obviously wrong account numbers are rejected at form submission rather than discovered by a failed payment run; valid values are normalised to uppercase before storage. It defines no field type and no formatter, so values live in an ordinary `string` field and display through that field's usual formatter. The `webform_iban_field` submodule brings the same validation to Webform via a `WebformIbanElement` render element and matching `WebformElement` plugin. There is no configuration form, no permissions and no Drush; you enable the module and choose the widget on a field's form display. Because validation is attached to the widget's form element, values written via REST/JSON:API or code are not IBAN-checked at the storage layer.

---

- Collect a supplier's bank account number on a content edit form.
- Validate IBAN format before storing payment details.
- Add an IBAN field to a user profile.
- Reject mistyped account numbers at entry time.
- Normalise entered IBANs to uppercase automatically.
- Standardise IBAN entry across several forms.
- Set a country-specific placeholder to guide users.
- Control the input width for long IBANs via the size setting.
- Capture SEPA payment details for direct debits.
- Add IBAN to a grant application content type.
- Store an IBAN on a commerce customer profile.
- Reduce failed payments caused by typos.
- Provide consistent IBAN presentation in editorial forms.
- Export the widget settings as configuration.
- Collect refund details from a claim form.
- Add IBAN validation without writing a custom constraint plugin.
- Reuse the same validation on webforms via the submodule.
- Support international account numbers rather than local formats.
- Improve data quality in finance-related workflows.
- Give editors a clearly labelled bank-details input.
