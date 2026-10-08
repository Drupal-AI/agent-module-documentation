<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Telephone Advanced teaches Drupal's core telephone field to actually validate and format numbers, using Google's libphonenumber (the `giggsey/libphonenumber-for-php` port) instead of a regular expression.

---

Core's telephone field stores a string and checks almost nothing, so a site ends up with `07700 900123`, `+447700900123` and `(0770) 090-0123` all meaning the same number and none of them comparable. Phone numbers are country-specific in length, prefixes and formatting, so this module wires libphonenumber into the existing field rather than shipping a new field type or widget. Per telephone field you turn on an "Enabled" flag and optionally set a default country, a whitelist of allowed countries, a whitelist of allowed line types (mobile, fixed line, toll-free, …) and a storage format; a `TelephoneAdvanced` validation constraint then rejects impossible numbers and out-of-scope countries/types on save, an overridden field-item class rewrites the stored value to the chosen storage format (e.g. canonical E164), and a "Formatted" display formatter renders the number in National/International/E164/RFC 3966 form, optionally as a `tel:` click-to-call link. The same validation and formatting can be applied to any `tel` form element via a `#telephone_advanced` property. Everything is per-field configuration — no routes, permissions or admin page. Requires core `telephone` and core `^10 || ^11`.

---

- Validate phone numbers per country using libphonenumber.
- Reject an impossible or malformed phone number at entry.
- Store numbers canonically in E164 so they are comparable.
- Display a stored number in national format.
- Restrict a field to mobile numbers only.
- Restrict a field to a set of allowed countries.
- Normalise numbers imported from a legacy system on next save.
- Format international numbers for display.
- De-duplicate contacts by normalising phone numbers.
- Add validation to an existing telephone field without a data migration.
- Avoid a brittle regex-based phone validator.
- Accept numbers typed in several input formats.
- Show a click-to-call `tel:` link on a rendered number.
- Support a multi-country customer base with one field.
- Detect toll-free, premium-rate or shared-cost numbers.
- Validate and reformat a `tel` element on a custom or webform form.
- Keep using core's telephone field and default widget.
- Reformat a display number to RFC 3966 for click-to-call.
- Enforce a default country when users omit the country code.
- Reuse the parser/validator/formatter services in custom code.
