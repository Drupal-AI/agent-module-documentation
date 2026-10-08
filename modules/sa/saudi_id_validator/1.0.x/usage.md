<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Saudi ID Validator checks Saudi National ID / Iqama numbers via a service, Form API validator and entity constraint.

---

Saudi ID Validator validates Saudi National ID and Iqama (residency permit) numbers entirely offline — checking format, number type, and the official checksum — through one reusable service exposed as a Form API validator and an entity field constraint. It lets forms and entities reject invalid IDs without contacting an external service.

Administration is gated by `administer saudi id validator`. Validation is local (no external calls), which keeps ID data on the server. Supports Drupal 10.3+ and 11.

---

- Validate Saudi National IDs.
- Validate Iqama numbers.
- Check format and type.
- Verify the official checksum.
- Validate entirely offline.
- Provide a reusable service.
- Offer a Form API validator.
- Offer an entity constraint.
- Reject invalid IDs.
- Avoid external calls.
- Keep ID data on the server.
- Gate admin with `administer saudi id validator`.
- Support Drupal 10.3+ and 11.
- Underpin domain_availability.
- Validate on forms and entities.
- Support Saudi-specific data.
- Provide one validation service.
- Ensure ID correctness.
