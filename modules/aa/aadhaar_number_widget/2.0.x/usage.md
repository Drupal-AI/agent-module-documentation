A field widget that validates an Indian Aadhaar number (12-digit UIDAI ID) by format and Verhoeff checksum when a core string field is edited.

---

Aadhaar Number Widget adds one Field API widget plugin, `aadhaar_number_widget`, that attaches to core `string` fields. Rendered as a plain textfield (maxlength 14), it runs a `#element_validate` callback on submit: the value must match one of three formats — 12 contiguous digits, four-four-four groups separated by single spaces, or four-four-four groups separated by dashes — and must pass the Verhoeff checksum used by UIDAI-issued Aadhaar numbers. Values that fail either check block the entity save with an inline form error. The module has no formatter, no settings, no routes, no permissions, no config, and makes no external (UIDAI) calls; the entered digits are stored as-is by the underlying string field. Because Aadhaar is highly regulated personal identity data, site builders remain responsible for at-rest protection, field-level access control, and masked display.

---

- Add a plain text (string) field to a content type and validate it as an Aadhaar number.
- Ensure editors cannot save a node with a malformed Aadhaar number.
- Reject Aadhaar numbers that fail the Verhoeff checksum (typos, transposed digits).
- Accept Aadhaar input in bare 12-digit form, e.g. `999941057058`.
- Accept Aadhaar input in space-grouped form, e.g. `9999 4105 7058`.
- Accept Aadhaar input in dash-grouped form, e.g. `9999-4105-7058`.
- Capture a customer's Aadhaar number on a registration or KYC content type.
- Collect Aadhaar numbers on a user profile field (string base/bundle field) with checksum enforcement.
- Standardize Aadhaar data entry across editors by enforcing one of three canonical formats.
- Prevent copy-paste errors in Aadhaar numbers at data-entry time rather than after storage.
- Validate Aadhaar numbers in a webform-adjacent workflow by using a string field on an entity form.
- Build an Indian citizen/beneficiary directory where each record carries a checked Aadhaar number.
- Add Aadhaar validation to an existing string field simply by switching its form-display widget.
- Give content moderators immediate inline feedback on invalid Aadhaar entries.
- Reduce downstream data-cleaning by blocking invalid IDs before they enter the database.
- Support multiple Aadhaar fields on the same bundle, each independently validated.
- Use as a lightweight, dependency-free alternative to writing a custom constraint plugin.
- Serve government, NGO, healthcare, or fintech Drupal sites that record Aadhaar identifiers.
- Enforce format consistency for later export or integration with external UIDAI-aware systems.
- Provide a starting point that site builders combine with Field Encryption and Field Permissions for compliant PII handling.
- Localize data-entry forms for Indian audiences that expect grouped-digit Aadhaar entry.
- Catch obviously fake 12-digit sequences (e.g. `999941057057`) that pass length but fail the checksum.
