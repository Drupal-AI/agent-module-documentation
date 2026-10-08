<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Tax Number defines a field type and a matching webform element for storing tax/VAT numbers, with a pluggable validation system so each country's format can be checked by its own plugin.

---

Different countries have different tax-number formats (Spanish NIF/CIF, Portuguese NIF, etc.), and sites need to validate them at data entry. Tax Number provides a `tax_number` field type (`TaxNumberItem`) with a widget and default formatter, plus a `WebformTaxNumber` element/render element so the same validation works in webforms. Validation is delegated to `TaxNumberWidget` plugins managed by `TaxNumberWidgetManager`: the module ships `default_widget` (no country-specific check), `es_widget` (Spanish NIF/CIF checksum), and `pt_widget` (Portuguese NIF). You choose the validator per field in the form-display widget settings, or per element in webform element settings.

Each plugin extends `TaxNumberWidgetBase` and implements `validateTaxNumber($value)` returning TRUE/FALSE; the checks are pure PHP string/regex/checksum logic with no external service calls or network I/O. The module has no routes, permissions, or admin configuration of its own — it is field/webform infrastructure configured through the standard Field UI and Webform UI. Developers add support for another country by providing a new `TaxNumberWidget` plugin. There is no anonymous or mutating HTTP surface.

---

- Add a tax-number field to a content type.
- Validate a Spanish NIF/CIF at entry.
- Validate a Portuguese NIF at entry.
- Store a tax number without country validation (default widget).
- Choose the validation plugin in the field's form-display settings.
- Add a tax-number element to a webform.
- Choose the validator in the webform element settings.
- Display a stored tax number via the field formatter.
- Add support for a new country via a TaxNumberWidget plugin.
- Reuse the same validation logic in fields and webforms.
- Collect VAT numbers on a registration form.
- Reject malformed tax numbers on submit.
- Validate checksum digits for Spanish identifiers.
- Keep tax-number validation logic in versioned plugins.
- Apply the field to user or custom entities.
- Provide a consistent tax-number input across the site.
