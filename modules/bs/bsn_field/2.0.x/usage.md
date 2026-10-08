<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
BSN defines a Drupal field type for Dutch BSN numbers (Burgerservicenummer — citizen service number), validating entered values against a modified “elfproef” checksum.

The module provides a `bsn` field type (`Plugin/Field/FieldType/BSNItem`) with a default widget (`BSNDefaultWidget`), reuses the core `string` formatter (registered via `hook_field_formatter_info_alter`), a form element (`Element/BSNElement`, a validated textfield), and a Webform element (`Plugin/WebformElement/BSNField`) so BSNs can be collected in Webforms too. Validation runs through `_bsn_field_elfproef()`: it reverses the digits, applies the eleven-test weighting (last digit multiplied by -1), and requires the sum to be divisible by 11 with the number's magnitude in the plausible BSN range.

Typical setup: enable the module (requires core Field), add a field of type “BSN” to an entity or add a BSN element to a Webform, and BSN validation applies automatically.

---

Short summary: a validated Dutch-BSN field type (and Webform element) using the elfproef checksum.

It solves storing and validating BSN numbers correctly rather than as free text, catching typos and invalid numbers at entry time. It works via a field-type plugin with a validation constraint, a reusable render element, and a Webform element, all backed by the `_bsn_field_elfproef()` checksum helper.

Operationally there are no routes or permissions — it is purely a field/element provider. Note the module validates format only; a BSN is personal data, so handle stored values under the site's privacy/GDPR obligations (field-level access, encryption) as appropriate.

---

- Add a BSN field to a content type or other entity.
- Validate BSN input with the elfproef checksum at entry.
- Reject malformed or invalid BSN numbers on form submit.
- Collect BSN numbers in a Webform via the BSN element.
- Display stored BSNs with the standard string formatter.
- Use the provided BSN form element in custom forms.
- Store citizen service numbers in a typed field instead of plain text.
- Ensure only plausible-range BSN values are accepted.
- Attach BSN validation to registration or intake forms.
- Reuse the field across multiple content types.
- Prevent common data-entry typos in BSN capture.
- Build Dutch government / healthcare intake forms with valid BSNs.
- Combine with field-level access control to protect the BSN value.
- Add the BSN widget to an entity form display.
- Extend or wrap `_bsn_field_elfproef()` for custom checks.
- Migrate existing BSN text values into the typed field.
