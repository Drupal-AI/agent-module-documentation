<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Telephone Type extends the core Telephone field with an optional "type" selector, so a stored phone number can be labelled (for example mobile, home, work, fax). It provides the field type, widget, and formatter, and includes a validator service for the type value.

---

The module registers a telephone_type.validator service and a field type/widget/formatter built on top of core telephone + field. Editors enter a phone number and optionally choose its type from a configurable list; the formatter can render the number together with its type label.

Use it on contact profiles, directories, or commerce customer records where multiple phone numbers of different kinds must be captured on one entity. It is a pure field-type module with no routes, permissions, or external services — access follows the host entity's field access.

---

- Store a phone number together with its type.
- Label numbers as mobile, home, work, or fax.
- Extend the core Telephone field with a type selector.
- Provide a field widget for number + type entry.
- Format the number alongside its type label.
- Capture multiple phone kinds on one entity.
- Build richer contact/profile fields.
- Support directories and staff listings.
- Validate the selected telephone type.
- Configure the available type options.
- Reuse core telephone validation for the number.
- Add typed phone fields to commerce customers.
- Distinguish primary vs secondary numbers.
- Render typed phone numbers in view modes.
- Keep field access tied to the host entity.
- Avoid custom code for typed phone capture.
- Present clear phone-type context to visitors.
- Integrate typed phone data into templates.
